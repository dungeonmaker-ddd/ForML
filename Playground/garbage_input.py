"""
问题2: 四不像数字会怎样？
KNN 没有"拒绝"能力，它永远会给出一个答案
"""
import numpy as np
from sklearn.datasets import load_digits
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split

digits = load_digits()
X_train, X_test, y_train, y_test = train_test_split(
    digits.data, digits.target, test_size=0.2, random_state=22
)
knn = KNeighborsClassifier(n_neighbors=5)
knn.fit(X_train, y_train)

def show(name, img):
    print(f"\n{name}:")
    for row in img:
        print(" ".join("#" if v > 4 else "." for v in row))

def predict_with_detail(name, img):
    """预测并显示KNN的投票细节"""
    vec = img.flatten().astype(float).reshape(1, -1)
    pred = knn.predict(vec)[0]
    proba = knn.predict_proba(vec)[0]
    dist, idx = knn.kneighbors(vec)

    show(name, img)
    print(f"  KNN预测: {pred}")
    print(f"  5个最近邻的距离: {np.round(dist[0], 1)}")
    print(f"  5个最近邻的标签: {y_train[idx[0]]}")
    print(f"  各数字的概率: ", end="")
    for i, p in enumerate(proba):
        if p > 0:
            print(f"{i}={p:.0%} ", end="")
    print()
    return pred, dist[0], proba

# ========== 正常数字: 作为基准 ==========
print("=" * 55)
print("基准: 正常数字的预测")
print("=" * 55)

normal_8 = np.array([
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 10, 10, 10, 0, 0, 0],
    [0, 0, 10, 0, 10, 0, 0, 0],
    [0, 0, 10, 10, 10, 0, 0, 0],
    [0, 0, 10, 0, 10, 0, 0, 0],
    [0, 0, 10, 10, 10, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
])
_, base_dist, _ = predict_with_detail("正常的8", normal_8)

# ========== 四不像测试 ==========
print("\n" + "=" * 55)
print("测试: 各种四不像输入")
print("=" * 55)

# 测试1: 纯随机噪声
np.random.seed(42)
random_noise = np.random.randint(0, 16, (8, 8)).astype(float)
_, d1, _ = predict_with_detail("纯随机噪声", random_noise)

# 测试2: 全黑 (满墨水)
all_black = np.full((8, 8), 15.0)
_, d2, _ = predict_with_detail("全黑 (满墨水)", all_black)

# 测试3: 全白 (空白纸)
all_white = np.zeros((8, 8))
_, d3, _ = predict_with_detail("全白 (空白纸)", all_white)

# 测试4: 对角线 (不是任何数字)
diagonal = np.zeros((8, 8))
for i in range(8):
    diagonal[i, i] = 15
_, d4, _ = predict_with_detail("对角线 (斜杠)", diagonal)

# 测试5: X形 (不是任何数字)
x_shape = np.zeros((8, 8))
for i in range(8):
    x_shape[i, i] = 15
    x_shape[i, 7-i] = 15
_, d5, _ = predict_with_detail("X形 (叉叉)", x_shape)

# 测试6: 半8半6 (上半是8下半是6)
hybrid = np.array([
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 10, 10, 10, 0, 0, 0],
    [0, 0, 10, 0, 10, 0, 0, 0],
    [0, 0, 10, 10, 10, 0, 0, 0],
    [0, 0, 10, 0, 0, 0, 0, 0],
    [0, 0, 10, 10, 10, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
])
_, d6, _ = predict_with_detail("半8半6 (上闭下开)", hybrid)
