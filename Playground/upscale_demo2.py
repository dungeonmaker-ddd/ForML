"""
Part 2: 双线性插值 + 真实 28x28 MNIST 对比
"""
import numpy as np
from sklearn.datasets import load_digits

digits = load_digits()
idx_8 = np.where(digits.target == 8)[0][0]
small = digits.images[idx_8]

def bilinear_resize(img, target_h, target_w):
    h, w = img.shape
    result = np.zeros((target_h, target_w))
    for r in range(target_h):
        for c in range(target_w):
            src_r = r * (h - 1) / (target_h - 1)
            src_c = c * (w - 1) / (target_w - 1)
            r0, c0 = int(src_r), int(src_c)
            r1 = min(r0 + 1, h - 1)
            c1 = min(c0 + 1, w - 1)
            dr, dc = src_r - r0, src_c - c0
            val = (img[r0,c0]*(1-dr)*(1-dc) + img[r1,c0]*dr*(1-dc) +
                   img[r0,c1]*(1-dr)*dc + img[r1,c1]*dr*dc)
            result[r, c] = val
    return result

chars = "  .:-=+*#%@"
def ascii(img, vmax=16):
    lines = []
    for row in img:
        line = ""
        for v in row:
            ci = int(v / vmax * (len(chars) - 1))
            ci = max(0, min(ci, len(chars) - 1))
            line += chars[ci]
        lines.append(line)
    return lines

# ========== 双线性插值放大 ==========
big_bilinear = bilinear_resize(small, 28, 28)
print("=" * 60)
print("双线性插值放大到 28x28")
print("像素之间做平滑过渡, 边缘更柔和")
print("=" * 60)
for line in ascii(big_bilinear):
    print(line)
print(f"像素数: {big_bilinear.size}")
print("比最近邻平滑, 但细节是'编造'的 — 原始只有64个真实值")

# ========== 加载真实 28x28 MNIST ==========
print("\n" + "=" * 60)
print("真实 28x28 MNIST 的数字8")
print("(从 sklearn.datasets.fetch_openml 获取)")
print("=" * 60)

try:
    from sklearn.datasets import fetch_openml
    mnist = fetch_openml('mnist_784', version=1, as_frame=False,
                         parser='auto')
    X_real = mnist.data
    y_real = mnist.target.astype(int)

    # 找几个真实的8
    idx_real_8 = np.where(y_real == 8)[0]

    for i, idx in enumerate(idx_real_8[:2]):
        img = X_real[idx].reshape(28, 28)
        print(f"\n--- 真实MNIST 8 (样本#{idx}) ---")
        for line in ascii(img, vmax=255):
            print(line)
        nz = img[img > 0]
        print(f"非零像素: {len(nz)}/{img.size}")
        print(f"值范围: [{nz.min():.0f}, {nz.max():.0f}]")
        print(f"均值: {nz.mean():.1f}, 标准差: {nz.std():.1f}")

    print("\n" + "=" * 60)
    print("关键区别")
    print("=" * 60)
    print(f"\n8x8放大到28x28:")
    print(f"  像素数: 784, 但真实信息只有64个值")
    print(f"  其余720个像素是插值'编造'的")
    print(f"  边缘模糊, 没有真实笔画细节")
    print(f"\n真实28x28 MNIST:")
    print(f"  像素数: 784, 每个都是真实采集的")
    print(f"  值范围: 0~255 (256级灰度, 比8x8的0~16精细16倍)")
    print(f"  笔画有真实的粗细变化、墨水浓淡、边缘渐变")
    print(f"  能看到笔锋、转折、连笔等手写特征")

except Exception as e:
    print(f"无法加载MNIST: {e}")
    print("用模拟数据代替...")
