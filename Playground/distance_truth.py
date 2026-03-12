"""
距离的真相: 每个像素的贡献 + 噪声的影响
"""
import numpy as np
from sklearn.datasets import load_digits
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split

digits = load_digits()
X_train, X_test, y_train, y_test = train_test_split(
    digits.data, digits.target, test_size=0.2, random_state=22
)

knn = KNeighborsClassifier(n_neighbors=3)
knn.fit(X_train, y_train)

# 找一个测试集里的8
idx_8 = np.where(y_test == 8)[0][0]
sample = X_test[idx_8]

# 找每个数字类别中最近的那个样本
print("=" * 65)
print("问题1: 64个像素每个都有距离吗?")
print("=" * 65)

# 找最近的8
mask_8 = y_train == 8
nearest_8 = X_train[mask_8][np.argmin(
    np.sqrt(np.sum((X_train[mask_8] - sample)**2, axis=1)))]

diff = sample - nearest_8           # 每个像素的差
diff_sq = diff ** 2                  # 每个像素的差的平方
total = np.sqrt(diff_sq.sum())       # 总距离

print(f"\n欧氏距离公式: sqrt( d0^2 + d1^2 + d2^2 + ... + d63^2 )")
print(f"\n每个像素的贡献 (差值的平方):")
print(f"像素:  ", end="")
for i in range(64):
    if diff_sq[i] > 0:
        print(f"[{i:2d}]", end=" ")
print()
print(f"差^2:  ", end="")
for i in range(64):
    if diff_sq[i] > 0:
        print(f"{diff_sq[i]:3.0f} ", end="")
print()

# 按贡献排序
contrib = sorted(enumerate(diff_sq), key=lambda x: -x[1])
nonzero = [(i, v) for i, v in contrib if v > 0]

print(f"\n64个像素中:")
print(f"  有差异的: {len(nonzero)}个")
print(f"  完全相同: {64 - len(nonzero)}个 (贡献=0)")
print(f"\n贡献排名 (差^2):")
cumsum = 0
for rank, (px, v) in enumerate(nonzero[:10]):
    cumsum += v
    pct = cumsum / diff_sq.sum() * 100
    r, c = px // 8, px % 8
    bar = "#" * int(v / 4)
    print(f"  #{rank+1:2d} 像素[{px:2d}]({r},{c}): "
          f"差={diff[px]:+.0f} 差^2={v:3.0f} "
          f"累计={pct:5.1f}% {bar}")

print(f"\n前5个像素贡献了 "
      f"{sum(v for _,v in nonzero[:5])/diff_sq.sum()*100:.0f}% 的总距离")
print(f"前10个像素贡献了 "
      f"{sum(v for _,v in nonzero[:10])/diff_sq.sum()*100:.0f}% 的总距离")
print(f"\n答案: 每个像素都参与计算, 但少数像素贡献了大部分距离")
