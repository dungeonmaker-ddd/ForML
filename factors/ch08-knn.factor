# use-this-graph-to-build: ch08 KNN算法
# scope: ML-intro-chapter-08
# status: pending

# ── core: KNN 思想 ──
knn: [K-Nearest-Neighbors-K近邻算法, 核心思想:根据离你最近的K个邻居的类别来判断你的类别, 物以类聚-近朱者赤, critical]
knn.lazy: [惰性学习-lazy-learning, 没有显式训练过程, 预测时才计算距离做判断, critical]
knn.k: [K值:选取最近邻居的数量, K太小容易受噪声影响-过拟合, K太大分类界限模糊-欠拟合, critical]

# ── core: 分类与回归 ──
knn.classification: [KNN分类, 找到K个最近邻-投票法-少数服从多数, 输出:离散类别标签, critical]
knn.regression: [KNN回归, 找到K个最近邻-取均值, 输出:连续数值, critical]
knn.flow: [KNN处理流程, 1-计算待预测点与所有训练样本的距离, 2-按距离排序取前K个, 3-分类:投票-回归:均值, critical]

# ── core: KNN算法API ──
knn.api.classifier: [sklearn.neighbors.KNeighborsClassifier, 参数:n_neighbors=K值-algorithm=距离算法, critical]
knn.api.regressor: [sklearn.neighbors.KNeighborsRegressor, 参数:n_neighbors=K值, important]

# ── core: 距离度量 ──
distance: [距离度量-distance-metric, KNN的核心计算, 不同距离公式衡量样本间相似度, critical]
distance.euclidean: [欧氏距离-Euclidean, 最常用, 两点间直线距离, sqrt(sum((xi-yi)^2)), critical]
distance.manhattan: [曼哈顿距离-Manhattan, 各维度差的绝对值之和, sum(|xi-yi|), 城市街区距离, important]
distance.minkowski: [闵可夫斯基距离-Minkowski, 欧氏和曼哈顿的推广, p=1曼哈顿-p=2欧氏, important]

# ── core: 特征预处理 ──
preprocessing: [特征预处理, KNN基于距离计算-量纲差异会严重影响结果, 必须做预处理, critical]
preprocessing.normalization: [归一化-MinMaxScaler, 将数据缩放到0-1范围, 公式:x'=(x-min)/(max-min), 适用:已知数据范围-无明显异常值, critical]
preprocessing.standardization: [标准化-StandardScaler, 转换为均值0标准差1, 公式:x'=(x-mean)/std, 适用:数据有异常值-大多数ML任务, critical]
preprocessing.why-knn: [KNN为何必须预处理:量纲大的特征主导距离计算, 量纲小的特征被忽略, 导致结果失真, critical]
preprocessing.iris: [鸢尾花识别案例, 用KNN分类鸢尾花-体现预处理对分类效果的影响, important]

# ── core: 超参数选择 ──
hyperparameter: [超参数-hyperparameter, 模型训练前需要人为设定的参数, 如KNN的K值, 不是从数据学来的, critical]
cross-validation: [交叉验证-cross-validation, 将训练集分成N份-轮流用1份做验证其余做训练, N次结果取平均, 更可靠地评估模型, critical]
cross-validation.k-fold: [K折交叉验证, 数据分K份-每份轮流做验证集-共K次训练, 常用K=5或K=10, critical]
grid-search: [网格搜索-GridSearchCV, 穷举所有超参数组合, 配合交叉验证找到最优超参数, critical]
grid-search.api: [sklearn.model_selection.GridSearchCV, 参数:estimator-param_grid-cv, 输出:best_params_-best_score_, important]
hyperparameter.mnist: [手写数字识别案例, 用KNN+网格搜索识别0-9手写数字, 体现超参数选择对模型效果的影响, important]

# ── edges ──
knn -> knn.classification: [KNN用于分类任务, critical]
knn -> knn.regression: [KNN用于回归任务, critical]
knn -> knn.flow: [KNN的具体处理步骤, critical]
knn -> knn.lazy: [KNN是惰性学习算法, important]

knn.flow -> distance: [流程第一步需要计算距离, critical]
distance -> distance.euclidean: [欧氏距离是最常用的度量, critical]
distance -> distance.manhattan: [曼哈顿距离是备选度量, important]
distance -> distance.minkowski: [闵氏距离是通用推广, important]

distance -> preprocessing: [距离计算受量纲影响-必须做预处理, critical]
preprocessing -> preprocessing.normalization: [归一化是预处理方法之一, critical]
preprocessing -> preprocessing.standardization: [标准化是预处理方法之一, critical]

knn.k -> hyperparameter: [K值是KNN最重要的超参数, critical]
hyperparameter -> cross-validation: [交叉验证评估超参数效果, critical]
hyperparameter -> grid-search: [网格搜索穷举最优超参数, critical]
cross-validation -> grid-search: [网格搜索内部使用交叉验证, critical]

knn.api.classifier -> knn.classification: [分类API对应分类任务, important]
knn.api.regressor -> knn.regression: [回归API对应回归任务, important]

# ~95%
