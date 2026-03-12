"""
真实手写数字的预处理流程
展示: 原始数据 → 各步骤处理后 → 最终输入模型的数据

MNIST 预处理的标准步骤:
1. 灰度化 (原始就是灰度)
2. 二值化 / 阈值处理
3. 定位数字区域 (bounding box)
4. 居中 + 缩放到统一尺寸
5. 归一化 (0~1 或 标准化)
"""
import numpy as np
from sklearn.datasets import load_digits

digits = load_digits()

def show_img(name, img, fmt="2d"):
    """文本可视化一张图"""
    print(f"\n{'='*40}")
    print(f"{name}")
    print(f"{'='*40}")
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
                if v < 1:    line += "  "    # 空白
                elif v < 4:  line += " ."    # 淡
                elif v < 8:  line += " o"    # 中
                elif v < 12: line += " O"    # 浓
                else:        line += " #"    # 满
            print(line)

# ========== 取几个有代表性的样本 ==========
# 找一个写得比较"歪"的8
idx_8 = np.where(digits.target == 8)[0]
sample = digits.images[idx_8[3]]  # 取第4个8

print(">>> 我们拿一个真实的手写数字 '8' 来走一遍预处理流程")

# ========== Step 0: 原始数据 ==========
show_img("Step 0: 原始像素值 (0-16灰度)", sample, "2d")
show_img("Step 0: 视觉化 (.=淡 o=中 O=浓 #=满)", sample, "visual")
print(f"\n形状: {sample.shape}")
print(f"值范围: [{sample.min():.0f}, {sample.max():.0f}]")
print(f"非零像素数: {np.count_nonzero(sample)}/{sample.size}")
