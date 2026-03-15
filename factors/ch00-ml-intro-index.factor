# use-this-graph-to-build: Day01 ML入门基础 — 从零到第一个算法
# confirm-sufficiency-before-start: 本图谱聚合ch01-ch08，每页锚定数学公式或代码API，15内容页布局
# scope: ML-intro-day01-aggregated
# status: built

# ═══ Page 1: ML本质 — y=wx+b 是一切的起点（ch01） ═══

ML本质: [Machine-Learning-机器学习, 核心:从数据中自动学习规律->产生模型->用模型预测, 与传统编程本质区别:传统输入规则+数据->输出结果-ML输入数据+结果->输出规则, 面试追问:ML和传统编程有什么区别, critical]
ML本质.三层嵌套: [AI⊃ML⊃DL严格包含, AI:最大范畴-含专家系统|模糊逻辑|进化计算, ML:AI子集-数据驱动学习, DL:ML子集-多层神经网络, 面试必答:三者是包含不是并列, critical]
ML本质.线性模型: [y=wx+b-最简模型-理解ML的起点, w:斜率-衡量特征对标签的影响力, b:截距-表示基础偏移, w和b是模型参数:从数据中学来-算法自动调整, 对比超参数:人为设定-如KNN的K值, critical]
ML本质.训练过程: [step1:数据点画入坐标系(x=面积,y=售价), step2:选模型y=wx+b, step3:算法迭代调整w和b使Σ(y_true-y_pred)²最小, step4:模型固定->输入新x->输出预测ŷ, 公式:ŷ=wx+b, critical]
ML本质.局限预告: [y=wx+b只能拟合线性关系, y=ax²+bx+c能拟合二次曲线, 更复杂:神经网络能拟合任意函数, 模型复杂度选择->feeds-拟合问题, important]

# ═══ Page 2: 数据结构 — X矩阵·y向量·划分铁律（ch02） ═══

数据矩阵: [数据集=二维表格=矩阵, X∈R^(m×n):m个样本×n个特征, y∈R^m:m个标签值, 一行=一个样本(sample/instance), 一列=一个特征(feature/attribute), 末列=标签(label/target), critical]
数据矩阵.术语映射: [sample=行=观测单元, feature=列=属性=维度(dimension), label=target=因变量=模型要预测的值, dataset=X+y的集合, n个特征=n维空间, critical]
数据矩阵.划分铁律: [数据集必须划分:训练集(80%)+测试集(20%), 铁律:先split->再train->最后evaluate, 违反后果:数据泄露(data-leakage)->评估虚高->上线崩塌, 类比:高考卷≠模拟卷, critical]
数据矩阵.划分API: [train_test_split(X,y,test_size=0.2,random_state=22), 返回:X_train-X_test-y_train-y_test四元组, test_size:测试集占比, random_state:随机种子-保证可复现, from-sklearn.model_selection-import-train_test_split, critical]

# ═══ Page 3: 监督学习 — f(X)→Y·loss·回归vs分类（ch03） ═══

监督学习: [supervised-learning, 数学定义:已知X(特征矩阵)和Y(标签向量)-学习映射f使f(X)≈Y, 训练过程:预测ŷ=f(X)->计算loss=L(y,ŷ)->调整f的参数->重复直到loss收敛, critical]
监督学习.loss概念: [loss=L(y_true,ŷ):衡量预测值与真实值的差距, 回归常用:MSE=1/m·Σ(yi-ŷi)², 分类常用:交叉熵=-Σ(yi·log(ŷi)), loss越小->模型越准->参数越优, critical]
监督学习.回归: [regression-回归:f(X)∈R-输出连续值, 案例:房价预测ŷ=358万, 评估:MSE|MAE|R², 判断方法:预测结果能做加减法->回归, critical]
监督学习.分类: [classification-分类:f(X)∈{0,1,...,K}-输出离散类别, 案例:猫狗分类ŷ∈{猫,狗}, 评估:准确率|精确率|召回率|F1, 二分类:0/1-多分类:0/1/.../K, critical]
监督学习.回归vs分类: [核心区别:输出连续vs离散, 面试追问:房价预测是回归还是分类->回归-输出连续数值, 垃圾邮件检测->分类-输出0或1, critical]

# ═══ Page 4: 无监督·半监督·强化 + 四种学习方式对比（ch03+Q2） ═══

无监督学习: [unsupervised-learning, 数学定义:只有X无Y-学习X的内部结构P(X), 聚类:将m个样本分成K组-组内相似度高|组间相似度低, 典型算法:K-Means(最小化组内距离之和)|DBSCAN, critical]
半监督学习: [semi-supervised-learning, 少量标签数据(X_l,Y_l)+大量无标签数据(X_u), 利用X_u的分布信息辅助学习f, 价值:标注成本高时(医学影像|语音标注)-用少量标签撬动大量数据, important]
强化学习: [reinforcement-learning, 四要素:Agent-Environment-Action-Reward, 目标:max-Σ(γ^t·R_t)-γ折扣因子-R_t即时奖励, 通过试错找最优策略π(s)->a, 案例:AlphaGo|机器人控制, important]
四种对比: [监督:有X有Y->学f(X)≈Y->预测, 无监督:有X无Y->学P(X)->发现结构, 半监督:少量Y+大量X->降低标注成本, 强化:状态+奖励->最优策略, 选择依据:数据形态决定学习方式, critical]
四种对比.面试要点: [Q2答题:一句话->有无标签是根本区别, 展开:数据形态|训练反馈|目标导向|评估方式四个维度对比, 加分:无监督评估困难-需轮廓系数等间接指标, critical]

# ═══ Page 5: 五步Pipeline — sklearn建模模板（ch04+Q3） ═══

建模Pipeline: [ML五步通用模板:1-获取数据->2-数据处理->3-特征工程->4-模型训练->5-模型评估, 非线性流水线-是带反馈的迭代循环:评估差->回退步骤2或3, critical]
建模Pipeline.代码模板: [sklearn标准流程:load_data()->train_test_split()->StandardScaler().fit_transform()->model.fit()->model.score(), 这5行代码对应5步流程-从鸢尾花到MNIST通用, critical]
建模Pipeline.时间分布: [数据处理+特征工程占60%-80%时间, 模型训练+评估占20%-40%, 核心洞察:数据和特征决定ML上限-模型算法只是逼近, 新手误区:花大量时间调参-忽视数据质量, critical]
建模Pipeline.迭代回退: [过拟合->回步骤3:特征降维|正则化, 欠拟合->回步骤3:增加特征|步骤4:换更强模型, 数据泄露->回步骤2:检查划分方式, 面试追问:模型效果不好怎么办->按诊断结果回退, important]

# ═══ Page 6: 特征工程 — 五大子领域 + BMI示例（ch05+Q4） ═══

特征工程: [feature-engineering, 利用专业知识处理数据让模型更易学到规律, 五大子领域:提取-预处理-降维-选择-组合, 鸢尾花启示:颜色对分类区分力不够->不选-特征不是越多越好, critical]
特征工程.提取: [feature-extraction, 非结构化数据->数值矩阵, 图像:像素矩阵flatten为向量(28×28->784维), 文本:词频/TF-IDF向量化, 本质:让模型能"看懂"原始数据, critical]
特征工程.选择: [feature-selection, 从n个特征中选k个(k<n)最相关子集, 过滤法:方差阈值|卡方检验|互信息, 包裹法:递归特征消除RFE, 嵌入法:L1正则化自动置零, 目的:减噪-降计算量-防过拟合, critical]
特征工程.组合: [feature-crosses, 用数学运算创造新特征, BMI=weight(kg)/height(m)²:有医学定义-高可解释性, 面积=长×宽:领域知识驱动, 对比PCA:PCA降维压缩-组合创造新维度-方向相反, critical]

# ═══ Page 7: 归一化 — MinMaxScaler公式与API（ch05） ═══

归一化: [MinMaxScaler-归一化, 公式:x'=(x-x_min)/(x_max-x_min), 将特征映射到[0,1]区间, 几何意义:把所有特征压缩到同一尺度的单位超立方体内, critical]
归一化.API: [from-sklearn.preprocessing-import-MinMaxScaler, scaler=MinMaxScaler(feature_range=(0,1)), X_scaled=scaler.fit_transform(X_train), X_test_scaled=scaler.transform(X_test), 属性:data_min_-data_max_-data_range_, critical]
归一化.致命缺陷: [max/min若为异常值->全部数据被过度压缩, 例:正常数据[10,20,30]-异常值[10,20,30,1000]->归一化后正常数据全挤在[0,0.03]区间-区分度丧失, 鲁棒性差-仅适合:已知范围|无异常值|图像像素0-255, critical]
归一化.计算示例: [数据[10,20,30,40,50], min=10-max=50, x'(30)=(30-10)/(50-10)=0.5, x'(10)=0-x'(50)=1, 所有值映射到[0,1], important]

# ═══ Page 8: 标准化 — StandardScaler·正态分布·归一vs标准（ch05） ═══

标准化: [StandardScaler-标准化, 公式:x'=(x-μ)/σ, μ=均值-σ=标准差, 转换后:均值=0-标准差=1-即标准正态分布N(0,1), critical]
标准化.API: [from-sklearn.preprocessing-import-StandardScaler, scaler=StandardScaler(), X_scaled=scaler.fit_transform(X_train), X_test_scaled=scaler.transform(X_test), 属性:mean_均值-var_方差-scale_标准差, critical]
标准化.正态分布: [N(μ,σ²):μ决定中心位置-σ决定分散幅度, 标准化后N(0,1):1σ覆盖68%-2σ覆盖95%-3σ覆盖99.7%, 方差σ²衡量数据离散程度, critical]
标准化.优势: [少量异常值对μ和σ影响小->鲁棒性强, 适合:现代嘈杂大数据|有异常值场景, 实践结论:不确定时优先选标准化, critical]
归一vs标准: [归一化:受极值max/min支配-鲁棒差-适合小数据已知范围, 标准化:受μ和σ驱动-鲁棒强-适合大数据有噪声, 面试必答:本质区别->归一化用极值-标准化用统计量-鲁棒性不同, critical]

# ═══ Page 9: PCA降维 — 线性组合·方差最大化（ch05） ═══

PCA: [Principal-Component-Analysis-主成分分析, 目标:将n维数据投影到k维(k<n)-保留最大方差方向, 方法:找方差最大的正交方向作为新坐标轴, 新特征=原始特征的线性组合, critical]
PCA.数学: [PC1=w11·x1+w12·x2+...+w1n·xn:第一主成分-方差最大方向, PC2⊥PC1:第二大方差方向-与PC1正交, 约束:||w||=1-各PC正交, 本质:旋转坐标系使方差集中在前几个轴, critical]
PCA.示例: [身高x1+体重x2两特征, PC1=0.7·x1'+0.7·x2'(标准化后), 含义:大致代表"体型大小"-无明确单位, 效果:2维->1维-保留主要方差信息-信息损失可控, important]
PCA.vs特征组合: [PCA:纯数学优化-无语义-不可解释-仅线性组合-自动化, 特征组合:领域知识驱动-有语义(BMI)-可解释-任意函数-人工设计, 面试追问:两者区别->方向相反:PCA压缩-组合创造, critical]
PCA.API: [from-sklearn.decomposition-import-PCA, pca=PCA(n_components=k), X_reduced=pca.fit_transform(X), 属性:explained_variance_ratio_各主成分方差解释比, 选k:累计方差解释比≥95%, important]

# ═══ Page 10: 拟合问题 — 多项式复杂度·欠拟合·过拟合（ch06） ═══

拟合与复杂度: [模型复杂度决定拟合状态, y=kx+b(2参数)->欠拟合:表达力不足, y=ax²+bx+c(3参数)->正好拟合:匹配数据规律, y=Σ(ai·x^i)(n参数)->过拟合:记住噪声, critical]
欠拟合: [underfitting, 现象:train-loss高+test-loss高, 原因:模型太简单-参数少-线性模型拟合非线性数据, 对策:增加复杂度(线性->多项式->神经网络)|增加有效特征|换更强模型, critical]
过拟合: [overfitting, 现象:train-loss低+test-loss高, 原因:模型太复杂|数据含噪声|训练数据太少, 本质:记住了训练集噪声-非真正规律, critical]
过拟合.对策: [正则化:L1(|w|)稀疏化-L2(w²)平滑化-约束参数大小, 早停:监控val-loss-上升时停止, 数据增强:增加样本量, 特征降维:减少维度, Dropout(神经网络):随机丢弃神经元, critical]
过拟合.正则化数学: [L1:Loss+λΣ|wi|->部分wi变0->特征选择, L2:Loss+λΣwi²->所有wi趋近0但不为0->平滑, λ:正则化强度-λ越大约束越强, 面试追问:L1和L2区别->L1产生稀疏解-L2产生平滑解, critical]

# ═══ Page 11: Loss曲线诊断 — 泛化·奥卡姆剃刀（ch06+Q5） ═══

loss曲线诊断: [横轴:训练轮次epoch, 纵轴:loss值, 两条线:train-loss(蓝)和val/test-loss(红), 通过两条线的走势诊断拟合状态, critical]
loss曲线.三种模式: [欠拟合:两线都高且下降慢-靠近但都在高位, 过拟合:train低+test后期反升-gap明显扩大, 正好拟合:两线相近且收敛到低值-几乎重合, critical]
loss曲线.早停策略: [early-stopping:记录val-loss最小值, 连续patience轮不下降->停止训练, 恢复到val-loss最小时的模型参数, sklearn:无内置-需手动或用Keras的EarlyStopping回调, important]

泛化: [Generalization-泛化, 模型在未见数据上的表现, 终极目标:学会规律-不是记住训练集, 欠拟合和过拟合都导致泛化差-只有正好拟合才泛化好, critical]
奥卡姆剃刀: [Occam's-Razor, 泛化误差相同->选更简单的模型, 原因:简单模型不易过拟合, 实践:先试线性回归->不够再多项式->最后深度学习, 面试追问:为什么不直接用最复杂模型->过拟合风险高+训练成本高+解释性差, critical]

# ═══ Page 12: KNN算法 — 5步流程·分类vs回归（ch08） ═══

KNN算法: [K-Nearest-Neighbors, 核心公式:d(x_q,x_i)=distance(query,train_i)->排序->取前K个, 惰性学习:不构建参数模型-存储全部训练集-预测时O(m·n)遍历计算, 面试追问:KNN有训练过程吗->没有-惰性学习, critical]
KNN分类: [5步:1-计算d(x_q,x_i)对所有i, 2-按d升序排列, 3-取前K个最近邻{x_nn1,...,x_nnK}, 4-多数表决:ŷ=mode(y_nn1,...,y_nnK), 5-输出离散标签, critical]
KNN回归: [5步:前3步同分类, 4-求均值:ŷ=1/K·Σ(y_nni), 5-输出连续值, 分歧仅在第4步:分类mode(投票)|回归mean(均值), 面试必答:一句话区别->第4步不同, critical]
KNN算法.电影分类示例: [特征:x1=打斗次数-x2=接吻次数, 训练集:动作片(多打斗少接吻)-爱情片(少打斗多接吻), 未知电影:计算到所有训练样本的欧氏距离->取K=5最近邻->3个动作片2个爱情片->预测:动作片, critical]

# ═══ Page 13: 距离度量 — 欧氏·曼哈顿·闵氏统一框架（ch08） ═══

欧氏距离: [Euclidean-Distance, d=√(Σ(xi-yi)²), 两点间直线距离-勾股定理推广到n维, KNN默认距离, 示例:A(1,1)-B(2,2)->d=√(1²+1²)=√2≈1.414, critical]
曼哈顿距离: [Manhattan-Distance, d=Σ|xi-yi|, 城市街区距离:只走横平竖直-各维绝对值之和, 示例:A(1,1)-B(2,2)->d=|1|+|1|=2, important]
切比雪夫距离: [Chebyshev-Distance, d=max(|xi-yi|), 棋盘距离:国际象棋国王一步可达相邻8格, 示例:A(1,1)-B(4,2)->d=max(3,1)=3, important]
闵氏距离: [Minkowski-Distance-统一框架, d=(Σ|xi-yi|^p)^(1/p), p=1:曼哈顿|p=2:欧氏|p→∞:切比雪夫, 不是新距离-是参数化统一公式, sklearn参数:metric='minkowski'-p=2, critical]
闵氏距离.p无穷推导: [当p→∞:最大分量|xi-yi|^p远超其他分量之和, 开p次根后其他项贡献→0, 极限:lim(p→∞)(Σ|xi-yi|^p)^(1/p)=max(|xi-yi|)=切比雪夫, 面试追问:为什么p无穷等价切比雪夫, important]
距离度量.量纲警示: [特征量纲不同->大量纲特征主导距离, 例:年收入(万级)vs年龄(十级)->距离几乎只由收入决定, 这就是为什么KNN必须做特征预处理, critical]

# ═══ Page 14: K值选择 + KNN API（ch08） ═══

K值选择: [K:KNN唯一核心超参数-不从数据学来-需人为设定, K过小(K=1)->极小邻域->噪声敏感->过拟合, K过大(K=N)->看全部样本->永远预测多数类->欠拟合, 实践:取较小奇数3|5|7|9-用交叉验证选最优, critical]
K值选择.复杂度因果: [K=1:决策边界极复杂-每个训练点独占领地-记住噪声, K=5:边界适中-局部投票-兼顾局部和全局, K=N:边界最简单-全局多数类-丧失局部判别力, K值反向控制模型复杂度:K越小越复杂-K越大越简单, critical]

KNN.分类器API: [from-sklearn.neighbors-import-KNeighborsClassifier, clf=KNeighborsClassifier(n_neighbors=5), clf.fit(X_train,y_train), y_pred=clf.predict(X_test), acc=clf.score(X_test,y_test), critical]
KNN.回归器API: [from-sklearn.neighbors-import-KNeighborsRegressor, reg=KNeighborsRegressor(n_neighbors=5), 用法同分类器-输出连续值均值, important]
KNN.predict陷阱: [predict输入必须二维:predict([[1]])正确|predict([1])报错, 原因:sklearn统一要求(m,n)矩阵-单样本也要[[value]], 评估:score(X_test,y_test)或accuracy_score(y_true,y_pred), critical]

# ═══ Page 15: Day01总结 + Day02预告 ═══

day01.公式速查: [y=wx+b线性模型, x'=(x-min)/(max-min)归一化, x'=(x-μ)/σ标准化, d=√(Σ(xi-yi)²)欧氏距离, d=(Σ|xi-yi|^p)^(1/p)闵氏距离, MSE=1/m·Σ(yi-ŷi)²均方误差, L1:Loss+λΣ|wi|, L2:Loss+λΣwi², critical]
day01.API速查: [train_test_split(X,y,test_size,random_state), MinMaxScaler().fit_transform(), StandardScaler().fit_transform(), PCA(n_components).fit_transform(), KNeighborsClassifier(n_neighbors).fit().predict().score(), critical]
day01.三大洞察: [洞察1:数据和特征决定ML上限-模型只是逼近, 洞察2:训练集测试集必须分离-防数据泄露, 洞察3:模型复杂度需平衡-追求正好拟合和泛化, critical]
day01.能力检验: [能写出:y=wx+b并解释w和b含义, 能区分:回归(连续)vs分类(离散), 能计算:归一化和标准化的结果, 能描述:KNN五步流程, 能诊断:看loss曲线判断拟合状态, critical]

day02预告: [KNN实战深化:fit_transform铁律与数据泄露->鸢尾花完整Pipeline->交叉验证K折->GridSearchCV网格搜索->MNIST手写数字识别, @factors/ch09-knn-practice.factor, critical]

day03预告: [线性回归全流程:定义与KNN对比->数据预处理(标准化vs归一化)->损失函数(MSE碗形保证)->正规方程与梯度下降->评估(MAE/MSE/RMSE)->多项式特征->正则化(L1/L2), @linear-regression/linear-regression.factor, critical]

day04预告: [梯度下降与模型评估:正规方程vs梯度下降选择->正向反向传播->链式法则->学习率与标准化->评估指标(R²+RMSE双视角)->拟合诊断(欠拟合/过拟合)->正则化L1弹簧L2刀, @linear-regression/gradient-descent/gradient-descent.factor, critical]

# source — 章节因子图谱引用
source.ch01: [@factors/ch01-ai-ml-dl-concepts.factor, pages:1, critical]
source.ch02: [@factors/ch02-ml-terminology.factor, pages:2, critical]
source.ch03: [@factors/ch03-ml-algorithm-classification.factor, pages:3-4, critical]
source.ch04: [@factors/ch04-ml-modeling-pipeline.factor, pages:5, critical]
source.ch05: [@factors/ch05-feature-engineering.factor, pages:6-9, critical]
source.ch06: [@factors/ch06-model-fitting.factor, pages:10-11, critical]
source.ch07: [@factors/ch07-homework.factor, absorbed-into:pages-4+5+6+11, critical]
source.ch08: [@factors/ch08-knn.factor, pages:12-14, critical]
source.linear-regression: [@linear-regression/linear-regression.factor, day03:线性回归全流程, critical]

# ~97%
