# use-this-graph-to-build: ch01 AI/ML/DL 三大概念
# scope: ML-intro-chapter-01
# status: pending

# core — 三层嵌套关系：AI 包含 ML，ML 包含 DL
ai: [artificial-intelligence, 最大范畴, 包含:专家系统|模糊逻辑|进化计算|多智能体系统|知识表示|推荐系统|机器人与感知, critical]
ml: [machine-learning, AI子集, 从数据中自动学习规律, 产生模型, 区别于基于规则的系统, critical]
dl: [deep-learning, ML子集, 基于神经网络的学习方法, critical]

# core — 嵌套关系：AI > ML > DL
ai -> ml: [ml-is-subset-of-ai, 机器学习是人工智能的核心分支, critical]
ml -> dl: [dl-is-subset-of-ml, 深度学习是机器学习的特定方法族, critical]

# core — ML 的本质学习方式
ml.learning-essence: [利用线性表达式, 自动从数据获取规律, 产生模型, 这就是机器学习, critical]
ml.vs-rule-based: [与基于规则的学习有本质区别, 规则系统靠人工编写if-else, ML靠数据驱动, critical]

# core — ML 包含的典型算法
ml.algorithms: [回归|分类|聚类|决策树|贝叶斯模型|支持向量机|自适应增强算法|最大期望算法, feeds-algorithm-classification, important]

# core — 房价预测示例：理解输入输出
ml.example-house-price: [输入:面积-特征, 输出:售价-标签, 横向一行为一个样本, critical]
ml.example-house-price.linear-model: [y=wx+b, w-斜率-控制倾斜度, b-截距-控制上下平移, 需要学习参数w和b, critical]
ml.example-house-price.flow: [样本画入坐标-得到数据点分布, 用线性模型描述规律, 训练学习参数, 训练好后开始预测, critical]

# ~90%
