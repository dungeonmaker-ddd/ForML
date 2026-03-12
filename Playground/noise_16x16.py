"""
16x16 分辨率下的 8/6/9 噪声实验
像素多了4倍，单个噪声点的影响会被稀释吗？
"""
import numpy as np
from sklearn.neighbors import KNeighborsClassifier

def make_eight_16():
    """16x16 的数字 8: 上下两个圈"""
    img = np.zeros((16, 16))
    # 上圈
    for c in range(5, 11): img[2, c] = 15   # 顶横
    for c in range(5, 11): img[7, c] = 15   # 中横
    for r in range(2, 8):  img[r, 5] = 15   # 左竖
    for r in range(2, 8):  img[r, 10] = 15  # 右竖
    # 下圈
    for c in range(5, 11): img[12, c] = 15  # 底横
    for r in range(7, 13): img[r, 5] = 15   # 左竖
    for r in range(7, 13): img[r, 10] = 15  # 右竖
    return img

def make_six_16():
    """16x16 的数字 6: 上开口 + 下闭合"""
    img = np.zeros((16, 16))
    # 上半: 只有左竖 + 顶横 (右边开口)
    for c in range(5, 11): img[2, c] = 15
    for r in range(2, 8):  img[r, 5] = 15
    # 中横
    for c in range(5, 11): img[7, c] = 15
    # 下圈: 完整闭合
    for c in range(5, 11): img[12, c] = 15
    for r in range(7, 13): img[r, 5] = 15
    for r in range(7, 13): img[r, 10] = 15
    return img

def make_nine_16():
    """16x16 的数字 9: 上闭合 + 下开口"""
    img = np.zeros((16, 16))
    # 上圈: 完整闭合
    for c in range(5, 11): img[2, c] = 15
    for c in range(5, 11): img[7, c] = 15
    for r in range(2, 8):  img[r, 5] = 15
    for r in range(2, 8):  img[r, 10] = 15
    # 下半: 只有右竖 + 底横 (左边开口)
    for c in range(5, 11): img[12, c] = 15
    for r in range(7, 13): img[r, 10] = 15
    return img

def show(name, img):
    print(f"\n{name}:")
    for row in img:
        print(" ".join("#" if p > 0 else "." for p in row))

def dist(a, b):
    return np.sqrt(np.sum((a.astype(float) - b.astype(float)) ** 2))

eight = make_eight_16()
six   = make_six_16()
nine  = make_nine_16()

show("8 (16x16)", eight)
show("6 (16x16)", six)
show("9 (16x16)", nine)

print("\n=== 干净距离 ===")
print(f"8 vs 6: {dist(eight, six):.2f}")
print(f"8 vs 9: {dist(eight, nine):.2f}")
print(f"6 vs 9: {dist(six, nine):.2f}")
