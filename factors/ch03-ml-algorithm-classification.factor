# use-this-graph-to-build: ch03 机器学习算法分类
# scope: ML-intro-chapter-03
# status: pending

# core — 四大学习方式
supervised: [监督学习-supervised-learning, 输入:有标签, 输出:有反馈, 目的:预测结果, 案例:猫狗分类-房价预测, critical]
supervised.regression: [回归, 输出是连续值, 如房价预测, critical]
supervised.classification: [分类, 输出是有限个离散值, 如猫狗分类, critical]

unsupervised: [无监督学习-unsupervised-learning, 输入:无标签-但必须有特征, 输出:无反馈, 目的:发现潜在结构, 案例:物以类聚-人以群分, critical]
unsupervised.clustering: [聚类, 按特征相似性分组, 没有标准固定归类, 结果与超参数有关, critical]
unsupervised.key-points: [训练数据无标签-必须有特征, 根据样本间特征相似性聚类, 发现事物内部结构及相互关系, critical]

semi-supervised: [半监督学习-semi-supervised-learning, 输入:部分有标签-部分无标签, 输出:有反馈, 目的:降低数据标记难度, important]

reinforcement: [强化学习-reinforcement-learning, 输入:决策流程及激励系统, 输出:一系列行动, 目的:长期利益最大化, 案例:学下棋, important]
reinforcement.elements: [四要素:Agent智能体-Environment环境-Action行动-Reward奖励, 通过试错获取最佳策略, important]

# core — 数学表示要点
supervised.math: [输入X含特征值, 输出Y含目标值, 学习X到Y的映射函数, critical]
unsupervised.math: [输入X含特征值, 无目标值Y, 学习X的内部结构, critical]

# edges
supervised -> supervised.regression: [回归是监督学习子类型, critical]
supervised -> supervised.classification: [分类是监督学习子类型, critical]
unsupervised -> unsupervised.clustering: [聚类是无监督学习典型方法, critical]
reinforcement -> reinforcement.elements: [四元素构成强化学习框架, important]

# ============================================================
# homework.Q2 — 有监督学习和无监督学习的各自特点及区别
# ============================================================

# 答题线索：先分别阐述特点，再对比区别

# — 监督学习特点
homework.supervised.trait-1: [训练数据同时包含特征X和标签Y, 数据有明确的正确答案, critical]
homework.supervised.trait-2: [模型学习特征到标签的映射函数f:X->Y, 目标是预测新样本的标签, critical]
homework.supervised.trait-3: [训练过程有反馈:模型预测值与真实标签对比-计算loss-调整参数, critical]
homework.supervised.trait-4: [两大子任务:回归-输出连续值如房价, 分类-输出离散值如猫狗, critical]

# — 无监督学习特点
homework.unsupervised.trait-1: [训练数据只有特征X-没有标签Y, 没有标准正确答案, critical]
homework.unsupervised.trait-2: [模型学习数据内部结构和分布规律, 发现样本间的相似性和隐藏模式, critical]
homework.unsupervised.trait-3: [训练过程无反馈:没有标签就无法直接评判对错, critical]
homework.unsupervised.trait-4: [典型任务:聚类-按特征相似性将样本自动分组, 聚类结果与超参数有关-没有唯一标准划分, critical]

# — 核心区别对比
homework.contrast.data: [监督:有标签有反馈, 无监督:无标签无反馈, 数据形态是根本区别, critical]
homework.contrast.goal: [监督:预测已知类别的结果, 无监督:发现未知的内部结构, 目标导向不同, critical]
homework.contrast.evaluation: [监督:可用准确率-loss等指标直接评估, 无监督:评估困难-缺乏标准答案, important]
homework.contrast.example: [监督:给标注好的猫狗图片-学会区分猫狗, 无监督:给一堆未标注图片-自动按相似性分成几组, important]

# ~95%
