"""
完整流程 Part 3: KNN 预测 + 关键像素分析 + 对所有数字的距离
"""
import numpy as np
from sklearn.datasets import load_digits
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split

digits = load_digits()
X_train, X_test, y_train, y_test = train_test_split(
    digits.data, digits.target, test_size=0.2, random_state=22
)

idx_8 = np.where(y_test == 8)[0][0]
sample = X_test[idx_8]

# 用原始数据 (不标准化, 因为这个数据集标准化反而降准确率)
knn = KNeighborsClassifier(n_neighbors=5)
knn.fit(X_train, y_train)

# ========== Step 4: KNN 预测 ==========
print("=" * 60)
print("Step 4: KNN(K=5) 预测")
print("=" * 60)

vec = sample.reshape(1, -1)
pred = knn.predict(vec)[0]
proba = knn.predict_proba(vec)[0]
dist, idx = knn.kneighbors(vec)

print(f"\n预测结果: {pred}  (真实: {y_test[idx_8]})")
print(f"\n5个最近邻:")
print(f"  距离:  {np.round(dist[0], 1)}")
print(f"  标签:  {y_train[idx[0]]}")
print(f"\n投票概率:")
for i, p in enumerate(proba):
    if p > 0:
        bar = "#" * int(p * 30)
        print(f"  数字{i}: {p:4.0%} {bar}")

# ========== 可视化: 输入 vs 5个最近邻 ==========
chars = "  .:-=+*#%@"
def ascii_img(data):
    lines = []
    for row in data.reshape(8, 8):
        line = ""
        for v in row:
            ci = int(v / 16 * (len(chars) - 1))
            ci = max(0, min(ci, len(chars) - 1))
            line += chars[ci] * 2
        lines.append(line)
    return lines

print(f"\n--- 输入(真实8) vs 5个最近邻 并排对比 ---")
input_lines = ascii_img(sample)
neighbor_lines = [ascii_img(X_train[i]) for i in idx[0]]

header = f"{'输入(8)':^18}"
for rank, i in enumerate(idx[0]):
    label = y_train[i]
    d = dist[0][rank]
    header += f"{'#%d %s d=%.0f' % (rank+1, label, d):^18}"
print(header)
print("-" * (18 * 6))

for row_i in range(8):
    line = f" {input_lines[row_i]} |"
    for n in neighbor_lines:
        line += f" {n[row_i]} |"
    print(line)
