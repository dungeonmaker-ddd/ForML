"""
噪声对手写数字识别的影响

问题1: 噪声干扰居中 — 噪声像素被当成数字的一部分，重心偏移
问题2: 噪声干扰距离 — 8/6/9 本来就长得像，加点噪声距离就乱了
"""
import numpy as np

# ========== 构造干净的 8, 6, 9 ==========
eight = np.array([
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 15, 15, 15, 0, 0, 0],
    [0, 0, 15, 0, 15, 0, 0, 0],
    [0, 0, 15, 15, 15, 0, 0, 0],
    [0, 0, 15, 0, 15, 0, 0, 0],
    [0, 0, 15, 15, 15, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
])

six = np.array([
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 15, 15, 15, 0, 0, 0],
    [0, 0, 15, 0, 0, 0, 0, 0],
    [0, 0, 15, 15, 15, 0, 0, 0],
    [0, 0, 15, 0, 15, 0, 0, 0],
    [0, 0, 15, 15, 15, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
])

nine = np.array([
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 15, 15, 15, 0, 0, 0],
    [0, 0, 15, 0, 15, 0, 0, 0],
    [0, 0, 15, 15, 15, 0, 0, 0],
    [0, 0, 0, 0, 15, 0, 0, 0],
    [0, 0, 15, 15, 15, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
])

def show(name, img):
    print(f"\n{name}:")
    for row in img:
        print(" ".join("#" if p > 0 else "." for p in row))

def center_of_mass(img):
    """计算墨水像素的重心 — 居中算法的核心"""
    total = img.sum()
    if total == 0:
        return (4, 4)
    rows, cols = np.indices(img.shape)
    cy = (rows * img).sum() / total
    cx = (cols * img).sum() / total
    return (round(cy, 2), round(cx, 2))

def dist(a, b):
    return np.sqrt(np.sum((a.flatten().astype(float)
                         - b.flatten().astype(float)) ** 2))

show("干净的8", eight)
show("干净的6", six)
show("干净的9", nine)

# ========== 干净状态下的距离 ==========
print("\n=== 干净状态: 距离对比 ===")
print(f"8 vs 6: {dist(eight, six):.2f}")
print(f"8 vs 9: {dist(eight, nine):.2f}")
print(f"6 vs 9: {dist(six, nine):.2f}")
print("8/6/9 之间距离本来就很近!")
