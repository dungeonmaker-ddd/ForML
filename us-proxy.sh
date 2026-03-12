#!/bin/bash
# 美国 SOCKS5 代理一键脚本（带 SSH 保护）
# 用法: sudo bash us-proxy.sh
# 代理地址: socks5://服务器IP:1080

set -e

TB_EMAIL="你的TunnelBear邮箱"
TB_PASS="你的TunnelBear密码"
PROXY_PORT=1080
OVPN_DIR="$HOME/tunnelbear-ovpn/openvpn"
OVPN_CONF="TunnelBear United States East.ovpn"

# ============ 保护机制 ============

# 保存 VPN 启动前的默认路由（用于自动恢复）
ORIG_GATEWAY=$(ip route | grep '^default' | head -1)
ORIG_GW_IP=$(echo "$ORIG_GATEWAY" | awk '{print $3}')
ORIG_GW_DEV=$(echo "$ORIG_GATEWAY" | awk '{print $5}')
echo "[保护] 原始网关: $ORIG_GW_IP via $ORIG_GW_DEV"

# 获取 SSH 客户端 IP，给它加一条静态路由（绕过 VPN）
SSH_CLIENT_IP=$(echo "$SSH_CONNECTION" | awk '{print $1}')
if [ -n "$SSH_CLIENT_IP" ]; then
    ip route add "$SSH_CLIENT_IP/32" via "$ORIG_GW_IP" dev "$ORIG_GW_DEV" 2>/dev/null || true
    echo "[保护] SSH 客户端 $SSH_CLIENT_IP 已锁定走原网关"
fi

# 写入路由恢复脚本（万一断了，通过控制台跑这个）
cat > /tmp/fix-route.sh << FIXEOF
#!/bin/bash
killall openvpn 2>/dev/null
killall microsocks 2>/dev/null
ip route del default dev tun0 2>/dev/null
ip route replace default via $ORIG_GW_IP dev $ORIG_GW_DEV
echo "路由已恢复: default via $ORIG_GW_IP dev $ORIG_GW_DEV"
FIXEOF
chmod +x /tmp/fix-route.sh
echo "[保护] 恢复脚本已写入: /tmp/fix-route.sh"

# 后台看门狗：每 5 秒检测默认路由，如果被改就自动恢复
(
    while true; do
        sleep 5
        CURRENT_GW=$(ip route | grep '^default' | head -1 | awk '{print $3}')
        CURRENT_DEV=$(ip route | grep '^default' | head -1 | awk '{print $5}')
        if [ "$CURRENT_DEV" = "tun0" ]; then
            echo "[看门狗] 检测到全局路由被 VPN 劫持，自动恢复..."
            ip route replace default via "$ORIG_GW_IP" dev "$ORIG_GW_DEV"
            echo "[看门狗] 路由已恢复: default via $ORIG_GW_IP dev $ORIG_GW_DEV"
        fi
    done
) &
WATCHDOG_PID=$!
echo "[保护] 看门狗已启动 (PID: $WATCHDOG_PID)"

# ============ 正常安装流程 ============

echo "[1/6] 安装依赖..."
apt update -qq
apt install -y -qq openvpn unzip wget git make gcc > /dev/null 2>&1

echo "[2/6] 下载 TunnelBear 配置..."
if [ ! -d "$OVPN_DIR" ]; then
    cd /tmp && wget -q https://tunnelbear.s3.amazonaws.com/support/linux/openvpn.zip
    unzip -o -q openvpn.zip -d "$HOME/tunnelbear-ovpn"
fi

echo "[3/6] 编译 microsocks..."
if ! command -v microsocks &>/dev/null; then
    cd /tmp
    rm -rf microsocks
    git clone -q https://github.com/rofl0r/microsocks.git
    cd microsocks && make -s && cp microsocks /usr/local/bin/
fi

echo "[4/6] 写入凭证..."
cat > /tmp/tb-auth.txt << EOF
$TB_EMAIL
$TB_PASS
EOF
chmod 600 /tmp/tb-auth.txt

echo "[5/6] 启动 VPN（不改全局路由）..."
killall openvpn 2>/dev/null || true
killall microsocks 2>/dev/null || true
sleep 1

cd "$OVPN_DIR"
openvpn --config "$OVPN_CONF" \
    --auth-user-pass /tmp/tb-auth.txt \
    --route-nopull \
    --daemon --log /tmp/vpn.log

echo "    等待 VPN 连接..."
for i in $(seq 1 20); do
    if ip addr show tun0 &>/dev/null; then
        break
    fi
    sleep 1
done

if ! ip addr show tun0 &>/dev/null; then
    echo "[ERROR] VPN 连接失败，查看日志: cat /tmp/vpn.log"
    kill $WATCHDOG_PID 2>/dev/null
    exit 1
fi

TUN_IP=$(ip -4 addr show tun0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
echo "    VPN 接口 IP: $TUN_IP"

# 验证默认路由没被改
AFTER_GW=$(ip route | grep '^default' | head -1 | awk '{print $3}')
if [ "$AFTER_GW" != "$ORIG_GW_IP" ]; then
    echo "[WARNING] 默认路由被修改，正在恢复..."
    ip route replace default via "$ORIG_GW_IP" dev "$ORIG_GW_DEV"
fi

echo "[6/6] 启动 SOCKS5 代理 (端口 $PROXY_PORT)..."
microsocks -i 0.0.0.0 -p $PROXY_PORT -b "$TUN_IP" -d

echo ""
echo "========================================="
echo "  代理已启动: socks5://0.0.0.0:$PROXY_PORT"
echo "  出口绑定: $TUN_IP (美国)"
echo "  SSH 保护: $SSH_CLIENT_IP 走原网关"
echo "  看门狗: PID $WATCHDOG_PID (自动恢复路由)"
echo "========================================="
echo ""
echo "测试:"
echo "  curl ifconfig.me                              # 应显示香港 IP"
echo "  curl --socks5 127.0.0.1:$PROXY_PORT ifconfig.me  # 应显示美国 IP"
echo ""
echo "停止:"
echo "  sudo killall microsocks openvpn; kill $WATCHDOG_PID"
echo ""
echo "紧急恢复（如果 SSH 断了，从控制台执行）:"
echo "  sudo bash /tmp/fix-route.sh"
