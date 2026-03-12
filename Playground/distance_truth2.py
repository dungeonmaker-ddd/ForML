"""
问题2: 噪声会让距离更大吗?
问题3: 对0-9所有数字的距离对比
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

idx_8 = np.where(y_test == 8)[0][0]
sample = X_test[idx_8]

# ========== 问题2: 噪声的影响 ==========
print("=" * 65)
print("问题2: 噪声会让距离更大吗?")
print("=" * 65)

# 给输入加不同程度的噪声
np.random.seed(42)
print(f"\n原始输入 vs 每个数字最近样本的距离:")
print(f"然后加噪声看距离怎么变\n")

def min_dist_to_class(vec, digit):
    mask = y_train == digit
    dists = np.sqrt(np.sum((X_train[mask] - vec)**2, axis=1))
    return dists.min()

# 原始距离
print(f"{'':>12}", end="")
for d in range(10):
    print(f"  到{d}  ", end="")
print()
print("-" * 82)

# 无噪声
print(f"{'无噪声':>12}", end="")
orig_dists = []
for d in range(10):
    dd = min_dist_to_class(sample, d)
    orig_dists.append(dd)
    marker = " *" if d == 8 else "  "
    print(f" {dd:5.1f}{marker}", end="")
print("   * = 最近")

# 轻微噪声
noise_light = sample + np.random.normal(0, 1, 64)
noise_light = np.clip(noise_light, 0, 16)
print(f"{'轻噪声(std=1)':>12}", end="")
for d in range(10):
    dd = min_dist_to_class(noise_light, d)
    print(f" {dd:5.1f}  ", end="")
print()

# 中等噪声
noise_med = sample + np.random.normal(0, 3, 64)
noise_med = np.clip(noise_med, 0, 16)
print(f"{'中噪声(std=3)':>12}", end="")
for d in range(10):
    dd = min_dist_to_class(noise_med, d)
    print(f" {dd:5.1f}  ", end="")
print()

# 严重噪声
noise_heavy = sample + np.random.normal(0, 6, 64)
noise_heavy = np.clip(noise_heavy, 0, 16)
print(f"{'重噪声(std=6)':>12}", end="")
for d in range(10):
    dd = min_dist_to_class(noise_heavy, d)
    print(f" {dd:5.1f}  ", end="")
print()

# 预测结果
print(f"\n噪声下的预测:")
for name, vec in [("无噪声", sample), ("轻噪声", noise_light),
                   ("中噪声", noise_med), ("重噪声", noise_heavy)]:
    pred = knn.predict(vec.reshape(1, -1))[0]
    d8 = min_dist_to_class(vec, 8)
    print(f"  {name:>8}: 预测={pred}  到8的距离={d8:.1f}  "
          f"{'OK' if pred == 8 else 'WRONG!'}")
