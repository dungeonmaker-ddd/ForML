# use-this-graph-to-build: ch02 机器学习常用术语
# scope: ML-intro-chapter-02
# status: pending

# ── core: 四大基础术语 ──
sample: [样本-sample, 一行数据就是一个样本, 又称一条记录, 多个样本组成数据集, critical]
feature: [特征-feature, 一列数据一个特征, 又称属性, 是非常关键的信息, critical]
label: [标签-label/target, 模型要预测的那一列数据, 如就业薪资-房屋售价, critical]
dataset: [数据集-dataset, 由多个样本组成, 行是样本-列是特征-末列通常是标签, 结构:二维表格, critical]

# ── core: 术语间的结构关系 ──
sample -> feature: [一个样本横向包含多个特征, 行与列的关系, critical]
feature -> label: [特征是输入-标签是输出, 模型学习特征到标签的映射, critical]
sample -> dataset: [多个样本纵向堆叠组成数据集, 聚合关系, important]

# ── core: 数据集划分 ──
dataset.split: [数据集必须划分为训练集和测试集, 常见比例:8比2或7比3, critical]
training-set: [训练集-training-set, 用来训练模型-学习参数, critical]
testing-set: [测试集-testing-set, 用来测试模型-评估效果, critical]
dataset.split.analogy: [类比:高考试卷和模拟试卷不应相同, 训练数据和测试数据必须分离-防止数据泄漏, important]

dataset -> dataset.split: [数据集需要划分才能使用, 前置操作, critical]
dataset.split -> training-set: [划分产出训练集, critical]
dataset.split -> testing-set: [划分产出测试集, critical]

# ── core: 训练与测试的关系 ──
training-set -> testing-set: [先用训练集学习-再用测试集验证, 先训练后测试-分阶段评估, critical]

# ~94%
