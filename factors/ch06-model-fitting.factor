# use-this-graph-to-build: ch06 模型拟合问题
# scope: ML-intro-chapter-06
# status: pending

# ── core: 拟合的定义 ──
fitting: [拟合-fitting, 用在机器学习领域, 用来表示模型对样本点的拟合情况, critical]

# ── core: 欠拟合 ──
underfitting: [欠拟合-underfitting, 训练集表现很差-测试集表现也很差, 模型学到的特征过少-无法准确预测未知样本, critical]
underfitting.cause: [原因:模型过于简单, 参数少-表达能力不足, 如y=kx+b拟合非线性数据, critical]
underfitting.solution: [对策:增加模型复杂度-增加有效特征-换用更强模型, 本质:提升模型学习能力, critical]
underfitting.loss-curve: [loss曲线特征:loss很大且下降很慢, train-loss和test-loss都高, 学不到特征, important]

# ── core: 过拟合 ──
overfitting: [过拟合-overfitting, 训练集表现很好-测试集表现很差, 模型学到特征过多-包含脏特征-钻牛角尖, critical]
overfitting.cause: [原因:模型太复杂-数据不纯含噪声-训练数据太少, 高次方模型参数多-在训练集表现异常好, critical]
overfitting.solution: [对策:正则化约束参数-异常值检测-特征降维-数据增强-优化长尾数据, 本质:降低模型复杂度或提升数据质量, critical]
overfitting.long-tail: [长尾数据优化:欠采样-过采样-focal-loss, important]
overfitting.loss-curve: [loss曲线特征:后期验证集loss反而上升, train-loss远低于test-loss-出现明显gap, 需要早停-early-stopping, important]

# ── core: 正好拟合 ──
just-right: [正好拟合-just-right, train-loss和test-loss相近且都低, 如y=ax²+bx+c正好拟合二次分布, critical]
just-right.loss-curve: [loss曲线特征:train和test曲线相似且收敛到低值, 表明泛化良好, important]

# ── core: Loss 的含义 ──
loss: [损失函数-loss, 衡量模型预测值与真实值之间的差异, loss越小模型越好, 图表:横轴step-纵轴loss, critical]

# ── core: 模型复杂度与拟合的关系 ──
model-complexity.low: [低复杂度:y=kx+b, 参数少, 难以拟合规律, 训练集表现极差, important]
model-complexity.moderate: [中复杂度:y=ax²+bx+c, 复杂度适中, 正好拟合分布, important]
model-complexity.high: [高复杂度:高次多项式, 参数过多, 训练集异常好-测试集差, important]

# ── core: 泛化与奥卡姆剃刀 ──
generalization: [泛化-Generalization, 模型在新数据集(非训练数据)上表现好坏的能力, 具体的个别的扩大为一般的能力, critical]
occam-razor: [奥卡姆剃刀原则, 给定两个相同泛化误差的模型-倾向选择较简单的模型, 简单模型更不易过拟合, critical]

# ── edges: 拟合类型 ──
fitting -> underfitting: [拟合不足, critical]
fitting -> overfitting: [拟合过度, critical]
fitting -> just-right: [拟合恰好, critical]

# ── edges: 原因→对策 ──
underfitting.cause -> underfitting.solution: [识别原因后针对性解决, critical]
overfitting.cause -> overfitting.solution: [识别原因后针对性解决, critical]

# ── edges: 复杂度→拟合类型 ──
model-complexity.low -> underfitting: [低复杂度导致欠拟合, 因果, critical]
model-complexity.moderate -> just-right: [适中复杂度实现正好拟合, 因果, critical]
model-complexity.high -> overfitting: [高复杂度导致过拟合, 因果, critical]

# ── edges: loss 与 loss 曲线 ──
loss -> underfitting.loss-curve: [loss曲线诊断欠拟合, important]
loss -> overfitting.loss-curve: [loss曲线诊断过拟合, important]
loss -> just-right.loss-curve: [loss曲线确认正好拟合, important]

# ── edges: 拟合→泛化 ──
underfitting -> generalization: [欠拟合导致泛化差, critical]
overfitting -> generalization: [过拟合导致泛化差, critical]
just-right -> generalization: [正好拟合实现良好泛化, critical]
generalization -> occam-razor: [奥卡姆剃刀指导模型选择-追求泛化, critical]

# ── homework.Q5: 拟合问题及原因 ──

homework.fitting.definition: [拟合是模型对样本分布点的模拟情况, 训练本质是让曲线贴合数据分布规律, critical]
homework.underfitting.what: [欠拟合:训练集差-测试集也差, 模型连训练数据规律都没学到, critical]
homework.underfitting.why: [原因:模型过于简单-参数太少-表达能力不足, 如y=kx+b拟合非线性分布, critical]
homework.underfitting.how-to-fix: [对策:增加模型复杂度-增加有效特征-换更强模型, 本质:提升学习能力, critical]
homework.overfitting.what: [过拟合:训练集好-测试集差, 模型记住了噪声和个例-非真正规律, critical]
homework.overfitting.why: [原因:模型太复杂-数据不纯-训练数据太少, 脏特征和噪声被当成规律, critical]
homework.overfitting.how-to-fix: [对策:正则化-异常值检测-特征降维-数据增强-优化长尾数据, 本质:降低复杂度或提升数据质量, critical]
homework.fitting.generalization: [终极目标:泛化能力, 新数据上也表现良好, 不欠不过-恰好平衡, critical]
homework.fitting.occam: [奥卡姆剃刀:同等泛化效果选更简单模型, 简单模型泛化能力往往更强, important]
homework.fitting.loss-diagnosis: [loss曲线诊断:欠拟合-双高且慢降, 过拟合-train低test后期反升有gap, 正好-双低且收敛, critical]

# ~98%
