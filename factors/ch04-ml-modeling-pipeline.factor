# use-this-graph-to-build: ch04 机器学习建模流程
# scope: ML-intro-chapter-04
# status: pending

# core — 五步建模流程（顺序执行）
step1-data-acquisition: [获取数据, 搜集与任务相关的数据集, 类型:经验数据-图像数据-文本数据, 需要和实际需求匹配, 如中国房价模型不适用于美国房价, critical]
step2-data-processing: [数据基本处理, 缺失值处理:删除或填写, 异常值处理:离群点检测, critical]
step3-feature-engineering: [特征工程, 特征提取-特征预处理-特征降维-特征组合, 耗时耗精力最多的步骤, critical]
step4-model-training: [机器学习-模型训练, 选择合适算法, 有监督-无监督-半监督-强化学习, 算法举例:线性回归-逻辑回归-决策树-支持向量机, critical]
step5-model-evaluation: [模型评估, 回归评测指标-分类评测指标, 效果好则上线服务, 效果不好则重复上述步骤, critical]

# core — 流程顺序边
step1-data-acquisition -> step2-data-processing: [获取后清洗, sequence, critical]
step2-data-processing -> step3-feature-engineering: [清洗后做特征工程, sequence, critical]
step3-feature-engineering -> step4-model-training: [特征就绪后训练, sequence, critical]
step4-model-training -> step5-model-evaluation: [训练后评估, sequence, critical]
step5-model-evaluation -> step2-data-processing: [评估不佳则回退迭代, feedback-loop, important]

# core — 关键洞察
pipeline.insight: [数据基本处理和特征工程是耗时耗精力最多的环节, 数据和特征决定ML上限-模型和算法只是逼近这个上限, critical]

# ============================================================
# homework.Q3 — 机器学习的建模流程
# ============================================================

# 答题线索：五步流程 + 每步做什么 + 迭代性质 + 关键洞察

homework.pipeline.overview: [建模流程共五步:获取数据->数据基本处理->特征工程->模型训练->模型评估, 不是一次性流程-评估不佳需回退迭代, critical]

homework.step1: [获取数据:搜集与任务相关的数据集, 数据类型:经验数据-图像数据-文本数据等, 关键:数据需要和实际需求匹配-如中国房价模型不适用于美国房价, critical]
homework.step2: [数据基本处理:清洗数据中的噪声, 缺失值处理-删除或填写, 异常值处理-离群点检测, 为后续特征工程准备干净数据, critical]
homework.step3: [特征工程:对数据特征进行提取-预处理-降维-选择-组合, 目的:让模型更容易学到规律, 是整个流程中耗时耗精力最多的环节, critical]
homework.step4: [模型训练:根据任务类型选择合适算法, 监督学习-无监督学习-半监督-强化学习, 具体算法如线性回归-逻辑回归-决策树-SVM等, critical]
homework.step5: [模型评估:用测试集评估模型效果, 回归用回归评测指标-分类用分类评测指标, 效果好则上线服务-效果不好则回退重新迭代, critical]

homework.pipeline.key-insight: [数据和特征决定了ML的上限-模型和算法只是逼近这个上限, 数据基本处理和特征工程占据建模大部分时间精力, critical]
homework.pipeline.iterative: [建模是迭代过程:评估->发现不足->调整数据处理或特征工程或算法->重新训练->再评估, important]

# ~93%
