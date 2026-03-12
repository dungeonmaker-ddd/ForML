"""
预处理的最后一步: StandardScaler 标准化
以及: 预处理前后对 KNN 准确率的实际影响
"""
import numpy as np
from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsClassifier

digits = load_digits()
X, y = digits.data, digits.target

# ========== 展示 StandardScaler 做了什么 ==========
print("=== StandardScaler 做了什么? ===")
print("公式: x_new = (x - mean) / std")
print("效果: 每个特征(像素位置)的均值变成0, 标准差变成1\n")

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X.astype(float))

# 拿第一个样本对比
sample_raw = X[0]
sample_scaled = X_scaled[0]

print("像素位置 |  原始值  | 标准化后 |  该位置均值 | 该位置标准差")
print("-" * 65)
for i in [0, 1, 20, 21, 27, 28, 35, 36]:
    print(f"  [{i:2d}]    |  {sample_raw[i]:5.1f}  |  {sample_scaled[i]:6.2f}  "
          f"|   {scaler.mean_[i]:5.2f}   |   {scaler.scale_[i]:5.2f}")

print(f"\n原始值范围:   [{X[0].min():.0f}, {X[0].max():.0f}]")
print(f"标准化后范围: [{X_scaled[0].min():.2f}, {X_scaled[0].max():.2f}]")

# ========== 关键: 为什么要标准化? ==========
print("\n=== 为什么 KNN 需要标准化? ===")
print("不同像素位置的值分布不同:")
print(f"  像素[0]  (左上角): 均值={scaler.mean_[0]:.2f}, "
      f"标准差={scaler.scale_[0]:.2f}  <- 几乎没墨水")
print(f"  像素[28] (中间):   均值={scaler.mean_[28]:.2f}, "
      f"标准差={scaler.scale_[28]:.2f}  <- 经常有墨水")
print("不标准化 → 中间像素主导距离计算，边缘像素被忽略")
print("标准化后 → 每个像素位置对距离的贡献均等")

# ========== 实测: 标准化 vs 不标准化 ==========
print("\n=== 实测: 标准化对 KNN 准确率的影响 ===")
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=22
)

# 不标准化
knn_raw = KNeighborsClassifier(n_neighbors=3)
knn_raw.fit(X_train, y_train)
score_raw = knn_raw.score(X_test, y_test)

# 标准化
scaler = StandardScaler()
X_train_s = scaler.fit_transform(X_train)
X_test_s = scaler.transform(X_test)

knn_scaled = KNeighborsClassifier(n_neighbors=3)
knn_scaled.fit(X_train_s, y_train)
score_scaled = knn_scaled.score(X_test_s, y_test)

print(f"不标准化: {score_raw:.4f}")
print(f"标准化后: {score_scaled:.4f}")
print(f"差异:     {score_scaled - score_raw:+.4f}")

# ========== 聚焦 8/6/9 的混淆 ==========
print("\n=== 聚焦: 8/6/9 的混淆情况 ===")
from sklearn.metrics import confusion_matrix

mask = np.isin(y_test, [6, 8, 9])
y_sub = y_test[mask]

# 不标准化
pred_raw = knn_raw.predict(X_test[mask])
cm_raw = confusion_matrix(y_sub, pred_raw, labels=[6, 8, 9])

# 标准化
pred_scaled = knn_scaled.predict(X_test_s[mask])
cm_scaled = confusion_matrix(y_sub, pred_scaled, labels=[6, 8, 9])

print("不标准化 - 混淆矩阵 (行=真实, 列=预测):")
print("       6   8   9")
for i, label in enumerate([6, 8, 9]):
    print(f"  {label}:  {cm_raw[i]}")

print("\n标准化后 - 混淆矩阵:")
print("       6   8   9")
for i, label in enumerate([6, 8, 9]):
    print(f"  {label}:  {cm_scaled[i]}")
