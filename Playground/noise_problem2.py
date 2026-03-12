"""
噪声实验 Part 2: 加噪声后 8 会被认成 6 还是 9？
"""
import numpy as np
from sklearn.neighbors import KNeighborsClassifier

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

def dist(a, b):
    return np.sqrt(np.sum((a.astype(float) - b.astype(float)) ** 2))

# ========== 给8加不同类型的噪声 ==========
np.random.seed(42)

# 噪声1: 右上角随机噪点 (模拟墨水溅射)
eight_noise1 = eight.copy()
eight_noise1[0, 4] = 12   # 右上多了个点
eight_noise1[0, 5] = 8
eight_noise1[1, 5] = 10

# 噪声2: 上半部分右侧缺失 (模拟笔画断裂, 8变得像6)
eight_noise2 = eight.copy()
eight_noise2[2, 4] = 0    # 右上角的竖线断了

# 噪声3: 下半部分左侧缺失 (模拟笔画断裂, 8变得像9)
eight_noise3 = eight.copy()
eight_noise3[4, 2] = 0    # 左下角的竖线断了

show("干净的8", eight)
show("噪声8-v1: 墨水溅射", eight_noise1)
show("噪声8-v2: 右上断裂(像6)", eight_noise2)
show("噪声8-v3: 左下断裂(像9)", eight_noise3)

# ========== 距离变化 ==========
print("\n=== 干净8 的距离 ===")
print(f"  vs 6: {dist(eight, six):.2f}")
print(f"  vs 9: {dist(eight, nine):.2f}")

print("\n=== 噪声8-v2(右上断裂) 的距离 ===")
d6 = dist(eight_noise2, six)
d9 = dist(eight_noise2, nine)
print(f"  vs 6: {d6:.2f}  {'<-- 更近!' if d6 < d9 else ''}")
print(f"  vs 9: {d9:.2f}  {'<-- 更近!' if d9 < d6 else ''}")

print("\n=== 噪声8-v3(左下断裂) 的距离 ===")
d6 = dist(eight_noise3, six)
d9 = dist(eight_noise3, nine)
print(f"  vs 6: {d6:.2f}  {'<-- 更近!' if d6 < d9 else ''}")
print(f"  vs 9: {d9:.2f}  {'<-- 更近!' if d9 < d6 else ''}")

# ========== KNN 实测 ==========
print("\n=== KNN(K=1) 预测 ===")
X_train = np.array([six.flatten(), nine.flatten()]).astype(float)
y_train = np.array([6, 9])

knn = KNeighborsClassifier(n_neighbors=1)
knn.fit(X_train, y_train)

for name, noisy in [("墨水溅射", eight_noise1),
                     ("右上断裂", eight_noise2),
                     ("左下断裂", eight_noise3)]:
    pred = knn.predict([noisy.flatten().astype(float)])
    print(f"  {name} -> KNN说是: {pred[0]}  (真实: 8)")
