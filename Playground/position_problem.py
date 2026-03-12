"""
位置和大小对KNN的致命影响

同一个数字 "1"：
- 写在中间，大字 → 一组像素值
- 写在左上角，小字 → 完全不同的像素值
展平后的64维向量天差地别，KNN会认为它们是不同的东西
"""
import numpy as np
from sklearn.neighbors import KNeighborsClassifier

# ========== 手工构造: 同一个数字"1"，不同位置和大小 ==========

# 数字"1" 写在中间，比较大
one_center_big = np.array([
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 15, 0, 0, 0, 0],
    [0, 0, 0, 15, 0, 0, 0, 0],
    [0, 0, 0, 15, 0, 0, 0, 0],
    [0, 0, 0, 15, 0, 0, 0, 0],
    [0, 0, 0, 15, 0, 0, 0, 0],
    [0, 0, 0, 15, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
])

# 同样的"1" 写在左上角，比较小
one_topleft_small = np.array([
    [0, 15, 0, 0, 0, 0, 0, 0],
    [0, 15, 0, 0, 0, 0, 0, 0],
    [0, 15, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
])

# 数字"0" 写在中间
zero_center = np.array([
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 15, 15, 15, 0, 0, 0],
    [0, 0, 15, 0, 15, 0, 0, 0],
    [0, 0, 15, 0, 15, 0, 0, 0],
    [0, 0, 15, 0, 15, 0, 0, 0],
    [0, 0, 15, 15, 15, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
])

def show(name, img):
    print(f"\n{name}:")
    for row in img:
        print(" ".join("#" if p > 0 else "." for p in row))

show("1-中间大字", one_center_big)
show("1-左上小字", one_topleft_small)
show("0-中间", zero_center)

# ========== 展平后计算距离 ==========
v_1_center = one_center_big.flatten().astype(float)
v_1_topleft = one_topleft_small.flatten().astype(float)
v_0_center = zero_center.flatten().astype(float)

d_same_digit = np.sqrt(np.sum((v_1_center - v_1_topleft) ** 2))
d_diff_digit = np.sqrt(np.sum((v_1_center - v_0_center) ** 2))

print("\n=== 距离对比 (问题暴露) ===")
print(f'"1中间" vs "1左上": {d_same_digit:.2f}  (同一个数字!)')
print(f'"1中间" vs "0中间": {d_diff_digit:.2f}  (不同数字)')

if d_same_digit > d_diff_digit:
    print("\n--> 同一个数字因为位置不同，距离反而更远!")
    print("--> KNN会认为中间的1和中间的0更像，而不是和左上的1更像")
    print("--> 这就是你说的问题: 展平成一行后，位置信息变成了噪声")
else:
    print(f"\n--> 距离比: 同数字/异数字 = {d_same_digit/d_diff_digit:.2f}")

# ========== 用KNN验证: 它真的会判错 ==========
print("\n=== KNN实测 ===")
X_train = np.array([v_1_center, v_0_center])  # 训练集: 中间的1, 中间的0
y_train = np.array([1, 0])

knn = KNeighborsClassifier(n_neighbors=1)
knn.fit(X_train, y_train)

pred = knn.predict([v_1_topleft])
print(f"输入: 左上角的小字1")
print(f"KNN预测: {pred[0]}")
print(f"正确答案: 1")
print(f"预测{'正确' if pred[0] == 1 else '错误! KNN被位置差异骗了'}")
