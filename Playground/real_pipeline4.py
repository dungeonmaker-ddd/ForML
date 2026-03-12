"""
完整流程 Part 4: 对所有数字的距离分析 + 关键像素
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

# ========== 对每个数字类别的平均距离 ==========
print("=" * 60)
print("Step 5: 这个8到每个数字类别的距离")
print("=" * 60)

print("\n数字 | 最近距离 | 平均距离 | 距离柱状图")
print("-" * 60)

min_dists = {}
for digit in range(10):
    mask = y_train == digit
    X_digit = X_train[mask]
    dists = np.sqrt(np.sum((X_digit - sample) ** 2, axis=1))
    min_d = dists.min()
    avg_d = dists.mean()
    min_dists[digit] = min_d
    bar_min = "#" * int(min_d / 2)
    marker = " <-- 最近!" if digit == 8 else ""
    print(f"  {digit}   |  {min_d:5.1f}  |  {avg_d:5.1f}  | {bar_min}{marker}")

# ========== 容易混淆的数字 ==========
print("\n" + "=" * 60)
print("Step 6: 最容易混淆的数字 (按最近距离排序)")
print("=" * 60)

sorted_digits = sorted(min_dists.items(), key=lambda x: x[1])
for rank, (digit, d) in enumerate(sorted_digits):
    tag = " *** 正确答案" if digit == 8 else ""
    gap = d - sorted_digits[0][1]
    print(f"  #{rank+1} 数字{digit}: 距离={d:.1f}  "
          f"(比最近的远 +{gap:.1f}){tag}")

# ========== 关键像素: 哪些像素让8和其他数字区分开 ==========
print("\n" + "=" * 60)
print("Step 7: 关键像素 — 8和最近竞争者的差异在哪")
print("=" * 60)

# 找最近的非8邻居
runner_up = sorted_digits[1] if sorted_digits[0][0] == 8 \
    else sorted_digits[0]
rival_digit = runner_up[0]

# 找rival中最近的那个样本
mask_rival = y_train == rival_digit
X_rival = X_train[mask_rival]
rival_dists = np.sqrt(np.sum((X_rival - sample) ** 2, axis=1))
closest_rival = X_rival[rival_dists.argmin()]

# 找8中最近的那个样本
mask_8 = y_train == 8
X_8 = X_train[mask_8]
dists_8 = np.sqrt(np.sum((X_8 - sample) ** 2, axis=1))
closest_8 = X_8[dists_8.argmin()]

print(f"\n最近的竞争者: 数字{rival_digit}")

# 像素差异热力图
diff_rival = np.abs(sample - closest_rival).reshape(8, 8)
diff_8 = np.abs(sample - closest_8).reshape(8, 8)

print(f"\n输入8 vs 最近的8 (像素差异):")
print("差异小=匹配好, 差异大=不匹配")
for row in diff_8:
    line = ""
    for v in row:
        if v < 1:    line += "  "   # 完美匹配
        elif v < 4:  line += " ."   # 小差异
        elif v < 8:  line += " o"   # 中差异
        else:        line += " X"   # 大差异
    print(line)

print(f"\n输入8 vs 最近的{rival_digit} (像素差异):")
for row in diff_rival:
    line = ""
    for v in row:
        if v < 1:    line += "  "
        elif v < 4:  line += " ."
        elif v < 8:  line += " o"
        else:        line += " X"
    print(line)

# 找出差异最大的像素位置
diff_map = diff_rival - diff_8  # 正值=rival更不匹配
diff_flat = diff_map.flatten()
top_pixels = np.argsort(diff_flat)[::-1][:5]

print(f"\n决定性像素 (让8赢过{rival_digit}的关键位置):")
print(f"像素位置 | 行,列 | 输入值 | vs8差 | vs{rival_digit}差 | 贡献")
print("-" * 60)
for px in top_pixels:
    r, c = px // 8, px % 8
    v = sample[px]
    d8 = diff_8.flatten()[px]
    dr = diff_rival.flatten()[px]
    contrib = dr - d8
    print(f"  [{px:2d}]    | ({r},{c}) | {v:5.1f} | "
          f"{d8:4.1f}  | {dr:5.1f}  | +{contrib:.1f}")
