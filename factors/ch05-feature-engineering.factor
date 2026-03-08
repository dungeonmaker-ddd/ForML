# use-this-graph-to-build: ch05 特征工程概念入门
# scope: ML-intro-chapter-05
# status: pending

# core — 特征工程定义与核心地位
feature-engineering: [利用专业背景知识和技巧处理数据, 让ML算法更容易学习规律-效果更好, critical]
feature-engineering.principle: [数据和特征决定ML的上限, 模型和算法只是逼近这个上限, critical]

# core — 五大子领域
feature-extraction: [特征提取-feature-extraction, 从原始数据中提取与任务相关的特征, 转成特征向量, critical]
feature-preprocessing: [特征预处理-feature-preprocessing, 解决不同特征对模型影响一致性问题, critical]
feature-preprocessing.problem: [量纲问题, 量级大的特征对模型影响大-量级小的影响小, 模型倾向于优先学习量纲大的特征, 忽略量纲小的特征与标签相关性, critical]
feature-preprocessing.normalization: [归一化-MinMaxScaler, 适用:图像-像素-已知范围传感器数据-0到255, important]
feature-preprocessing.standardization: [标准化-StandardScaler, 适用:大多数ML任务-表格数据, 数据有明显异常值时也用标准化, important]
feature-preprocessing.choice: [不确定用哪个时:先试标准化-再对比归一化效果-交叉验证, important]

feature-decomposition: [特征降维-feature-decomposition, 将原始数据维度降低, 保证主要信息保留, 数据量减少, critical]
feature-decomposition.pca: [PCA主成分分析, 纯数学优化-无语义目标, 新特征融合多个特征信息-但可能没有明确定义, 仅限线性组合, important]
feature-decomposition.pca.example: [身高和体重两特征, PC1=0.7x标准化身高+0.7x标准化体重, 新特征-体型大小-无单位, 将2维压缩为1维, important]

feature-selection: [特征选择-feature-selection, 根据专业知识挑选重要特征, 原始数据特征很多-相关的只是子集, 不会改变原数据, critical]

feature-crosses: [特征组合-feature-crosses, 把多个特征合并成单个特征, 利用乘法或加法完成, critical]
feature-crosses.example: [BMI=体重kg除以身高m的平方, 新特征-肥胖程度-有医学定义, 高可解释性, important]
feature-crosses.vs-pca: [特征组合:引入领域知识-构造有明确语义新特征-高可解释性-任意函数形式, PCA降维:去除冗余-压缩维度-无语义目标-通常不可解释-仅限线性组合, important]

# core — 鸢尾花案例洞察
feature-engineering.iris-insight: [鸢尾花分类为何不用颜色作特征, 需要专业人员根据领域知识选择有区分力的特征, important]

# edges
feature-engineering -> feature-extraction: [提取是特征工程第一步, critical]
feature-engineering -> feature-preprocessing: [预处理消除量纲差异, critical]
feature-engineering -> feature-decomposition: [降维压缩信息保留主成分, critical]
feature-engineering -> feature-selection: [选择任务相关特征子集, critical]
feature-engineering -> feature-crosses: [组合构造新特征, critical]
feature-preprocessing.problem -> feature-preprocessing.normalization: [归一化解决量纲问题方法之一, important]
feature-preprocessing.problem -> feature-preprocessing.standardization: [标准化解决量纲问题方法之二, important]

# ============================================================
# homework.Q4 — 对特征工程的理解
# ============================================================

# 答题线索：定义 + 核心地位 + 五大子领域 + 为什么重要

homework.fe.definition: [特征工程是利用专业背景知识和技巧处理数据的过程, 目的:让ML算法更容易学习到数据中的规律-使模型效果更好, critical]
homework.fe.importance: [数据和特征决定了ML的上限-模型和算法只是逼近这个上限, 好的特征工程直接决定模型天花板, critical]

homework.fe.sub-1-extraction: [特征提取:从原始数据中提取与任务相关的特征并转成特征向量, 原始数据可能是图片-文本等非结构化数据-需要转化为模型能处理的数值向量, critical]
homework.fe.sub-2-preprocessing: [特征预处理:解决量纲问题-让不同特征对模型的影响一致, 量级大的特征会主导模型学习-忽略量级小但同样重要的特征, 方法:归一化MinMaxScaler-标准化StandardScaler, critical]
homework.fe.sub-3-decomposition: [特征降维:将高维数据压缩到低维-保留主要信息, 如PCA将多个特征融合为少量主成分, 减少计算量-消除冗余, critical]
homework.fe.sub-4-selection: [特征选择:从众多特征中根据专业知识挑选与任务真正相关的子集, 不改变原数据-只是选取, 去除无关特征减少噪声, critical]
homework.fe.sub-5-crosses: [特征组合:用乘法或加法将多个特征合并为一个新特征, 如BMI=体重/身高平方, 引入领域知识-构造有明确语义的新特征, critical]

homework.fe.real-example: [鸢尾花分类:为何不用颜色作特征-因为专业人员判断颜色对分类区分力不够, 特征选择依赖领域专业知识-不是特征越多越好, important]

# ~96%
