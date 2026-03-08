# use-this-graph-to-build: ch01 AI/ML/DL 三大概念
# scope: ML-intro-chapter-01
# status: pending

# ── core: 三层嵌套关系 ──
ai: [artificial-intelligence, 最大范畴, 包含:专家系统|模糊逻辑|进化计算|多智能体系统|知识表示|推荐系统|机器人与感知, critical]
ml: [machine-learning, AI子集, 从数据中自动学习规律-产生模型, 区别于基于规则的系统, critical]
dl: [deep-learning, ML子集, 基于神经网络的学习方法, critical]

ai -> ml: [ML是AI的核心分支, 包含关系, critical]
ml -> dl: [DL是ML的特定方法族, 包含关系, critical]

# ── core: ML 的本质 ──
ml.learning-essence: [利用线性表达式, 自动从数据中获取规律, 产生模型, 这就是机器学习-机器自动学习, critical]
ml.vs-rule-based: [与基于规则的系统有本质区别, 规则系统:人工编写if-else-数据仅用于查询, ML:数据驱动-自动提取规律, critical]

ml.learning-essence -> ml.vs-rule-based: [本质理解后才能辨别与规则系统的区别, 因果, critical]

# ── core: ML 包含的典型算法 ──
ml.algorithms: [回归|分类|聚类|决策树|贝叶斯模型|支持向量机|自适应增强算法|最大期望算法, feeds-ch03-algorithm-classification, important]

ml -> ml.algorithms: [ML下辖多种具体算法, 包含, important]

# ── core: 房价预测示例 ──
ml.example: [房价预测场景, 输入:面积-赐名特征, 输出:售价-赐名标签, 横向一行为一个样本, critical]
ml.example.linear-model: [线性模型:y=wx+b, w-斜率-控制直线倾斜度, b-截距-控制直线上下平移, w和b是需要学习的模型参数, critical]
ml.example.training-flow: [step1:样本画入坐标-得到n个数据点-观察分布, step2:选择线性模型描述规律, step3:训练学习参数w和b, step4:训练好后输入新面积-输出预测售价, critical]

ml.learning-essence -> ml.example: [用房价预测示例具象化ML学习本质, 示例印证, critical]
ml.example -> ml.example.linear-model: [示例中采用的具体模型, 选型, critical]
ml.example.linear-model -> ml.example.training-flow: [有了模型才能训练, 序列, critical]

# ~93%
