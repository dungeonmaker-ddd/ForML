"""
为什么我们手工画的 "8" 被 KNN 判成了 4？
看看 KNN 找到的 5 个最近邻到底长什么样
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
    for row in img.reshape(8, 8):
        print(" ".join(f"{int(v):2d}" for v in row))

def show_visual(name, img):
    print(f"{name}:")
    for row in img.reshape(8, 8):
        line = ""
        for v in row:
            if v < 1:    line += "  "
            elif v < 4:  line += " ."
            elif v < 8:  line += " o"
            elif v < 12: line += " O"
            else:        line += " #"
        print(line)

# 我们手工画的8
our_8 = np.array([
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 10, 10, 10, 0, 0, 0],
    [0, 0, 10, 0, 10, 0, 0, 0],
    [0, 0, 10, 10, 10, 0, 0, 0],
    [0, 0, 10, 0, 10, 0, 0, 0],
    [0, 0, 10, 10, 10, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
]).flatten().astype(float).reshape(1, -1)

# 找5个最近邻
dist, idx = knn.kneighbors(our_8)

print("=" * 55)
print("我们手工画的 '8':")
print("=" * 55)
show_visual("输入", our_8[0])
print(f"像素值: 全部是0或10, 非常均匀")

print("\n" + "=" * 55)
print("KNN 找到的 5 个最近邻:")
print("=" * 55)

for rank, (d, i) in enumerate(zip(dist[0], idx[0])):
    label = y_train[i]
    neighbor = X_train[i]
    print(f"\n--- 第{rank+1}近邻 | 标签={label} | 距离={d:.1f} ---")
    show_visual(f"  邻居(真实的{label})", neighbor)
    show(f"  像素值", neighbor)

# ========== 关键分析 ==========
print("\n" + "=" * 55)
print("为什么判成4? 对比分析")
print("=" * 55)

# 找一个真实的8看看
real_8_idx = np.where(y_train == 8)[0][0]
real_8 = X_train[real_8_idx]

print("\n我们的8 vs 真实的8:")
show_visual("我们画的8 (像素全是0或10)", our_8[0])
show_visual("训练集里真实的8", real_8)
show("真实8的像素值", real_8)

d_to_real8 = np.sqrt(np.sum((our_8[0] - real_8) ** 2))
print(f"\n我们的8到这个真实8的距离: {d_to_real8:.1f}")
print(f"我们的8到最近邻(标签4)的距离: {dist[0][0]:.1f}")

# 分析像素值分布差异
print("\n" + "=" * 55)
print("根本原因: 像素值分布")
print("=" * 55)
print(f"\n我们的8:  非零像素全部 = 10 (太均匀)")
print(f"真实数字: 像素值从1到16不等 (有浓有淡)")
print(f"\n真实8的像素值统计:")
nz = real_8[real_8 > 0]
print(f"  非零像素数: {len(nz)}")
print(f"  最小值: {nz.min():.0f}")
print(f"  最大值: {nz.max():.0f}")
print(f"  均值:   {nz.mean():.1f}")
print(f"  标准差: {nz.std():.1f}")
print(f"\n我们的8的像素值统计:")
nz2 = our_8[0][our_8[0] > 0]
print(f"  非零像素数: {len(nz2)}")
print(f"  全部 = {nz2[0]:.0f} (零标准差, 不自然)")
