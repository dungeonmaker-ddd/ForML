"""
真实手写数字的完整预测流程
从原始数据 → 归一化 → 标准化 → 预测 → 关键像素分析
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

# 找一个真实的8
idx_8_in_test = np.where(y_test == 8)[0][0]
sample = X_test[idx_8_in_test]
sample_img = sample.reshape(8, 8)

# ========== 1. 原始数据: 真实手写的8 ==========
print("=" * 60)
print("Step 1: 原始数据 (真实手写的8)")
print("=" * 60)

print("\n[像素值 0~16]")
for row in sample_img:
    print(" ".join(f"{int(v):2d}" for v in row))

chars = "  .:-=+*#%@"
print("\n[ASCII 可视化]  空格=0 .=淡 :=弱 +=中 #=浓 @=满")
for row in sample_img:
    line = ""
    for v in row:
        idx = int(v / 16 * (len(chars) - 1))
        idx = max(0, min(idx, len(chars) - 1))
        line += chars[idx] * 2
    print(line)

nz = sample[sample > 0]
print(f"\n统计: 非零像素={len(nz)}, "
      f"值范围=[{nz.min():.0f},{nz.max():.0f}], "
      f"均值={nz.mean():.1f}, 标准差={nz.std():.1f}")
print("注意: 笔画中心浓(12~16), 边缘淡(1~4), 这是真实手写的特征")
