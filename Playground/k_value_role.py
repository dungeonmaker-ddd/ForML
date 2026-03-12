"""
K=3 到底起了什么作用?
K = 找几个最近邻来投票
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

# 用K=10找到10个最近邻, 然后模拟不同K值的投票过程
knn10 = KNeighborsClassifier(n_neighbors=10)
knn10.fit(X_train, y_train)
dist, idx = knn10.kneighbors(sample.reshape(1, -1))

print("=" * 60)
print("这个8的10个最近邻 (按距离排序)")
print("=" * 60)
print(f"\n排名 | 距离  | 标签 | 身份")
print("-" * 45)
for rank in range(10):
    d = dist[0][rank]
    label = y_train[idx[0][rank]]
    print(f"  #{rank+1:2d} | {d:5.1f} | {label}    | "
          f"{'<-- 最近!' if rank == 0 else ''}")

# ========== 不同K值的投票过程 ==========
print("\n" + "=" * 60)
print("不同K值的投票过程")
print("=" * 60)

for k in [1, 3, 5, 7, 10]:
    labels = [y_train[idx[0][i]] for i in range(k)]
    # 统计投票
    votes = {}
    for l in labels:
        votes[l] = votes.get(l, 0) + 1
    winner = max(votes, key=votes.get)

    voters = " ".join(f"[{l}]" for l in labels)
    vote_str = " ".join(f"{l}={c}票" for l, c in
                        sorted(votes.items(), key=lambda x: -x[1]))

    print(f"\nK={k}: 取前{k}个邻居投票")
    print(f"  邻居: {voters}")
    print(f"  投票: {vote_str}")
    print(f"  结果: {winner}")

# ========== K值的真正作用: 抗噪声 ==========
print("\n" + "=" * 60)
print("K的真正作用: 抗噪声能力")
print("=" * 60)

print("""
K=1: 只看最近的1个邻居
  优点: 如果最近邻是对的, 直接命中
  缺点: 如果最近邻恰好是噪声/异常值, 直接判错
  类比: 只问一个人的意见

K=3: 看最近的3个邻居投票
  优点: 1个噪声邻居会被另外2个正确邻居否决
  缺点: 如果2个噪声邻居恰好更近, 还是会错
  类比: 问3个人, 少数服从多数

K=5: 看最近的5个邻居投票
  优点: 需要3个噪声邻居才能翻盘, 更稳定
  缺点: 可能把距离较远的其他数字拉进来
  类比: 问5个人, 但有些人离得远可能不太了解情况
""")

# ========== 用噪声数据证明K的抗噪能力 ==========
print("=" * 60)
print("实测: 加噪声后不同K值的表现")
print("=" * 60)

np.random.seed(42)
noise_levels = [0, 2, 4, 6]
k_values = [1, 3, 5, 7]

# 对每个噪声水平, 生成20个噪声样本, 统计正确率
print(f"\n{'':>10}", end="")
for k in k_values:
    print(f"  K={k}  ", end="")
print()
print("-" * 45)

for std in noise_levels:
    print(f"噪声std={std:d}  ", end="")
    for k in k_values:
        knn = KNeighborsClassifier(n_neighbors=k)
        knn.fit(X_train, y_train)
        correct = 0
        trials = 50
        for t in range(trials):
            noisy = sample + np.random.normal(0, std, 64)
            noisy = np.clip(noisy, 0, 16)
            if knn.predict(noisy.reshape(1, -1))[0] == 8:
                correct += 1
        pct = correct / trials * 100
        print(f" {pct:4.0f}%  ", end="")
    print()
