"""
预处理完整流程: 从原始像素到模型输入
"""
import numpy as np
from sklearn.datasets import load_digits
from sklearn.preprocessing import StandardScaler

digits = load_digits()
idx_8 = np.where(digits.target == 8)[0]
sample = digits.images[idx_8[3]]

def show(name, img, fmt="2d"):
    print(f"\n{'='*50}")
    print(f"{name}")
    print(f"{'='*50}")
    if fmt == "2d":
        for row in img:
            print(" ".join(f"{int(v):2d}" for v in row))
    elif fmt == "float":
        for row in img:
            print(" ".join(f"{v:5.2f}" for v in row))
    elif fmt == "visual":
        for row in img:
            line = ""
            for v in row:
                if v < 1:    line += "  "
                elif v < 4:  line += " ."
                elif v < 8:  line += " o"
                elif v < 12: line += " O"
                else:        line += " #"
            print(line)

# ========== Step 0: 原始 ==========
print(">>> Step 0: 原始数据")
show("原始像素 (0-16)", sample, "2d")
show("视觉化", sample, "visual")
print(f"值范围: [{sample.min():.0f}, {sample.max():.0f}]")

# ========== Step 1: 二值化 ==========
print("\n>>> Step 1: 二值化 (阈值=4, 去掉淡墨水噪声)")
threshold = 4
binary = (sample > threshold).astype(float) * 16
show("二值化后", binary, "visual")
removed = np.count_nonzero(sample) - np.count_nonzero(binary)
print(f"去掉了 {removed} 个淡噪点")

# ========== Step 2: 定位 bounding box ==========
print("\n>>> Step 2: 找到数字的边界框 (bounding box)")
rows_with_ink = np.any(binary > 0, axis=1)
cols_with_ink = np.any(binary > 0, axis=0)
r_min, r_max = np.where(rows_with_ink)[0][[0, -1]]
c_min, c_max = np.where(cols_with_ink)[0][[0, -1]]
print(f"数字区域: 行[{r_min}:{r_max}], 列[{c_min}:{c_max}]")
print(f"数字实际大小: {r_max-r_min+1} x {c_max-c_min+1}")

cropped = sample[r_min:r_max+1, c_min:c_max+1]
show("裁剪出数字区域", cropped, "visual")

# ========== Step 3: 居中 ==========
print("\n>>> Step 3: 居中 (放回8x8网格中央)")
target_size = 8
pad_top = (target_size - cropped.shape[0]) // 2
pad_left = (target_size - cropped.shape[1]) // 2
centered = np.zeros((target_size, target_size))
h, w = cropped.shape
centered[pad_top:pad_top+h, pad_left:pad_left+w] = cropped
show("居中后", centered, "visual")

# ========== Step 4: 归一化 (0~1) ==========
print("\n>>> Step 4: 归一化到 [0, 1]")
normalized = centered / 16.0
show("归一化后 (0.0~1.0)", normalized, "float")
print(f"值范围: [{normalized.min():.2f}, {normalized.max():.2f}]")
