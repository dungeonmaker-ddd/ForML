# use-this-graph-to-build: ch06 模型拟合问题
# scope: ML-intro-chapter-06
# status: pending

# core — 拟合的定义
fitting: [拟合, 用来表示模型对样本分布点的模拟情况, critical]

# core — 欠拟合
underfitting: [欠拟合, 训练集表现很差-测试集表现也很差, 模型学习到的特征过少-无法准确预测, critical]
underfitting.cause: [原因:模型过于简单, 参数少-难以拟合规律, 如y=kx+b拟合非线性数据, critical]
underfitting.solution: [对策:增加模型复杂度, 增加特征, 使用更强的模型, critical]
underfitting.loss-curve: [loss很大-下降很慢, 学不到特征, train-loss和test-loss都高, important]

# core — 过拟合
overfitting: [过拟合, 训练集表现很好-测试集表现很差, 模型学到特征过多-包含脏特征-钻牛角尖, critical]
overfitting.cause: [原因:模型太复杂-数据不纯-训练数据太少, 高次方模型参数多-在训练集上表现异常好, critical]
overfitting.solution: [对策:正则化-异常值检测-特征降维-数据增强-优化长尾数据, 降低模型复杂度, critical]
overfitting.long-tail: [长尾数据优化方法:欠采样-过采样-focal-loss, important]
overfitting.loss-curve: [后期验证集loss反而上升, 泛化性下降, 需要早停-early-stopping, train-loss远低于test-loss, important]

# core — 正好拟合
just-right: [正好拟合, train-loss和test-loss相近且都低, 如y=ax2+bx+c正好拟合二次分布, critical]
just-right.loss-curve: [train和test的loss曲线相似且收敛, 表明泛化良好, important]

# core — 泛化与奥卡姆剃刀
generalization: [泛化-Generalization, 模型在新数据集-非训练数据-上表现好坏的能力, 具体的个别的扩大为一般的能力, critical]
occam-razor: [奥卡姆剃刀原则, 给定两个相同泛化误差的模型-倾向选择较简单的模型, critical]

# core — Loss的含义
loss: [损失函数-loss, 衡量模型预测值与真实值之间差异的度量, loss越小模型越好, 横轴step-纵轴loss, critical]

# core — 拟合程度与模型复杂度的关系
model-complexity.low: [y=kx+b, 参数少, 难以拟合规律, 训练集表现极差, feeds-underfitting, important]
model-complexity.moderate: [y=ax2+bx+c, 复杂度适中, 正好拟合分布, feeds-just-right, important]
model-complexity.high: [高次多项式, 参数过多, 训练集表现异常好-测试集差, feeds-overfitting, important]

# edges
underfitting.cause -> underfitting.solution: [识别原因后针对性解决, critical]
overfitting.cause -> overfitting.solution: [识别原因后针对性解决, critical]
fitting -> underfitting: [拟合不足的情况, critical]
fitting -> overfitting: [拟合过度的情况, critical]
fitting -> just-right: [拟合恰好的情况, critical]
generalization -> occam-razor: [奥卡姆剃刀指导模型选择-追求泛化, critical]
overfitting -> generalization: [过拟合导致泛化差, critical]
underfitting -> generalization: [欠拟合也意味着泛化差, critical]

# ============================================================
# homework.Q5 — 模型拟合问题及产生的原因
# ============================================================

# 答题线索：拟合定义 -> 两种问题 -> 各自原因 -> 对策 -> 泛化

homework.fitting.definition: [拟合是模型对样本分布点的模拟情况, 模型训练的本质就是让模型曲线尽可能贴合数据点的分布规律, critical]

homework.underfitting.what: [欠拟合:模型在训练集上表现很差-在测试集上表现也很差, 说明模型连训练数据的规律都没学到, critical]
homework.underfitting.why: [产生原因:模型过于简单-参数太少-表达能力不足, 例如用y=kx+b去拟合明显的非线性分布-线性模型无法捕捉曲线规律, critical]
homework.underfitting.how-to-fix: [对策:增加模型复杂度-增加更多有效特征-换用更强表达能力的模型, 本质是提升模型的学习能力, critical]

homework.overfitting.what: [过拟合:模型在训练集上表现很好-但在测试集上表现很差, 说明模型记住了训练数据的噪声和个例-而非真正的规律, critical]
homework.overfitting.why: [产生原因:模型太复杂-参数过多-数据不纯含噪声-训练数据量太少, 模型把脏特征和噪声也当成规律去学-钻牛角尖, critical]
homework.overfitting.how-to-fix: [对策:正则化约束参数-异常值检测清洗数据-特征降维减少冗余-数据增强扩大样本量-优化长尾数据分布, 本质是降低模型复杂度或提升数据质量, critical]

homework.fitting.generalization: [最终目标是泛化能力:模型在未见过的新数据上也能表现良好, 既不欠拟合也不过拟合-找到恰好的平衡点, critical]
homework.fitting.occam: [奥卡姆剃刀:同等泛化效果下优先选择更简单的模型, 简单模型更不容易过拟合-泛化能力往往更强, important]

homework.fitting.loss-diagnosis: [通过loss曲线诊断拟合问题:欠拟合-train和test的loss都高且下降慢, 过拟合-train的loss很低但test的loss在后期反升-出现明显gap, 正好拟合-train和test的loss相近且都收敛到低值, critical]

# ~97%
