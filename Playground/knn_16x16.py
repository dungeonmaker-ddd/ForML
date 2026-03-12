"""
16x16 KNN 完整实验:
1. 8x8 插值放大到 16x16 (模拟更高分辨率)
2. 不同K值的训练/测试准确率对比
3. 欠拟合 vs 过拟合 的判断方法
"""
import numpy as np
from sklearn.datasets import load_digits
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split, cross_val_score

digits = load_digits()

# ========== 把 8x8 放大到 16x16 ==========
def bilinear_resize(img, th, tw):
    h, w = img.shape
    result = np.zeros((th, tw))
    for r in range(th):
        for c in range(tw):
            sr = r * (h-1) / (th-1)
            sc = c * (w-1) / (tw-1)
            r0, c0 = int(sr), int(sc)
            r1, c1 = min(r0+1, h-1), min(c0+1, w-1)
            dr, dc = sr - r0, sc - c0
            result[r,c] = (img[r0,c0]*(1-dr)*(1-dc) + img[r1,c0]*dr*(1-dc)
                         + img[r0,c1]*(1-dr)*dc + img[r1,c1]*dr*dc)
    return result

print("放大 8x8 -> 16x16 ...")
X_16 = np.array([bilinear_resize(img, 16, 16).flatten()
                  for img in digits.images])
y = digits.target

print(f"原始: {digits.data.shape} (1797样本 x 64特征)")
print(f"放大: {X_16.shape} (1797样本 x 256特征)")

# 划分数据
X_train, X_test, y_train, y_test = train_test_split(
    X_16, y, test_size=0.2, random_state=22
)
# 同时保留8x8版本做对比
X_train_8, X_test_8, _, _ = train_test_split(
    digits.data, y, test_size=0.2, random_state=22
)

# ========== 不同K值: 训练准确率 vs 测试准确率 ==========
print("\n" + "=" * 70)
print("K值 vs 准确率 (16x16, 256维)")
print("=" * 70)
print(f"\n{'K':>3} | {'训练准确率':>10} | {'测试准确率':>10} | "
      f"{'差距':>6} | {'状态':>10} | 图示")
print("-" * 70)

k_values = [1, 2, 3, 5, 7, 10, 15, 20, 30, 50, 80, 100]
results = []

for k in k_values:
    knn = KNeighborsClassifier(n_neighbors=k)
    knn.fit(X_train, y_train)
    train_score = knn.score(X_train, y_train)
    test_score = knn.score(X_test, y_test)
    gap = train_score - test_score

    # 判断拟合状态
    if train_score > 0.99 and gap > 0.05:
        status = "OVERFIT"
    elif test_score < 0.90:
        status = "UNDERFIT"
    elif gap < 0.03 and test_score > 0.95:
        status = "GOOD"
    else:
        status = "OK"

    # 图示
    bar_train = "#" * int(train_score * 30)
    bar_test = "=" * int(test_score * 30)

    print(f" {k:3d} | {train_score:10.4f} | {test_score:10.4f} | "
          f"{gap:+.4f} | {status:>10} | T:{bar_train}")
    print(f"     | {'':>10} | {'':>10} | "
          f"{'':>6} | {'':>10} | V:{bar_test}")

    results.append((k, train_score, test_score, gap, status))
