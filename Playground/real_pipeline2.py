"""
完整流程 Part 2: 归一化 → 标准化 → KNN预测 → 关键像素分析
"""
import numpy as np
from sklearn.datasets import load_digits
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split

digits = load_digits()
X_train, X_test, y_train, y_test = train_test_split(
    digits.data, digits.target, test_size=0.2, random_state=22
)

idx_8 = np.where(y_test == 8)[0][0]
sample = X_test[idx_8]
sample_img = sample.reshape(8, 8)

chars = "  .:-=+*#%@"
def ascii_row(row, vmin=0, vmax=16):
    line = ""
    for v in row:
        idx = int((v - vmin) / (vmax - vmin) * (len(chars) - 1))
        idx = max(0, min(idx, len(chars) - 1))
        line += chars[idx] * 2
    return line

# ========== Step 2: 归一化 (0~1) ==========
print("=" * 60)
print("Step 2: 归一化 /16 -> [0, 1]")
print("=" * 60)
normalized = sample / 16.0
norm_img = normalized.reshape(8, 8)

print("\n[数值]")
for row in norm_img:
    print(" ".join(f"{v:.2f}" for v in row))

print("\n[ASCII] (和原始一样, 只是值域变了)")
for row in norm_img:
    print(ascii_row(row, 0, 1))

print("\n效果: 形状完全不变, 只是值从 0~16 压缩到 0~1")
print("目的: 消除量纲差异, 让不同数据集可以比较")

# ========== Step 3: 标准化 (StandardScaler) ==========
print("\n" + "=" * 60)
print("Step 3: 标准化 (x - mean) / std")
print("=" * 60)

scaler = StandardScaler()
X_train_s = scaler.fit_transform(X_train.astype(float))
X_test_s = scaler.transform(X_test.astype(float))

scaled = X_test_s[idx_8]
scaled_img = scaled.reshape(8, 8)

print("\n[数值] (注意负数=比平均暗, 正数=比平均亮)")
for row in scaled_img:
    print(" ".join(f"{v:5.2f}" for v in row))

print("\n[ASCII] (映射 -2~+2)")
for row in scaled_img:
    print(ascii_row(row, -2, 2))

print("\n效果: 背景不再是空白, 出现了负值噪声")
print("原因: 原来的0被减去均值后变成负数")
