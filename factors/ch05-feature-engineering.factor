# use-this-graph-to-build: ch05 特征工程概念入门
# scope: ML-intro-chapter-05
# status: pending

# ── core: 定义与核心地位 ──
feature-engineering: [利用专业背景知识和技巧处理数据, 让ML算法更容易学习规律-效果更好, critical]
feature-engineering.principle: [数据和特征决定ML的上限, 模型和算法只是逼近这个上限, critical]
feature-engineering.iris-insight: [鸢尾花案例:为何不用颜色作特征, 专业人员判断颜色对分类区分力不够, 特征选择依赖领域知识-不是越多越好, important]

# ── core: 五大子领域 ──
feature-extraction: [特征提取-feature-extraction, 从原始数据中提取与任务相关的特征, 转成特征向量, critical]

feature-preprocessing: [特征预处理-feature-preprocessing, 解决不同特征对模型影响一致性问题, critical]
feature-preprocessing.problem: [量纲问题:量级大的特征对模型影响大-量级小的影响小, 模型倾向优先学习量纲大的特征-忽略量纲小的特征与标签相关性, critical]
feature-preprocessing.normalization: [归一化-MinMaxScaler, 将数据缩放到固定范围如0-1, 适用:图像像素-已知范围传感器数据-0到255, important]
feature-preprocessing.standardization: [标准化-StandardScaler, 将数据转换为均值0标准差1, 适用:大多数ML任务-表格数据-数据有明显异常值, important]
feature-preprocessing.choice: [选择策略:不确定时先试标准化-再对比归一化效果-用交叉验证评估, important]

feature-decomposition: [特征降维-Feature-decomposition, 将原始数据的维度降低, 保证主要信息保留-数据量减少, critical]
feature-decomposition.pca: [PCA主成分分析, 纯数学优化-无语义目标, 新特征融合多个原始特征信息-但可能没有明确定义, 仅限线性组合-通常不可解释, important]
feature-decomposition.pca.example: [身高+体重两特征, PC1=0.7x标准化身高+0.7x标准化体重, 新特征:体型大小-无单位, 效果:2维压缩为1维, important]

feature-selection: [特征选择-feature-selection, 根据专业知识挑选重要特征, 原始特征很多-任务相关的只是子集, 不改变原数据-只做选取-减少噪声, critical]

feature-crosses: [特征组合-feature-crosses, 把多个特征用乘法或加法合并成一个新特征, 引入领域知识-构造有明确语义的新特征, critical]
feature-crosses.example: [BMI=体重kg/身高m², 新特征:肥胖程度, 有医学定义-高可解释性, important]
feature-crosses.vs-pca: [对比:特征组合vs PCA降维, 组合:引入领域知识-有语义-高可解释-任意函数形式, PCA:纯数学优化-无语义-通常不可解释-仅限线性, important]

# ── edges: 子领域间关系 ──
feature-engineering -> feature-extraction: [提取是特征工程第一步-获取原始特征, critical]
feature-engineering -> feature-preprocessing: [预处理消除量纲差异-统一特征尺度, critical]
feature-engineering -> feature-decomposition: [降维压缩信息-保留主成分, critical]
feature-engineering -> feature-selection: [选择任务相关的特征子集, critical]
feature-engineering -> feature-crosses: [组合构造新特征-增强表达力, critical]

feature-preprocessing.problem -> feature-preprocessing.normalization: [归一化是解决量纲问题的方法之一, important]
feature-preprocessing.problem -> feature-preprocessing.standardization: [标准化是解决量纲问题的方法之二, important]
# 注: 五大子领域是并列概念, 课程未建立执行先后顺序

# ── homework.Q4: 对特征工程的理解 ──

homework.fe.definition: [利用专业背景知识和技巧处理数据, 目的:让ML算法更易学到规律-效果更好, critical]
homework.fe.importance: [数据和特征决定ML上限-模型算法只是逼近, 好的特征工程直接决定模型天花板, critical]
homework.fe.sub-1-extraction: [特征提取:从原始数据提取任务相关特征-转成数值向量, 原始数据可能是图片文本等非结构化数据, critical]
homework.fe.sub-2-preprocessing: [特征预处理:解决量纲问题-让不同特征对模型影响一致, 方法:归一化MinMaxScaler-标准化StandardScaler, critical]
homework.fe.sub-3-reduction: [特征降维:高维压缩到低维-保留主要信息, 如PCA将多个特征融合为少量主成分, critical]
homework.fe.sub-4-selection: [特征选择:根据专业知识挑选任务相关的特征子集, 不改变原数据-去除无关特征减少噪声, critical]
homework.fe.sub-5-crosses: [特征组合:用乘法或加法合并多个特征为新特征, 如BMI=体重/身高²-引入领域知识, critical]
homework.fe.real-example: [鸢尾花:为何不用颜色作特征-专业人员判断区分力不够, 特征选择依赖领域知识-不是越多越好, important]

# ~97%
