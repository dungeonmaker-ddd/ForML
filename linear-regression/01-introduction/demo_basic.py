import numpy as np
from sklearn.linear_model import LinearRegression

# === 最简单的例子：1个特征，3个数据点 ===

# 数据
X = np.array([[50], [80], [100]])   # 面积 (m²)
y = np.array([150, 250, 300])       # 房价 (万)

# --- 手算过程 ---
print("=" * 50)
print("手算过程")
print("=" * 50)

# 第一步：随便猜 w=1, b=0
w_guess, b_guess = 1, 0
y_pred_guess = w_guess * X.flatten() + b_guess
mse_guess = np.mean((y - y_pred_guess) ** 2)
print(f"\n随便猜 w={w_guess}, b={b_guess}")
print(f"预测值: {y_pred_guess}")
print(f"真实值: {y}")
print(f"MSE = {mse_guess:.1f}  ← 很大，猜得差")

# 第二步：正规方程手算
n = len(X)
sum_x = X.sum()
sum_y = y.sum()
sum_xy = (X.flatten() * y).sum()
sum_x2 = (X.flatten() ** 2).sum()

w_hand = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x ** 2)
b_hand = (sum_y - w_hand * sum_x) / n

y_pred_hand = w_hand * X.flatten() + b_hand
mse_hand = np.mean((y - y_pred_hand) ** 2)

print(f"\n正规方程手算: w={w_hand:.3f}, b={b_hand:.3f}")
print(f"预测值: {np.round(y_pred_hand, 1)}")
print(f"真实值: {y}")
print(f"MSE = {mse_hand:.1f}  ← 很小，拟合好")

# --- sklearn 验证 ---
print("\n" + "=" * 50)
print("sklearn 验证")
print("=" * 50)

model = LinearRegression()
model.fit(X, y)

print(f"\nsklearn 算出: w={model.coef_[0]:.3f}, b={model.intercept_:.3f}")
print(f"预测值: {np.round(model.predict(X), 1)}")
print(f"MSE = {np.mean((y - model.predict(X)) ** 2):.1f}")

print(f"\n手算和sklearn结果一致！")

# --- 预测新数据 ---
print("\n" + "=" * 50)
print("预测新房子")
print("=" * 50)
new_area = np.array([[70], [90], [120]])
predictions = model.predict(new_area)
for area, price in zip(new_area.flatten(), predictions):
    print(f"面积 {area}m² → 预测房价 {price:.1f}万")
