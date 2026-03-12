"""
16x16 噪声实验 Part 2: 加噪声后的鲁棒性测试
"""
import numpy as np
from sklearn.neighbors import KNeighborsClassifier

def make_eight_16():
    img = np.zeros((16, 16))
    for c in range(5, 11): img[2, c] = 15
    for c in range(5, 11): img[7, c] = 15
    for c in range(5, 11): img[12, c] = 15
    for r in range(2, 8):  img[r, 5] = 15
    for r in range(2, 8):  img[r, 10] = 15
    for r in range(7, 13): img[r, 5] = 15
    for r in range(7, 13): img[r, 10] = 15
    return img

def make_six_16():
    img = np.zeros((16, 16))
    for c in range(5, 11): img[2, c] = 15
    for c in range(5, 11): img[7, c] = 15
    for c in range(5, 11): img[12, c] = 15
    for r in range(2, 8):  img[r, 5] = 15
    for r in range(7, 13): img[r, 5] = 15
    for r in range(7, 13): img[r, 10] = 15
    return img

def make_nine_16():
    img = np.zeros((16, 16))
    for c in range(5, 11): img[2, c] = 15
    for c in range(5, 11): img[7, c] = 15
    for c in range(5, 11): img[12, c] = 15
    for r in range(2, 8):  img[r, 5] = 15
    for r in range(2, 8):  img[r, 10] = 15
    for r in range(7, 13): img[r, 10] = 15
    return img

def show(name, img):
    print(f"\n{name}:")
    for row in img:
        print(" ".join("#" if p > 0 else "." for p in row))

def dist(a, b):
    return np.sqrt(np.sum((a.astype(float) - b.astype(float)) ** 2))

eight = make_eight_16()
six   = make_six_16()
nine  = make_nine_16()

# ========== 噪声类型1: 单像素断裂 (和8x8一样) ==========
eight_break1 = eight.copy()
eight_break1[3, 10] = 0   # 右上竖线断一个点

print("=== 测试1: 单像素断裂 ===")
show("8-单点断裂(右上)", eight_break1)
d6 = dist(eight_break1, six)
d9 = dist(eight_break1, nine)
print(f"  vs 6: {d6:.2f}")
print(f"  vs 9: {d9:.2f}")
print(f"  还是8吗? 离6更近={d6<d9}, 离9更近={d9<d6}")

# ========== 噪声类型2: 多像素随机噪声 ==========
np.random.seed(42)
eight_random = eight.copy()
noise_positions = [(0,2), (1,13), (14,7), (15,1), (6,0), (13,14)]
for r, c in noise_positions:
    eight_random[r, c] = np.random.randint(8, 15)

print("\n=== 测试2: 随机噪点(6个) ===")
show("8-随机噪点", eight_random)
d6 = dist(eight_random, six)
d9 = dist(eight_random, nine)
d8 = dist(eight_random, eight)
print(f"  vs 干净8: {d8:.2f}")
print(f"  vs 6: {d6:.2f}")
print(f"  vs 9: {d9:.2f}")

# ========== 噪声类型3: 右上整段断裂(模拟真实笔画缺失) ==========
eight_break_seg = eight.copy()
eight_break_seg[3, 10] = 0
eight_break_seg[4, 10] = 0
eight_break_seg[5, 10] = 0  # 右上竖线断了3个像素

print("\n=== 测试3: 右上竖线断3个像素(严重噪声) ===")
show("8-右上断裂x3", eight_break_seg)
d6 = dist(eight_break_seg, six)
d9 = dist(eight_break_seg, nine)
d8 = dist(eight_break_seg, eight)
print(f"  vs 干净8: {d8:.2f}")
print(f"  vs 6: {d6:.2f}")
print(f"  vs 9: {d9:.2f}")
winner = "6" if d6 < d9 else "9"
print(f"  KNN会判成: {winner}")

# ========== KNN 综合测试 ==========
print("\n=== KNN(K=1) 综合预测 ===")
X_train = np.array([
    eight.flatten(), six.flatten(), nine.flatten()
]).astype(float)
y_train = np.array([8, 6, 9])

knn = KNeighborsClassifier(n_neighbors=1)
knn.fit(X_train, y_train)

tests = [
    ("单点断裂", eight_break1),
    ("随机噪点", eight_random),
    ("右上断3点", eight_break_seg),
]
for name, img in tests:
    pred = knn.predict([img.flatten().astype(float)])[0]
    print(f"  {name} -> 预测:{pred}  真实:8  {'OK' if pred==8 else 'WRONG!'}")

# ========== 关键对比: 8x8 vs 16x16 的容错率 ==========
print("\n=== 核心对比: 分辨率 vs 容错 ===")
print(f"8x8:  干净距离=15.00, 1像素断裂=距离归零(0.00)")
print(f"16x16: 干净距离=30.00, 1像素断裂=距离{dist(eight_break1, six):.2f}")
print(f"16x16: 干净距离=30.00, 3像素断裂=距离{dist(eight_break_seg, six):.2f}")
pct1 = dist(eight_break1, six) / 30.0 * 100
pct3 = dist(eight_break_seg, six) / 30.0 * 100
print(f"\n1像素噪声占干净距离的比例: 16x16保留了{pct1:.0f}%的区分度")
print(f"3像素噪声占干净距离的比例: 16x16保留了{pct3:.0f}%的区分度")
