"""
问题1: 居中检测是怎么做的？
答: 在展平之前，用二维图像计算重心，然后平移

问题2: 四不像数字会怎样？
答: KNN 永远会给答案，哪怕输入是垃圾
"""
import numpy as np
from sklearn.datasets import load_digits
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split

digits = load_digits()

def show(name, img):
    print(f"\n{name}:")
    for row in img:
        print(" ".join("#" if v > 4 else "." for v in row))

def center_of_mass(img):
    """重心 = 所有墨水像素的加权平均位置"""
    total = img.sum()
    if total == 0:
        return (img.shape[0]//2, img.shape[1]//2)
    rows, cols = np.indices(img.shape)
    cy = (rows * img).sum() / total  # 行方向重心
    cx = (cols * img).sum() / total  # 列方向重心
    return (cy, cx)

def center_image(img):
    """把数字移到图片中心"""
    target_cy, target_cx = img.shape[0]/2, img.shape[1]/2
    cy, cx = center_of_mass(img)
    # 需要平移多少
    shift_y = int(round(target_cy - cy))
    shift_x = int(round(target_cx - cx))
    # 执行平移
    result = np.zeros_like(img)
    for r in range(img.shape[0]):
        for c in range(img.shape[1]):
            nr, nc = r + shift_y, c + shift_x
            if 0 <= nr < img.shape[0] and 0 <= nc < img.shape[1]:
                result[nr, nc] = img[r, c]
    return result, (cy, cx), (shift_y, shift_x)

# ========== 演示: 居中检测流程 ==========
print("=" * 55)
print("问题1: 如何检测图片不居中？")
print("=" * 55)
print("\n答: 居中是在二维阶段做的，不是展平后做的！")
print("流程: 二维图像 → 计算重心 → 平移居中 → 然后才展平")

# 构造一个偏左上的 "1"
off_center = np.zeros((8, 8))
off_center[0, 1] = 12
off_center[1, 1] = 15
off_center[2, 1] = 15
off_center[3, 1] = 15
off_center[4, 1] = 12

show("偏左上的 '1' (原始)", off_center)
cy, cx = center_of_mass(off_center)
print(f"重心位置: ({cy:.1f}, {cx:.1f})")
print(f"图片中心: (4.0, 4.0)")
print(f"偏移量:   行偏了{4-cy:.1f}, 列偏了{4-cx:.1f}")

centered, (cy, cx), (sy, sx) = center_image(off_center)
show("居中后的 '1'", centered)
cy2, cx2 = center_of_mass(centered)
print(f"新重心: ({cy2:.1f}, {cx2:.1f})  接近中心了")

print("\n关键: 整个过程都在二维下完成")
print("  1. 拿到原始图片 (二维)")
print("  2. 计算墨水重心 (二维坐标)")
print("  3. 平移到中心   (二维操作)")
print("  4. 最后才展平   (变成一维给KNN)")
