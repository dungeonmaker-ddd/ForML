# use-this-graph-to-build: 课后作业 Q2-Q5
# scope: ML-intro-homework
# status: pending

# ══════════════════════════════════════════
# Q2: 有监督学习和无监督学习的各自特点及区别
# ══════════════════════════════════════════

# ── 监督学习特点 ──
q2.supervised.trait-1: [数据同时包含特征X和标签Y, 有明确的正确答案, critical]
q2.supervised.trait-2: [学习映射函数f:X->Y, 目标是预测新样本的标签, critical]
q2.supervised.trait-3: [训练有反馈:预测值与真实标签对比-计算loss-调整参数, critical]
q2.supervised.trait-4: [两大子任务:回归输出连续值如房价-分类输出离散值如猫狗, critical]

# ── 无监督学习特点 ──
q2.unsupervised.trait-1: [数据只有特征X-没有标签Y, 没有标准正确答案, critical]
q2.unsupervised.trait-2: [学习数据内部结构和分布规律, 发现样本间相似性和隐藏模式, critical]
q2.unsupervised.trait-3: [训练无反馈:无标签无法直接评判对错, critical]
q2.unsupervised.trait-4: [典型任务:聚类按相似性自动分组, 结果与超参数有关-无唯一标准, critical]

# ── 核心区别 ──
q2.contrast.data: [根本区别在数据形态, 监督:有标签有反馈, 无监督:无标签无反馈, critical]
q2.contrast.goal: [目标导向不同, 监督:预测已知类别的结果, 无监督:发现未知的内部结构, critical]
q2.contrast.evaluation: [评估难度不同, 监督:可用准确率-loss直接评估, 无监督:缺乏标准答案-评估困难, important]
q2.contrast.example: [监督:标注好的猫狗图片-学会区分, 无监督:未标注图片-按相似性自动分组, important]

# ── 跨章回顾 ──
q2.link-ch01: [回顾ch01:ML本质是从数据自动学习规律, 监督和无监督是两种不同的学习方式, important]
q2.link-ch03: [回顾ch03:四种学习方式中监督和无监督是最核心的两种, 半监督介于两者之间, important]

# ══════════════════════════════════════════
# Q3: 机器学习的建模流程
# ══════════════════════════════════════════

q3.overview: [五步流程:获取数据->数据基本处理->特征工程->模型训练->模型评估, 非一次性-评估不佳需回退迭代, critical]

q3.step1: [获取数据:搜集任务相关数据集, 类型:经验-图像-文本, 关键:数据需匹配实际需求-如中国房价模型不适用美国, critical]
q3.step2: [数据基本处理:缺失值删除或填写-异常值离群点检测, 为特征工程准备干净数据, critical]
q3.step3: [特征工程:五大子领域-提取-预处理-降维-选择-组合, 让模型更易学到规律, 最耗时环节, critical]
q3.step4: [模型训练:根据任务选算法, 线性回归-逻辑回归-决策树-SVM等, critical]
q3.step5: [模型评估:用测试集评估, 回归评测指标-分类评测指标, 效果好上线-效果不好回退迭代, critical]

q3.insight: [数据和特征决定ML上限-模型算法只是逼近, 数据处理和特征工程占大部分时间, critical]
q3.iterative: [建模是迭代过程:评估->发现不足->调整->重新训练->再评估, important]

# ── 跨章回顾 ──
q3.link-ch04: [回顾ch04:五步流程的详细展开, important]
q3.link-ch05: [回顾ch05:特征工程为何是最耗时环节-五大子领域, important]
q3.link-ch06: [回顾ch06:模型评估时可能遇到拟合问题-需要诊断和调整, important]

# ══════════════════════════════════════════
# Q4: 对特征工程的理解
# ══════════════════════════════════════════

q4.definition: [利用专业背景知识和技巧处理数据, 目的:让ML算法更易学到规律-效果更好, critical]
q4.importance: [数据和特征决定ML上限-模型算法只是逼近, 好的特征工程直接决定模型天花板, critical]

q4.sub-extraction: [特征提取:从原始数据提取任务相关特征-转成特征向量, critical]
q4.sub-preprocessing: [特征预处理:解决量纲问题-让不同特征对模型影响一致, 方法:归一化MinMaxScaler-标准化StandardScaler, critical]
q4.sub-decomposition: [特征降维:将高维数据降到低维-保留主要信息, 如PCA将多个特征融合为少量主成分, critical]
q4.sub-selection: [特征选择:根据专业知识挑选任务相关的特征子集, 不改变原数据-去除无关特征, critical]
q4.sub-crosses: [特征组合:用乘法或加法合并多个特征为新特征, 如BMI=体重/身高²-引入领域知识, critical]

q4.real-example: [鸢尾花:为何不用颜色作特征-专业人员判断区分力不够, 特征选择依赖领域知识-不是越多越好, important]

# ── 跨章回顾 ──
q4.link-ch01: [回顾ch01:房价预测中面积是特征-售价是标签, 特征的选取直接影响模型能否学到规律, important]
q4.link-ch04: [回顾ch04:特征工程在建模流程中处于第三步-是耗时耗精力最多的环节, important]
q4.link-ch06: [回顾ch06:特征工程做不好可能导致欠拟合-做过度可能引入噪声导致过拟合, important]

# ══════════════════════════════════════════
# Q5: 模型拟合问题及产生的原因
# ══════════════════════════════════════════

q5.fitting: [拟合:用在机器学习领域-用来表示模型对样本点的拟合情况, critical]

q5.underfitting.what: [欠拟合:训练集差-测试集也差, 模型连训练数据规律都没学到, critical]
q5.underfitting.why: [原因:模型过于简单-参数太少-表达能力不足, 如y=kx+b拟合非线性分布, critical]
q5.underfitting.fix: [对策:增加模型复杂度-增加有效特征-换更强模型, critical]

q5.overfitting.what: [过拟合:训练集好-测试集差, 模型记住了噪声和个例-非真正规律-钻牛角尖, critical]
q5.overfitting.why: [原因:模型太复杂-数据不纯-训练数据太少, 脏特征和噪声被当成规律, critical]
q5.overfitting.fix: [对策:正则化-异常值检测-特征降维-数据增强-优化长尾数据, critical]

q5.generalization: [终极目标:泛化能力, 新数据上也表现良好, 不欠不过-恰好平衡, critical]
q5.occam: [奥卡姆剃刀:同等泛化效果选更简单模型, important]
q5.loss-diagnosis: [loss曲线诊断:欠拟合-双高且慢降, 过拟合-train低test后期反升有gap, 正好-双低且收敛, critical]

# ── 跨章回顾 ──
q5.link-ch01: [回顾ch01:y=wx+b是最简单的线性模型-参数少-可能欠拟合复杂数据, important]
q5.link-ch04: [回顾ch04:模型评估是建模第五步-发现拟合问题后回退调整, important]
q5.link-ch05: [回顾ch05:特征工程直接影响拟合质量-量纲问题不处理可能导致欠拟合-特征过多可能导致过拟合, important]

# ~96%
