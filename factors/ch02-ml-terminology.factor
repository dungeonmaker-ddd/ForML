# use-this-graph-to-build: ch02 机器学习常用术语
# scope: ML-intro-chapter-02
# status: pending

# core — 四大基础术语
sample: [样本-sample, 一行数据就是一个样本, 多个样本组成数据集, 又称一条记录, critical]
feature: [特征-feature, 一列数据一个特征, 又称属性, 是非常关键的信息, critical]
label: [标签-label/target, 模型要预测的那一列数据, 如就业薪资或房屋售价, critical]
dataset: [数据集, 由多个样本组成, 每行是样本-每列是特征, 最后一列通常是标签, critical]

# core — 数据集划分
dataset.split: [划分为训练集和测试集, 比例:8比2或7比3, critical]
training-set: [训练集-training-set, 用来训练模型的数据集, critical]
testing-set: [测试集-testing-set, 用来测试模型的数据集, critical]
dataset.split.analogy: [高考试卷和模拟试卷不应相同, 训练数据和测试数据必须分离, 防止数据泄漏, important]

# core — 训练与测试流程
model.training: [用训练集学习参数, 模型拟合数据分布, critical]
model.testing: [用测试集评估效果, 衡量泛化能力, critical]
model.training -> model.testing: [先训练后测试, 分阶段评估, critical]

# edge
sample -> feature: [一个样本包含多个特征, 横向与纵向关系, important]
feature -> label: [特征是输入-标签是输出, 模型学习特征到标签的映射, critical]
training-set -> model.training: [训练集驱动模型学习, critical]
testing-set -> model.testing: [测试集验证模型效果, critical]

# ~92%
