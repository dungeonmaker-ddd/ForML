# use-this-graph-to-build: ML入门课程 — 章节索引
# scope: ML-intro-course-overview
# status: pending

# core — 课程章节结构
course: [机器学习入门-机器学习概述, 共7个核心章节+1个课后作业章节+2个KNN算法章节, critical]

ch01: [AI-ML-DL三大概念, 嵌套关系-学习本质-线性模型示例, @factors/ch01-ai-ml-dl-concepts.factor, critical]
ch02: [ML常用术语, 样本-特征-标签-训练集-测试集, @factors/ch02-ml-terminology.factor, critical]
ch03: [ML算法分类, 监督-无监督-半监督-强化学习, @factors/ch03-ml-algorithm-classification.factor, critical]
ch04: [ML建模流程, 五步:获取数据-数据处理-特征工程-模型训练-模型评估, @factors/ch04-ml-modeling-pipeline.factor, critical]
ch05: [特征工程概念入门, 提取-预处理-降维-选择-组合, @factors/ch05-feature-engineering.factor, critical]
ch06: [模型拟合问题, 欠拟合-过拟合-泛化-奥卡姆剃刀-loss曲线, @factors/ch06-model-fitting.factor, critical]
ch07: [课后作业Q2-Q5, 监督vs无监督-建模流程-特征工程-拟合问题-跨章综合, @factors/ch07-homework.factor, critical]
ch08: [KNN算法, K近邻思想-距离度量-特征预处理-交叉验证-网格搜索, @factors/ch08-knn.factor, critical]
ch09: [KNN实战, 闵氏距离统一框架-归一化vs标准化-数据泄露-ML-Pipeline-交叉验证网格搜索-MNIST, @factors/ch09-knn-practice.factor, critical]

# note — 以下章节笔记内容较少，未单独建图
ch-app-history: [ML应用领域和发展史, 笔记待补充, low-priority]
ch-dev-env: [ML开发环境, 笔记待补充, low-priority]

# edges — 章节依赖关系
ch01 -> ch02: [理解概念后学术语, sequence, critical]
ch02 -> ch03: [掌握术语后理解算法分类, sequence, critical]
ch03 -> ch04: [知道算法类型后学建模流程, sequence, critical]
ch04 -> ch05: [建模流程中特征工程是核心环节, sequence, critical]
ch05 -> ch06: [特征工程做好后关注拟合质量, sequence, critical]
ch06 -> ch07: [学完所有章节后综合复习作答, sequence, important]
ch06 -> ch08: [拟合问题后进入第一个算法:KNN, sequence, critical]
ch08 -> ch09: [KNN概览后进入KNN实战深化, sequence, critical]

# core — 贯穿全课的核心洞察
insight.data-is-ceiling: [数据和特征决定ML上限, 模型和算法只是逼近上限, critical]
insight.train-test-separation: [训练集和测试集必须分离, 如高考卷不同于模拟卷, critical]
insight.model-complexity-balance: [模型不能太简单也不能太复杂, 追求恰好拟合和泛化能力, critical]

# ~90%
