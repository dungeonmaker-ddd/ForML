"""
8x8 放大到 28x28: 插值过程 + 和真实28x28的对比
"""
import numpy as np
from sklearn.datasets import load_digits

digits = load_digits()
idx_8 = np.where(digits.target == 8)[0][0]
small = digits.images[idx_8]  # 8x8

# ========== 最近邻插值: 每个像素变成3.5x3.5块 ==========
def nearest_resize(img, target_h, target_w):
    """最近邻插值 — 最简单的放大方式"""
    h, w = img.shape
    result = np.zeros((target_h, target_w))
    for r in range(target_h):
        for c in range(target_w):
            src_r = int(r * h / target_h)
            src_c = int(c * w / target_w)
            result[r, c] = img[src_r, src_c]
    return result

# ========== 双线性插值: 更平滑的放大 ==========
def bilinear_resize(img, target_h, target_w):
    """双线性插值 — 像素之间做线性过渡"""
    h, w = img.shape
    result = np.zeros((target_h, target_w))
    for r in range(target_h):
        for c in range(target_w):
            src_r = r * (h - 1) / (target_h - 1)
            src_c = c * (w - 1) / (target_w - 1)
            r0, c0 = int(src_r), int(src_c)
            r1 = min(r0 + 1, h - 1)
            c1 = min(c0 + 1, w - 1)
            dr, dc = src_r - r0, src_c - c0
            val = (img[r0, c0] * (1-dr) * (1-dc) +
                   img[r1, c0] * dr * (1-dc) +
                   img[r0, c1] * (1-dr) * dc +
                   img[r1, c1] * dr * dc)
            result[r, c] = val
    return result

chars = "  .:-=+*#%@"
def ascii(img, vmax=16):
    lines = []
    for row in img:
        line = ""
        for v in row:
            ci = int(v / vmax * (len(chars) - 1))
            ci = max(0, min(ci, len(chars) - 1))
            line += chars[ci]
        lines.append(line)
    return lines

# ========== 原始 8x8 ==========
print("=" * 60)
print("原始 8x8 (我们一直在用的这个8)")
print("=" * 60)
for line in ascii(small):
    print(line)
print(f"像素数: {small.size}, 值范围: [{small.min():.0f}, {small.max():.0f}]")

# ========== 最近邻放大到 28x28 ==========
big_nearest = nearest_resize(small, 28, 28)
print("\n" + "=" * 60)
print("最近邻插值放大到 28x28")
print("每个原始像素变成 ~3.5x3.5 的方块")
print("=" * 60)
for line in ascii(big_nearest):
    print(line)
print(f"像素数: {big_nearest.size}")
print("问题: 锯齿明显, 边缘是阶梯状的方块")
