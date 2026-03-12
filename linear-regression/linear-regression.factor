# use-this-graph-to-build: 线性回归 — 从公式到实战全流程
# confirm-sufficiency-before-start
# link-back-after-build
# scope: linear-regression-day03
# status: updated

# ═══ 1. 定义与定位 ═══

introduction: [define-linear-regression, supervised-learning-regression-type, find-best-fit-line, input-feature-to-continuous-output, feeds-solving-methods, critical]
introduction.classification: [simple-linear:single-feature:y=wx+b, multiple-linear:multi-feature:y=w1x1+w2x2+...+b, distinguish-by-feature-count, 一元:二维平面一条线, 多元:高维超平面, critical]
introduction.scenario: [house-price-prediction, sales-forecasting, salary-estimation, continuous-value-output-only, not-for-classification-task, critical]
introduction.significance: [ML入门基石:模型+损失+优化+评估完整闭环, 可解释性:w直接反映特征影响力(w大=影响大,w正=正相关,w负=负相关,w≈0=无用), 后续扩展:加sigmoid->逻辑回归->分类, critical]
introduction.vs-KNN: [KNN:懒惰学习-不产出模型-预测时遍历全部数据算距离, LR:训练时算出w和b-预测时代入公式一步出结果, 核心区别:有没有学出一个公式, KNN预测慢(O(m·n))-LR预测快(O(n)), 共同点:都是监督学习-都复用特征/标签/训练集/测试集概念, critical]
introduction.input-output: [x:多个特征(面积/楼层/房龄等), y:你定的一个目标值(房价), 方向:所有x->预测一个y-不是反过来, y不需要标准化-模型通过w和b自动适配y的量级, critical]

# ═══ 2. 数据预处理 ═══

preprocessing: [LR处理数值型表格数据, 预处理核心:特征缩放-让所有特征量级对齐, feeds-solving, critical]
preprocessing.standardization: [Z-score:x'=(x-μ)/σ, 结果:均值=0-标准差=1-约95%落在±2, 线性回归首选, 正规方程:可跳过标准化-结果一样, 梯度下降:必须标准化-否则收敛极慢, critical]
preprocessing.normalization: [Min-Max:x'=(x-min)/(max-min), 结果:映射到[0,1], 适合:已知范围-无异常值-像素0~255, 区分:标准化≠归一化-面试常考, important]
preprocessing.scaler-persistence: [fit:记住训练集的均值和标准差, transform:用记住的均值标准差缩放数据, fit_transform:两步合一-仅用于训练集, 测试集/新数据只用transform-复用训练集的尺子, 原因:真实场景新数据来了不可能提前知道它的均值, critical]
preprocessing.scaler-api: [from-sklearn.preprocessing-import-StandardScaler, scaler=StandardScaler(), X_train_scaled=scaler.fit_transform(X_train), X_test_scaled=scaler.transform(X_test), 属性:mean_-var_-scale_, critical]
preprocessing.why-standardize: [未标准化:面积=120-距地铁=0.8->模型以为面积重要150倍(纯因数字大), 标准化后:面积=1.24-距地铁=0.95->模型公平比较真正影响, 标准差的作用:统一量级-除以标准差把数据压缩到±2范围, critical]

# ═══ 3. 损失函数与碗形保证 ═══

solving: [transform-fitting-to-optimization, minimize-prediction-error, feeds-evaluation, critical]
solving.loss-function: [MSE:mean-squared-error:L=1/n*sum(yi-yi_hat)^2, 训练时用MSE:平方函数处处可导-梯度下降算得顺畅, MAE在0点有尖角不可导, MSE对大误差特别敏感:偏差10->平方100-偏差40->平方1600, critical]
solving.loss-choice: [训练模型时->MSE(数学上好算), 评估模型时->RMSE或MAE(人能看懂), MSE单位是y²不直观-RMSE开根号回到y的单位, MSE没有绝对好坏标准-要看y的量级, 实际中三个都算一遍看看, critical]
solving.bowl-shape: [MSE=(y-wx)²对w是二次函数->碗形, 数学保证:二次函数只有一个极值点=全局最小, 多数据点:碗+碗+碗=更大的碗-不会出现两个谷底, 多参数(w1,w2):三维碗-同心椭圆-中心=最优解, 结论:求导=0找到的点一定是全局最优, critical]
solving.linearity-key-insight: [线性回归的"线性"指:对参数w是线性的-不是对数据x, x有平方项(面积²)仍是线性回归:面积²当作新特征-对w还是一次, MSE对w永远是二次->碗形保证不变, 面试易混淆点, critical]
solving.derivative-meaning: [∂MSE/∂w:告诉你w该往哪调, 导数<0->w太小-增大, 导数>0->w太大-减小, 导数=0->最优解-不用调了, 导数大小=离最低点远近, critical]

# ═══ 4. 数据表示与矩阵 ═══

solving.data-representation: [feature-matrix:X:shape-n-by-m, target-vector:y:shape-n, weight-vector:w:shape-m, bias-scalar:b, matrix-notation:Y=XW+b, critical]
solving.matrix-role: [矩阵=把数据打包批量算, 无矩阵:100万条数据写100万行公式, 有矩阵:y_pred=X@w+b一行搞定, X每行×w=一条数据的预测值-所有行同时算出, 正规方程用矩阵:一个公式解出所有w, 不需要手算矩阵-numpy/sklearn封装好了, important]

# ═══ 5. 求解方法 ═══

solving.normal-equation: [closed-form:w=(X^T*X)^-1*X^T*y, 一步出结果-精确解, O(n^3)-complexity, 适用:特征数<10000-数据量不大, sklearn的LinearRegression默认用正规方程, critical]
solving.normal-equation.code: [手算版:一元简化公式-w=(n*Σxy-Σx*Σy)/(n*Σx²-(Σx)²), 矩阵版:X_b=np.c_[ones,X]->w=np.linalg.inv(X_b.T@X_b)@X_b.T@y, sklearn版:model.fit(X,y)->model.coef_得w->model.intercept_得b, 三种写法结果完全一致, important]
solving.normal-equation.model-fit: [model.fit(X,y)内部三步:1-组装矩阵, 2-算(XᵀX)⁻¹Xᵀy, 3-存到coef_(w)和intercept_(b), 跑完=训练好了, predict(X_new)内部=X_new@w+b, 几毫秒完事, important]
solving.gradient-descent: [iterative-optimization, update-rule:w=w-alpha*dL/dw, alpha:learning-rate:controls-step-size, converge-to-minimum, types:batch-GD|SGD|mini-batch-GD, 必须标准化, sklearn用SGDRegressor, critical]
solving.comparison: [正规方程:无超参数|精确解|数据大时慢|可跳过标准化, 梯度下降:需学习率|迭代逼近|数据再大也能跑|必须标准化, 选择:数据小->正规方程-数据大->梯度下降, 两者算出的结果一样-只是计算方式不同-不是递进关系, critical]

# ═══ 6. 评估指标 ═══

evaluation: [measure-model-quality-on-test-set, MSE是整个测试集误差的平均值, feeds-api-and-case, critical]
evaluation.MAE: [mean-absolute-error:1/n*sum|yi-yi_hat|, 最直觉:平均偏了多少, 单位同y, 对大误差平等对待, 评估时看, important]
evaluation.MSE: [mean-squared-error:1/n*sum(yi-yi_hat)^2, 平方放大大误差, 单位是y², 训练时用(可导), default-loss-metric, critical]
evaluation.RMSE: [root-mean-squared-error:sqrt(MSE), 单位回到y-可直接和y对比, 最常用报告指标, 判断好坏:看RMSE相对y量级-房价百万级RMSE=20很好-房价几块RMSE=20很差, critical]
evaluation.practical: [碗形图->解释原理用-帮理解训练过程, MSE数值->实际判断模型好坏用, 不是看损失函数图像判断-是看算出来的数字, important]

# ═══ 7. 多项式特征与模型选择 ═══

polynomial: [当一次方程效果不好时-加平方项/次方项, 每个特征可有独立次方-还可交叉(面积×楼层), 本质:展开成更多特征列-模型本身还是线性计算, feeds-regularization, critical]
polynomial.api: [from-sklearn.preprocessing-import-PolynomialFeatures, poly=PolynomialFeatures(degree=2), degree=2:自动展开[1,x1,x2,x1²,x1×x2,x2²], degree设多少:循环试1-2-3-4-5-看测试集得分选最高, 不用手动挑哪个特征要平方, critical]
polynomial.risk: [特征数量爆炸:4特征degree=3->可能30-50个展开特征, 容易过拟合->需要正则化(L1/L2)控制, important]
model-selection: [先简单后复杂:一次方程->评估->不好再加平方项->还不行换模型(决策树/随机森林), 选公式不是第一步-是效果不好时才回头调整, 机器学习大量工作就是在"试"-试模型试特征试参数-很正常, critical]
model-selection.decision: [人决定:方程形状+损失函数+优化方法, 机器算:方程里的具体参数w和b, 没有完美公式-只有误差最小的公式, critical]

# ═══ 8. sklearn完整工作流 ═══

api-and-case: [sklearn.linear_model.LinearRegression, fit-predict-pattern, critical]
api-and-case.api: [import:from-sklearn.linear_model-import-LinearRegression, model=LinearRegression(), model.fit(X_train,y_train), y_pred=model.predict(X_test), coef_:learned-weights, intercept_:learned-bias, critical]
api-and-case.full-pipeline: [①train_test_split(X,y,test_size=0.2):80%训练20%测试, ②StandardScaler:fit_transform训练集-transform测试集, ③model.fit(X_train_scaled,y_train):训练, ④model.predict(X_test_scaled):预测, ⑤mean_squared_error(y_test,y_pred):评估, critical]
api-and-case.test-size: [test_size=0.2:留20%数据验证-模型训练时完全看不到, 专门检验"学到的东西对没见过的数据管不管用", important]
api-and-case.fit-ambiguity: [sklearn中fit出现两次含义不同, scaler.fit->记住统计量(均值/标准差), model.fit->训练模型(算w和b), 都叫fit但干的事不一样, important]
api-and-case.polynomial-upgrade: [效果不好时加两行:poly=PolynomialFeatures(degree=2), X_poly=poly.fit_transform(X_train), model.fit(X_poly,y_train), important]

# ═══ 9. 正则化 ═══

regularization: [prevent-overfitting, constrain-model-complexity, 多项式展开后特征爆炸时尤其需要, critical]
regularization.overfitting: [symptom:train-error-low|test-error-high, cause:model-too-complex|feature-too-many|data-too-few, learn-noise-not-pattern, critical]
regularization.underfitting: [symptom:train-error-high|test-error-high, cause:model-too-simple|feature-insufficient, fail-to-capture-pattern, critical]
regularization.L1: [Lasso:add-lambda*sum|wi|-to-loss, effect:sparse-weight|auto-feature-selection, drives-some-weight-to-zero, prefer-when:feature-selection-needed, critical]
regularization.L2: [Ridge:add-lambda*sum(wi^2)-to-loss, effect:shrink-weight|prevent-large-coefficient, never-zero-weight, prefer-when:all-features-relevant, default-regularization-choice, critical]

# ═══ 10. 学习回顾要点(day03 homework) ═══

homework: [day03回顾问答核心纠错, critical]
homework.q1-knn-vs-lr: [核心区别:模型产物-KNN不产出模型(懒惰学习)-LR产出参数w和b, "分类vs回归"是问题类型不同-但核心区别在有没有学出公式, critical]
homework.q2-standardization: ["标准化缩放到0~1"是错的->那是归一化(Min-Max), 标准化是Z-score:均值=0-标准差=1-约95%落在±2, critical]
homework.q3-why-mse: [MSE用平方:放大大误差+处处可导, MAE绝对值在0点有尖角不可导->优化算法不好算, critical]
homework.q4-polynomial-linearity: [ŷ=w1×面积+w2×面积²+b:面积²是数据变换不是参数平方, 对w还是一次->MSE对w还是二次->还是碗形, 这是线性回归最容易混淆的点, critical]
homework.q5-pipeline-correction: [错误认知:标准化是效果不好才做的->正确:标准化是前置预处理步骤, 错误认知:正规方程和梯度下降是递进关系->正确:同一步的两种工具-结果一样, 正确顺序:①预处理(标准化+缺失值)->②分割训练/测试集->③选公式->④训练->⑤评估->⑥不好则加复杂度, critical]

# ═══ edges ═══

introduction -> preprocessing: [数据准备, feeds, critical]
preprocessing -> solving: [标准化后送入求解, feeds, critical]
solving -> evaluation: [训练完评估, feeds, critical]
evaluation -> polynomial: [效果不好加复杂度, conditional-feeds, important]
polynomial -> regularization: [特征爆炸需正则化, feeds, critical]
evaluation -> api-and-case: [sklearn实现完整流程, feeds, critical]
model-selection -> solving: [选定公式后求解, feeds, critical]

# ~95%
