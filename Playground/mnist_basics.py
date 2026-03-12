"""
手写数字识别 — 从零开始理解
核心问题：一张图片如何变成模型能处理的数据？

28x28像素 → 展平为784维向量 → 每个像素就是一个特征
像素值 0=白(无墨水)  255=黑(满墨水)

KNN思路：计算未知图片与所有训练图片的784维距离，取最近K个投票
"""
from sklearn.datasets import fetch_openml
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsClassifier
import numpy as np

# ========== Step 1: 获取数据 ==========
# sklearn内置的MNIST子集(1797张 8x8图片)，比完整版小，适合学习
from sklearn.datasets import load_digits

digits = load_digits()

print("=== 数据结构 ===")
print(f"样本数: {digits.data.shape[0]}")
print(f"每个样本特征数: {digits.data.shape[1]}")
print(f"图片尺寸: {digits.images[0].shape}")  # 8x8
print(f"标签种类: {np.unique(digits.target)}")  # 0-9
print(f"第一张图的像素值:\n{digits.images[0]}")

# ========== Step 2: 看一眼数据长什么样 ==========
# 像素矩阵 → 数字的视觉化理解
print("\n=== 第一张图(文本可视化) ===")
img = digits.images[0]
for row in img:
    print(" ".join(f"{int(p):2d}" for p in row))
print(f"标签: {digits.target[0]}")

# ========== Step 3: 标准ML Pipeline ==========
# 划分 → 标准化 → 训练 → 评估
X_train, X_test, y_train, y_test = train_test_split(
    digits.data, digits.target, test_size=0.2, random_state=22
)

scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)  # 训练集: fit + transform
X_test = scaler.transform(X_test)        # 测试集: 只transform (铁律)

knn = KNeighborsClassifier(n_neighbors=3)
knn.fit(X_train, y_train)

score = knn.score(X_test, y_test)
print(f"\n=== KNN(K=3) 准确率: {score:.4f} ===")

# ========== Step 4: 看看预测对了哪些、错了哪些 ==========
y_pred = knn.predict(X_test)
wrong = np.where(y_pred != y_test)[0]
print(f"总测试样本: {len(y_test)}, 预测错误: {len(wrong)}")
if len(wrong) > 0:
    i = wrong[0]
    print(f"第一个错误: 真实={y_test[i]}, 预测={y_pred[i]}")
