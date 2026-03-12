"""
预测值8 vs 真实值8 — 一维向量到底长什么样
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
sample = X_test[idx_8]  # 这就是输入给KNN的一维向量

# KNN找到的3个最近邻
dist, idx = knn.kneighbors(sample.reshape(1, -1))
pred = knn.predict(sample.reshape(1, -1))[0]

# ========== 输入样本: 一维向量 ==========
print("=" * 65)
print(f"输入给KNN的: 一维向量 (shape={sample.shape})")
print("=" * 65)
print("\n这就是KNN实际看到的全部数据:")
print(f"[{', '.join(f'{v:.0f}' for v in sample)}]")
print(f"\n共{len(sample)}个数字, 没有行列概念, 没有形状概念")

# ========== 还原成二维看看 ==========
print("\n" + "=" * 65)
print("人眼还原成 8x8 (KNN不做这步, 只是给我们看)")
print("=" * 65)
img = sample.reshape(8, 8)
for r, row in enumerate(img):
    # 同时显示数值和ASCII
    nums = " ".join(f"{v:2.0f}" for v in row)
    visual = " ".join("#" if v > 8 else ("." if v > 2 else " ") for v in row)
    flat_idx = f"[{r*8:2d}~{r*8+7:2d}]"
    print(f"  {flat_idx}  {nums}   |  {visual}")

# ========== KNN找到的3个最近邻 ==========
print("\n" + "=" * 65)
print(f"KNN预测: {pred}  (找到3个最近邻, 全看一维距离)")
print("=" * 65)

for rank in range(3):
    i = idx[0][rank]
    d = dist[0][rank]
    label = y_train[i]
    neighbor = X_train[i]

    print(f"\n--- 第{rank+1}近邻 | 标签={label} | 距离={d:.1f} ---")
    print(f"一维向量:")
    print(f"[{', '.join(f'{v:.0f}' for v in neighbor)}]")

    print(f"\n还原8x8:")
    nimg = neighbor.reshape(8, 8)
    for r, row in enumerate(nimg):
        nums = " ".join(f"{v:2.0f}" for v in row)
        visual = " ".join("#" if v > 8 else ("." if v > 2 else " ") for v in row)
        print(f"  {nums}   |  {visual}")

# ========== 逐像素对比: 输入 vs 最近邻 ==========
print("\n" + "=" * 65)
print("逐像素对比: 输入8 vs 最近的邻居8")
print("=" * 65)

nearest = X_train[idx[0][0]]
diff = np.abs(sample - nearest)

print("\n位置  | 输入 | 邻居 | 差值 | 说明")
print("-" * 50)
# 只显示差异大的像素
big_diffs = np.argsort(diff)[::-1][:10]
for px in big_diffs:
    r, c = px // 8, px % 8
    d_val = diff[px]
    if d_val < 1:
        continue
    note = ""
    if d_val > 8:  note = "<-- 差异大!"
    elif d_val > 4: note = "<-- 有差异"
    print(f" [{px:2d}]({r},{c}) | {sample[px]:4.0f} | "
          f"{nearest[px]:4.0f} | {d_val:4.0f} | {note}")

total_dist = np.sqrt(np.sum(diff ** 2))
print(f"\n总欧氏距离: sqrt(sum(差值^2)) = {total_dist:.1f}")
print(f"64个像素里, 差异>4的只有{np.sum(diff > 4)}个")
print(f"大部分像素几乎一样, 少数像素的差异决定了距离")
