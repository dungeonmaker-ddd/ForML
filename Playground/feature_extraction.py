"""
用N个特征区分10个数字 — 从64维降到最少几维能行？
"""
import numpy as np
from sklearn.datasets import load_digits
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split

digits = load_digits()

# ========== 手工设计特征: 从64像素提取关键信号 ==========
print("=" * 60)
print("手工特征: 从8x8图片提取N个关键数字")
print("=" * 60)

def extract_features(X):
    """从64维像素提取手工特征"""
    features = []
    for sample in X:
        img = sample.reshape(8, 8)
        f = []

        # 特征1: 上半部分墨水量 (区分1/7 vs 0/8)
        f.append(img[0:4, :].sum())

        # 特征2: 下半部分墨水量 (区分7/9 vs 6/8)
        f.append(img[4:8, :].sum())

        # 特征3: 左半墨水量 (区分1 vs 其他)
        f.append(img[:, 0:4].sum())

        # 特征4: 右半墨水量 (区分6 vs 9)
        f.append(img[:, 4:8].sum())

        # 特征5: 中心十字墨水 (区分0 vs 8)
        f.append(img[3:5, 2:6].sum())

        # 特征6: 上半中间是否空洞 (区分0/8 vs 5/6)
        f.append(img[2, 3:5].sum())

        # 特征7: 下半中间是否空洞 (区分8 vs 9)
        f.append(img[5, 3:5].sum())

        features.append(f)
    return np.array(features)

# 提取特征
X_feat = extract_features(digits.data)

print("\n7个手工特征:")
print("  F1: 上半墨水量    F2: 下半墨水量")
print("  F3: 左半墨水量    F4: 右半墨水量")
print("  F5: 中心十字墨水  F6: 上中空洞")
print("  F7: 下中空洞")

# 每个数字的平均特征值
print("\n数字 |  F1上 |  F2下 |  F3左 |  F4右 | F5中心| F6上空| F7下空")
print("-" * 70)
for d in range(10):
    mask = digits.target == d
    avg = X_feat[mask].mean(axis=0)
    print(f"  {d}  |", end="")
    for v in avg:
        print(f" {v:5.0f} |", end="")
    print()

# ========== 用不同数量的特征测试准确率 ==========
print("\n" + "=" * 60)
print("特征数量 vs KNN准确率")
print("=" * 60)

X_train, X_test, y_train, y_test = train_test_split(
    digits.data, digits.target, test_size=0.2, random_state=22
)

feat_train = extract_features(X_train)
feat_test = extract_features(X_test)

results = []
for n_feat in [1, 2, 3, 4, 5, 6, 7]:
    knn = KNeighborsClassifier(n_neighbors=5)
    knn.fit(feat_train[:, :n_feat], y_train)
    score = knn.score(feat_test[:, :n_feat], y_test)
    results.append((n_feat, score))
    bar = "#" * int(score * 40)
    print(f"  {n_feat}个特征: {score:.4f}  {bar}")

# 对比: 原始64维
knn_full = KNeighborsClassifier(n_neighbors=5)
knn_full.fit(X_train, y_train)
score_full = knn_full.score(X_test, y_test)
bar = "#" * int(score_full * 40)
print(f"  64维原始: {score_full:.4f}  {bar}")

print(f"\n7个手工特征 vs 64维原始: "
      f"{'手工更好!' if results[-1][1] > score_full else '原始更好'}")
print(f"差距: {abs(results[-1][1] - score_full):.4f}")
