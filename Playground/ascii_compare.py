"""
标准化前后的数据 ASCII 可视化对比
同一张图片，看 StandardScaler 到底改变了什么
"""
import numpy as np
from sklearn.datasets import load_digits
from sklearn.preprocessing import StandardScaler

digits = load_digits()
X = digits.data.astype(float)

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

def ascii_art(img_1d, size=8, mode="raw"):
    """把一维向量还原成二维 ASCII 图"""
    img = img_1d.reshape(size, size)
    lines = []
    for row in img:
        line = ""
        if mode == "raw":
            # 原始值 0~16 映射到 ASCII 字符
            chars = "  .:-=+*#%@"
            for v in row:
                idx = int(v / 16 * (len(chars) - 1))
                idx = max(0, min(idx, len(chars) - 1))
                line += chars[idx] * 2
        elif mode == "scaled":
            # 标准化后值大约 -2~+2, 映射到 ASCII
            chars = "  .:-=+*#%@"
            for v in row:
                # 把 [-2, 2] 映射到 [0, len-1]
                idx = int((v + 2) / 4 * (len(chars) - 1))
                idx = max(0, min(idx, len(chars) - 1))
                line += chars[idx] * 2
        lines.append(line)
    return lines

# 挑几个有代表性的数字
samples = []
for digit in [0, 1, 3, 5, 8]:
    idx = np.where(digits.target == digit)[0][0]
    samples.append((digit, idx))

print("=" * 70)
print("  标准化前 (原始 0~16)          vs    标准化后 (StandardScaler)")
print("  空格=0  .=淡  :=弱  *=中  #=浓  @=满")
print("=" * 70)

for digit, idx in samples:
    raw_lines = ascii_art(X[idx], mode="raw")
    scaled_lines = ascii_art(X_scaled[idx], mode="scaled")

    print(f"\n--- 数字 '{digit}' ---")
    print(f"{'原始值':>20}  {'|':>4}  {'标准化后':<20}")
    for r, s in zip(raw_lines, scaled_lines):
        print(f"  {r}    |    {s}")

# ========== 数值对比: 同一行像素 ==========
print("\n" + "=" * 70)
print("数值对比: 数字 '8' 的第3行像素")
print("=" * 70)
idx_8 = np.where(digits.target == 8)[0][0]
row3_raw = X[idx_8].reshape(8, 8)[3]
row3_scaled = X_scaled[idx_8].reshape(8, 8)[3]

print(f"\n像素位置:    ", end="")
for i in range(8): print(f"[{3*8+i:2d}]  ", end="")

print(f"\n原始值:      ", end="")
for v in row3_raw: print(f"{v:5.1f} ", end="")

print(f"\n该位置均值:  ", end="")
for i in range(8): print(f"{scaler.mean_[3*8+i]:5.1f} ", end="")

print(f"\n该位置标准差:", end="")
for i in range(8): print(f"{scaler.scale_[3*8+i]:5.1f} ", end="")

print(f"\n标准化后:    ", end="")
for v in row3_scaled: print(f"{v:5.2f}", end="")

print("\n\n公式验证: (原始值 - 均值) / 标准差 = 标准化值")
i = 3 * 8 + 3  # 第3行第3列
print(f"  像素[{i}]: ({X[idx_8][i]:.1f} - {scaler.mean_[i]:.2f})"
      f" / {scaler.scale_[i]:.2f} = {X_scaled[idx_8][i]:.2f}")
