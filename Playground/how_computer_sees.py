"""
计算机怎么"看"图片？

人眼看到的: 8x8 的二维网格，有形状
计算机看到的: 64个数字排成一行，没有形状概念

关键: 展平(flatten)不丢失信息，只是丢失了"位置关系"
"""
from sklearn.datasets import load_digits
import numpy as np

digits = load_digits()

# ========== 人眼看到的 vs 计算机看到的 ==========
img_2d = digits.images[0]   # 人眼: 8x8 二维矩阵
vec_1d = digits.data[0]     # 计算机: 64维一维向量

print("=== 人眼看到的 (8x8 二维网格) ===")
print(f"shape: {img_2d.shape}")
for row in img_2d:
    print(" ".join(f"{int(p):2d}" for p in row))

print(f"\n=== 计算机看到的 (64维一维向量) ===")
print(f"shape: {vec_1d.shape}")
print(vec_1d)

# ========== 展平过程 ===========================
print("\n=== 展平过程: 第0行 + 第1行 + ... + 第7行 ===")
manual_flatten = img_2d.reshape(-1)  # 等价于 img_2d.flatten()
print(f"第0行: {img_2d[0]}  (像素0-7)")
print(f"第1行: {img_2d[1]}  (像素8-15)")
print(f"...")
print(f"第7行: {img_2d[7]}  (像素56-63)")
print(f"\n拼起来和data[0]一样吗? {np.array_equal(manual_flatten, vec_1d)}")

# ========== KNN 眼中的"距离" ======================
print("\n=== KNN 怎么比较两张图 ===")
# 取一张 "0" 和一张 "1"
idx_0 = np.where(digits.target == 0)[0][0]
idx_1 = np.where(digits.target == 1)[0][0]
idx_0b = np.where(digits.target == 0)[0][1]  # 另一张 "0"

vec_a = digits.data[idx_0]    # 第一张 "0"
vec_b = digits.data[idx_0b]   # 第二张 "0"
vec_c = digits.data[idx_1]    # 一张 "1"

# 欧氏距离: sqrt(sum((a-b)^2))
d_same = np.sqrt(np.sum((vec_a - vec_b) ** 2))
d_diff = np.sqrt(np.sum((vec_a - vec_c) ** 2))

print(f'"0" vs "0" 距离: {d_same:.2f}  (同类，近)')
print(f'"0" vs "1" 距离: {d_diff:.2f}  (异类，远)')
print(f'距离比: {d_diff/d_same:.2f}x')

# ========== 关键: predict 输入的是一维向量 =========
print("\n=== predict 接收的是什么? ===")
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(
    digits.data, digits.target, test_size=0.2, random_state=22
)
knn = KNeighborsClassifier(n_neighbors=3)
knn.fit(X_train, y_train)

sample = X_test[0:1]  # 取一个测试样本 (必须二维: 1行64列)
print(f"输入 shape: {sample.shape}  -> 1个样本, 64个特征")
print(f"输入数据: {sample[0][:10]}... (只显示前10个像素)")
pred = knn.predict(sample)
print(f"预测结果: {pred[0]}")
print(f"真实标签: {y_test[0]}")
print(f"\nKNN 从头到尾只看到64个数字，从不知道它们原来排成8x8")
