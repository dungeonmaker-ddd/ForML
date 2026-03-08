# use-this-graph-to-build: ch04 机器学习建模流程
# scope: ML-intro-chapter-04
# status: pending

# ── core: 五步建模流程 ──
step1-data-acquisition: [获取数据, 搜集与任务相关的数据集, 类型:经验数据-图像数据-文本数据, 关键:需要和实际需求匹配, 如中国房价模型不适用于美国, critical]
step2-data-processing: [数据基本处理, 缺失值处理:删除或填写, 异常值处理:离群点检测, 为后续特征工程准备干净数据, critical]
step3-feature-engineering: [特征工程, 五大子领域:特征提取-特征预处理-特征降维-特征选择-特征组合, 耗时耗精力最多的步骤, critical]
step4-model-training: [模型训练, 根据任务选择合适算法, 学习方式:有监督-无监督-半监督-强化学习, 算法举例:线性回归-逻辑回归-决策树-支持向量机, critical]
step5-model-evaluation: [模型评估, 回归评测指标-分类评测指标, 效果好:上线服务, 效果不好:回退迭代重复上述步骤, critical]

# ── core: 流程顺序边 ──
step1-data-acquisition -> step2-data-processing: [获取后清洗, sequence, critical]
step2-data-processing -> step3-feature-engineering: [清洗后做特征工程, sequence, critical]
step3-feature-engineering -> step4-model-training: [特征就绪后训练, sequence, critical]
step4-model-training -> step5-model-evaluation: [训练后评估, sequence, critical]
step5-model-evaluation -> step2-data-processing: [评估不佳则回退迭代, feedback-loop, important]

# ── core: 关键洞察 ──
pipeline.insight.time-cost: [数据基本处理和特征工程是耗时耗精力最多的环节, critical]
pipeline.insight.ceiling: [数据和特征决定ML上限, 模型和算法只是逼近这个上限, critical]
pipeline.insight.iterative: [建模是迭代过程, 评估->发现不足->调整->重新训练->再评估, important]

step3-feature-engineering -> pipeline.insight.time-cost: [特征工程是最耗时环节, 实践经验, critical]

# ── homework.Q3: 建模流程 ──

homework.pipeline.overview: [五步流程:获取数据->数据处理->特征工程->模型训练->模型评估, 非一次性流程-评估不佳需回退迭代, critical]
homework.step1: [获取数据:搜集任务相关数据集, 类型:经验-图像-文本, 关键:数据需匹配实际需求, critical]
homework.step2: [数据处理:缺失值删除或填写-异常值离群点检测, 为特征工程准备干净数据, critical]
homework.step3: [特征工程:提取-预处理-降维-选择-组合, 让模型更易学到规律, 最耗时环节, critical]
homework.step4: [模型训练:根据任务选算法, 线性回归-逻辑回归-决策树-SVM等, critical]
homework.step5: [模型评估:用测试集评估, 效果好上线-效果不好回退迭代, critical]
homework.pipeline.key-insight: [数据和特征决定ML上限-模型算法只是逼近, 数据处理和特征工程占大部分时间, critical]

# ~95%
