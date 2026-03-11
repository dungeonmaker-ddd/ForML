# use-this-graph-to-build: ch08 KNN算法概览
# confirm-sufficiency-before-start: 本图谱覆盖KNN思想、分类/回归流程、K值选择、距离度量、预处理需求，3内容页布局
# scope: ML-intro-chapter-08
# status: pending

# ═══ Page 1: KNN思想 + 分类/回归流程 ═══

KNN思想: [K-Nearest-Neighbors-K近邻算法, 核心:在特征空间中找K个最近邻-用它们的类别/值决定未知样本, 直觉:物以类聚-近朱者赤-你的邻居决定你的类别, critical]
KNN思想.惰性学习: [lazy-learning-惰性学习, 无显式训练过程-不构建参数模型-存储全部训练数据, 预测时才遍历计算距离, 对比:线性模型学习权重w和b->KNN无参数可学, 面试追问:KNN有训练过程吗->没有-它是惰性学习, critical]

KNN分类: [KNN分类流程5步, 1-计算未知样本到每个训练样本的距离, 2-按距离升序排列, 3-取前K个最近邻, 4-多数表决:统计K个邻居中各类别数量, 5-归属出现最多的类别, 输出:离散标签, critical]
KNN回归: [KNN回归流程5步, 1-计算距离->2-升序排列->3-取前K个, 4-对K个样本的目标值求均值, 5-均值作为预测值, 输出:连续数值, critical]
KNN分类vs回归: [前3步完全相同:计算距离-排序-取K, 分歧在第4步:分类用投票(多数表决)|回归用均值, 面试必答:一句话说出区别->第4步不同:投票vs均值, critical]

# ═══ Page 2: K值选择 + API ═══

K值: [KNN唯一核心超参数, 不从数据中学来-需人为设定, K值直接决定模型复杂度和预测效果, critical]
K值.过小: [K过小(如K=1)->极小邻域-只看最近的一个邻居, 后果:对噪声和异常点极敏感-坐标微变即分类翻转-决策边界极复杂, 本质:记住噪声而非规律->过拟合, feeds-ch06-过拟合, critical]
K值.过大: [K过大(极端K=N)->看全部训练样本, 后果:永远预测训练集中最多的类别-忽略局部特征-受类别不均衡支配, 本质:丢失局部判别力->欠拟合, feeds-ch06-欠拟合, critical]
K值.实践: [取较小奇数避免平局:3|5|7|9, 用交叉验证遍历候选K值选最优, 工程经验:通常K=5是不错的默认值, feeds-ch09-交叉验证+网格搜索, important]

KNN-API: [sklearn两个API:KNeighborsClassifier(分类)+KNeighborsRegressor(回归), 默认n_neighbors=5, 用法:fit(X,y)->predict(X)->score(X,y), important]
KNN-API.陷阱: [predict输入必须二维:predict([[1]])正确|predict([1])报错, 原因:sklearn统一要求矩阵输入-即使单样本也要双层方括号, 面试代码题高频考点, important]

# ═══ Page 3: 距离度量 + 预处理需求 ═══

距离度量: [distance-metric-距离度量, KNN核心计算基础, 不同距离公式衡量样本间相似度, critical]
距离度量.欧氏: [Euclidean-Distance-欧氏距离, d=sqrt(sum((xi-yi)²)), 两点间直线距离-勾股定理推广到n维, KNN默认距离, critical]
距离度量.曼哈顿: [Manhattan-Distance-曼哈顿距离, d=sum(|xi-yi|), 城市街区距离:只走横平竖直, important]
距离度量.闵氏: [Minkowski-Distance-闵氏距离, 统一框架:d=(sum(|xi-yi|^p))^(1/p), p=1:曼哈顿|p=2:欧氏|p->∞:切比雪夫, 不是新距离-是统一公式, feeds-ch09-闵氏距离深入+p无穷推导, critical]

预处理需求: [KNN基于距离->量纲不同的特征会主导距离计算, 例:年收入(万级)vs年龄(十级)->收入差异淹没年龄差异->结果失真, 预处理是KNN的前置刚需-不做则结果不可信, feeds-ch09-归一化vs标准化详解+fit_transform铁律, critical]
预处理需求.方法预告: [归一化MinMaxScaler:映射到[0,1]-受极值影响, 标准化StandardScaler:转换为N(0,1)-受均值std驱动更鲁棒, 详见ch05概念介绍-ch09实战落地, important]

# ~96%
