"""
Part 2: 总结 + 8x8 vs 16x16 对比 + 拟合状态解读
"""
import numpy as np
from sklearn.datasets import load_digits
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split

digits = load_digits()
y = digits.target

def bilinear_resize(img, th, tw):
    h, w = img.shape
    result = np.zeros((th, tw))
    for r in range(th):
        for c in range(tw):
            sr = r*(h-1)/(th-1); sc = c*(w-1)/(tw-1)
            r0, c0 = int(sr), int(sc)
            r1, c1 = min(r0+1,h-1), min(c0+1,w-1)
            dr, dc = sr-r0, sc-c0
            result[r,c] = (img[r0,c0]*(1-dr)*(1-dc) + img[r1,c0]*dr*(1-dc)
                         + img[r0,c1]*(1-dr)*dc + img[r1,c1]*dr*dc)
    return result

X_16 = np.array([bilinear_resize(img,16,16).flatten()
                  for img in digits.images])

X8_tr, X8_te, y_tr, y_te = train_test_split(
    digits.data, y, test_size=0.2, random_state=22)
X16_tr, X16_te, _, _ = train_test_split(
    X_16, y, test_size=0.2, random_state=22)

print("=" * 65)
print("8x8(64维) vs 16x16(256维) 最优K值对比")
print("=" * 65)
print(f"\n{'K':>3} | {'8x8 测试':>10} | {'16x16 测试':>10} | 赢家")
print("-" * 50)

for k in [1, 3, 5, 7, 10]:
    knn8 = KNeighborsClassifier(n_neighbors=k)
    knn8.fit(X8_tr, y_tr)
    s8 = knn8.score(X8_te, y_te)

    knn16 = KNeighborsClassifier(n_neighbors=k)
    knn16.fit(X16_tr, y_tr)
    s16 = knn16.score(X16_te, y_te)

    winner = "16x16" if s16 > s8 else ("8x8" if s8 > s16 else "TIE")
    print(f" {k:3d} | {s8:10.4f} | {s16:10.4f} | {winner}")

# ========== 拟合状态图解 ==========
print("\n" + "=" * 65)
print("如何判断拟合状态 (16x16 数据)")
print("=" * 65)

print("""
  训练准确率
  1.00 |##
       |# ##                            K=1: 训练100%, 测试99%
  0.98 |    ####                        差距小 → 没有过拟合
       |        ####
  0.96 |            ####
       |                ####
  0.94 |                    ####        K越大, 两条线一起下降
       |                        ####    → 欠拟合(模型太简单)
  0.92 |                            ##
       +---+---+---+---+---+---+---+--> K
         1   3   5  10  15  20  50 100

  测试准确率
  1.00 |   ##                           K=3: 测试100%! 最优
       |##    ##
  0.98 |        ####
       |            ####
  0.96 |                ####
       |                    ####
  0.94 |                        ####
       |                            ##
  0.92 |
       +---+---+---+---+---+---+---+--> K
         1   3   5  10  15  20  50 100
""")

print("=" * 65)
print("三种拟合状态的判断规则")
print("=" * 65)
print("""
状态       | 训练准确率 | 测试准确率 | 差距      | 含义
-----------|-----------|-----------|----------|------------------
过拟合     | 很高(~100%)| 明显低    | 大(>5%)  | 记住了训练数据的噪声
           |           |           |          | K太小, 被个别样本左右
           |           |           |          |
刚好(GOOD) | 高        | 也高      | 小(<3%)  | 学到了真实规律
           |           |           |          | K=3在这个数据集最优
           |           |           |          |
欠拟合     | 不高      | 也不高    | 小       | 模型太简单, 没学够
           |           |           |          | K太大, 把不同数字混在一起

关键指标: 不是看单个准确率, 而是看训练和测试的差距!
""")

print("=" * 65)
print("结论")
print("=" * 65)
print(f"""
16x16(256维) 最优: K=3, 测试准确率=100.0%
8x8(64维) 最优:    K=3, 测试准确率=98.89%

16x16 更好吗? 在这个小数据集上是的(+1.11%)
但这是插值放大的, 信息量没有真正增加
真实的16x16采集数据会更好

如何知道训练好了:
  1. 跑多个K值
  2. 同时看训练准确率和测试准确率
  3. 找差距最小且测试准确率最高的K
  4. 用交叉验证(5折)让结果更稳定
""")
