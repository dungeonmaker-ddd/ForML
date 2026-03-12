"""
用一维向量表达每个数字 — 寻找规律
问题: 64个像素太多了, 能不能用更少的数字区分0-9?
"""
import numpy as np
from sklearn.datasets import load_digits

digits = load_digits()

# ========== 每个数字的"平均脸" ==========
print("=" * 60)
print("每个数字的平均像素 (所有样本取均值)")
print("=" * 60)

chars = " .:-=+*#%@"
averages = {}
for d in range(10):
    mask = digits.target == d
    avg = digits.data[mask].mean(axis=0)
    averages[d] = avg

# 并排显示 0-9 的平均脸
print("\n  0    1    2    3    4    5    6    7    8    9")
print("-" * 55)
for row in range(8):
    line = ""
    for d in range(10):
        img = averages[d].reshape(8, 8)
        segment = ""
        for v in img[row]:
            ci = int(v / 16 * (len(chars) - 1))
            ci = max(0, min(ci, len(chars) - 1))
            segment += chars[ci]
        line += segment + "  "
    print(line)

# ========== 展平成一维: 看看64个数字的分布 ==========
print("\n" + "=" * 60)
print("一维向量对比: 每个数字的平均像素值 (只看关键行)")
print("=" * 60)

print("\n第1行 (顶部) — 谁的顶部有墨水?")
print("像素:  ", end="")
for c in range(8): print(f"[{c}] ", end="")
print()
for d in range(10):
    row = averages[d].reshape(8, 8)[1]
    print(f"  {d}: ", end="")
    for v in row:
        if v < 2:    print("  . ", end="")
        elif v < 6:  print(f"{v:3.0f} ", end="")
        else:        print(f" {v:2.0f} ", end="")
    print()

print("\n第3行 (中间) — 谁的中间有墨水?")
for d in range(10):
    row = averages[d].reshape(8, 8)[3]
    print(f"  {d}: ", end="")
    for v in row:
        if v < 2:    print("  . ", end="")
        elif v < 6:  print(f"{v:3.0f} ", end="")
        else:        print(f" {v:2.0f} ", end="")
    print()

print("\n第5行 (下部) — 谁的下部有墨水?")
for d in range(10):
    row = averages[d].reshape(8, 8)[5]
    print(f"  {d}: ", end="")
    for v in row:
        if v < 2:    print("  . ", end="")
        elif v < 6:  print(f"{v:3.0f} ", end="")
        else:        print(f" {v:2.0f} ", end="")
    print()
