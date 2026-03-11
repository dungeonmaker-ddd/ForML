# use-this-graph-to-build: ch09 KNN实战 — 距离度量·预处理·调优
# confirm-sufficiency-before-start: 本图谱覆盖KNN从原理到工程到哲学的全部面试级知识点，7内容页布局
# scope: ML-intro-chapter-09
# status: updated

# ═══ Page 1: KNN算法思想 + 分类/回归流程 ═══

knn思想: [K-Nearest-Neighbors-K近邻, 核心:特征空间中K个最近邻的多数类别决定未知样本类别, 惰性学习:无显式训练-预测时才计算, 解决:分类+回归两类问题, critical]
knn思想.特征空间相似性: [样本在特征空间中距离越近越相似, 距离=斜边:两轴差值=直角边-勾股定理求斜边, 默认度量:欧氏距离, critical]
knn思想.电影分类示例: [特征:打斗次数+接吻次数, 标签:动作片|爱情片, 训练集:已知类型电影, 测试集:未知电影, 在2D特征空间中计算距离->判类别, critical]
knn思想.惰性本质: [不构建参数模型-存储全部训练数据, 预测时遍历计算距离, 区别于线性模型:线性模型学习权重w1|w2|w3-KNN无参数, important]
knn思想.非参数哲学: [非参数模型nonparametric:模型复杂度随数据量增长-数据即模型, 参数模型parametric:h(w)=w1x1+w2x2+b-复杂度固定-数据压缩为有限权重, KNN属前者:训练数据越多-决策边界越精细, 哲学对比:记住每个案例vs提炼规律, critical]
knn思想.代价: [惰性学习的代价:预测时间O(n*d)-n训练样本数-d特征维度, 内存占用:必须存储全部训练数据, 维度灾难:高维空间中距离区分度下降-所有点看起来都差不多远, 面试追问:KNN有什么缺点, critical]
knn思想.KD-Tree加速: [暴力搜索O(n*d)不可接受->KD-Tree:将空间递归二分-预测时剪枝搜索-平均O(d*logn), Ball-Tree:适合高维-用超球体划分, sklearn默认algorithm=auto:样本少用brute|特征少用kd_tree|高维用ball_tree, 面试追问:KNN怎么加速, important]
knn思想.Voronoi直觉: [1-NN的决策边界是Voronoi图:空间被划分为每个训练样本的最近区域, K增大->边界变平滑->过拟合->欠拟合的连续谱, 面试画图题:画出K=1和K=N的决策边界, important]

knn分类流程: [5步:1-计算未知样本到每个训练样本距离->2-距离升序排列->3-取前K个最近邻->4-多数表决统计各类别数量->5-归属出现最多的类别, 输出:离散标签, critical]
knn回归流程: [5步:1-计算距离->2-升序排列->3-取前K个->4-K个样本目标值求均值->5-均值作为预测值, 输出:连续数值, critical]
knn分类vs回归: [前3步完全相同:距离-排序-取K, 分歧在第4步:分类用投票|回归用均值, 面试必答:清楚说出差异点, critical]

# ═══ Page 2: K值选择 + KNN API ═══

k值选择: [KNN唯一核心超参数, 不从数据学来-需人为设定, K决定模型复杂度, critical]
k值选择.过小: [K过小->极小邻域预测, 后果:异常点敏感-坐标微变则分类翻转-决策边界极复杂, 本质:记住噪声非规律->过拟合, critical]
k值选择.过大: [K过大->极大邻域预测, 极端K=N:永远预测训练集多数类-忽略局部特征, 后果:受类别不均衡支配-模型过于简单, 本质:丢失局部判别力->欠拟合, critical]
k值选择.偏差方差: [K是偏差-方差权衡的旋钮:K=1零偏差但高方差(训练集误差为0)|K=N高偏差但零方差(永远预测均值), 最优K在中间:用CV找到bias²+variance最小的平衡点, 面试升华:K值选择本质是bias-variance-tradeoff, critical]
k值选择.实践: [取较小奇数避免平局:3|5|7|9, 用交叉验证遍历候选K值选最优, important]

api.分类器: [KNeighborsClassifier(n_neighbors=5), 导入:from-sklearn.neighbors-import-KNeighborsClassifier, 默认K=5, critical]
api.分类器.用法: [X必须二维矩阵:[[0],[1],[2],[3]]代表4样本1特征, y一维标签:[0,0,1,1], fit(X,y)训练->predict(X)预测->score(X,y)评估, critical]
api.分类器.完整代码: [from-sklearn.neighbors-import-KNeighborsClassifier, estimator=KNeighborsClassifier(n_neighbors=1), X=[[0],[1],[2],[3]]-y=[0,0,1,1], estimator.fit(X,y), estimator.predict([[4]])->输出[1], 这4行是最小可运行KNN, important]
api.回归器: [KNeighborsRegressor(n_neighbors=5), 导入:from-sklearn.neighbors-import-KNeighborsRegressor, 用法同分类器-输出连续值均值, important]
api.predict陷阱: [predict输入必须二维:predict([[1]])正确|predict([1])报错, 原因:sklearn统一要求矩阵输入-即使单样本也要嵌套列表, 面试代码题高频考点, critical]
api.评估方式: [方式1:estimator.score(x_test,y_test)返回准确率, 方式2:accuracy_score(y_true,y_predict)-需from-sklearn.metrics-import, 两种方式结果一致, important]

# ═══ Page 3: 距离度量 ═══

距离度量: [distance-measure-距离度量, KNN核心计算基础, 不同距离公式衡量样本相似度, 量纲不同->距离被大量纲特征主导->引出预处理需求, critical]
距离度量.欧氏: [Euclidean-Distance-欧氏距离, 公式:d=sqrt(sum((xi-yi)^2)), 几何:两点直线距离-勾股定理推广到n维, 最常用-KNN默认距离, 示例:A(1,1)-B(2,2)->d=sqrt(1+1)=1.414, critical]
距离度量.曼哈顿: [Manhattan-Distance-曼哈顿距离, 公式:d=sum(|xi-yi|), 城市街区距离:只走横平竖直-各维绝对值求和, 示例:A(1,1)-B(2,2)->d=|1|+|1|=2, important]
距离度量.切比雪夫: [Chebyshev-Distance-切比雪夫距离, 公式:d=max(|xi-yi|), 棋盘距离:国际象棋国王走一步可到相邻8格-最少步数即切比雪夫距离, important]
距离度量.闵可夫斯基: [Minkowski-Distance-闵氏距离, 不是新距离-是统一框架, 公式:d=(sum(|xi-yi|^p))^(1/p), p=1:曼哈顿|p=2:欧氏|p->inf:切比雪夫, critical]
距离度量.p无穷推导: [当p->inf:最大分量|xi-yi|的p次方远超其他分量之和, 开p次根后其他项贡献趋于0, 极限只剩max(|xi-yi|)=切比雪夫, 面试追问:为什么p无穷等价切比雪夫, important]
距离度量.量纲警示: [特征量纲不同->大量纲特征主导距离, 例:年收入(万元级)vs年龄(十位级)->收入差异淹没年龄差异, 这就是为什么需要归一化/标准化, critical]
距离度量.sklearn参数: [KNeighborsClassifier(metric='minkowski',p=2):默认欧氏, p=1:曼哈顿, 自定义距离:metric=callable, algorithm参数:auto|ball_tree|kd_tree|brute, 面试:知道怎么在sklearn中切换距离, important]

# ═══ Page 4: 特征预处理（归一化 vs 标准化）═══

预处理: [feature-preprocessing-特征预处理, KNN基于距离->量纲差异导致大特征主导小特征被淹没, 预处理是KNN前置刚需-不做则结果失真, critical]
预处理.归一化: [MinMaxScaler-归一化, 公式:x'=(x-min)/(max-min), 映射到[0,1]区间, API:MinMaxScaler(feature_range=(0,1)), fit_transform(X)执行变换, critical]
预处理.归一化弊端: [致命缺陷:max/min若为异常值->全部数据被过度压缩, 鲁棒性差, 仅适合:传统精确小数据-数据范围已知-无异常值, critical]
预处理.归一化代码: [from-sklearn.preprocessing-import-MinMaxScaler, data=[[90,2,10,40],[60,4,15,45],[75,3,13,46]], transformer=MinMaxScaler(), data=transformer.fit_transform(data), 结果:每列独立缩放到[0,1], important]
预处理.标准化: [StandardScaler-标准化, 公式:x'=(x-mean)/std, 转换为均值0标准差1的标准正态分布N(0,1), API:StandardScaler(), 属性:mean_均值-var_方差, critical]
预处理.标准化数学本质: [标准化后每个特征方差=1->每个特征对距离的贡献相等, 未标准化:方差大的特征主导距离(年收入方差远大于年龄)->标准化消除这种不公平, 数学本质:距离公式中每一项的量级被对齐, critical]
预处理.标准化优势: [少量异常值对均值和std影响可忽略-鲁棒性强, 适合:现代嘈杂大数据场景, 实践结论:优先选标准化, critical]
预处理.标准化代码: [from-sklearn.preprocessing-import-StandardScaler, transformer=StandardScaler(), data=transformer.fit_transform(data), print(transformer.mean_)->每列均值, print(transformer.var_)->每列方差, important]
预处理.归一vs标准对比: [归一化:受极值支配-鲁棒差-小数据|标准化:受均值std驱动-鲁棒强-大数据, 面试必答:说出本质区别和适用场景, critical]
预处理.正态分布: [正态分布=高斯分布:N(mu,sigma), mu决定位置-sigma决定幅度, 标准正态:mu=0-sigma=1, 方差sigma^2衡量弥散度, 1sigma:68%-2sigma:95%-3sigma:99.7%, 1sigma到2sigma之间:约27%, important]
预处理.训练测试铁律: [训练集:fit_transform->学习mean和std并转换, 测试集:只用transform->复用训练集的mean和std, 绝对禁止:对测试集fit_transform, critical]
预处理.铁律因果: [为什么禁止:测试集代表未见数据-fit会学习测试集统计量->模型间接见过测试集->评估结果虚高, 这就是数据泄露data-leakage, 后果:线下评估好-线上表现差-因为测试集信息已渗入训练过程, 面试能说出data-leakage这个词=加分项, critical]
预处理.泄露扩展: [数据泄露不只是fit_transform:在全数据集上做特征选择再划分=也是泄露, sklearn.pipeline.Pipeline:把预处理和模型串成链-从根本上防止泄露, Pipeline(steps=[('scaler',StandardScaler()),('knn',KNeighborsClassifier())]), important]

# ═══ Page 5: 鸢尾花案例（ML完整pipeline）═══

鸢尾花案例: [iris-dataset经典入门, 150样本-4特征(花萼长宽+花瓣长宽)-3类别(setosa|versicolor|virginica), API:load_iris(), 属性:data|target|target_names|feature_names|DESCR, critical]
鸢尾花案例.数据属性: [.data:150x4浮点矩阵, .target:150个整数标签(0|1|2), .target_names:['setosa','versicolor','virginica'], .feature_names:['sepal-length','sepal-width','petal-length','petal-width']-单位cm, .DESCR:数据集完整描述, important]
鸢尾花案例.标准流程: [ML-pipeline模板:1-load_iris获取数据->2-train_test_split划分(test_size=0.2,random_state=22)->3-StandardScaler标准化->4-KNeighborsClassifier.fit训练->5-score评估准确率, 这个5步流程是所有ML项目通用模板, critical]
鸢尾花案例.数据划分: [train_test_split(data,target,test_size,random_state), test_size:测试集占比-常用0.2, random_state:随机种子保证可复现, 返回:X_train-X_test-y_train-y_test四元组, critical]
鸢尾花案例.标准化实践: [第3步体现铁律:x_train=transfer.fit_transform(x_train)->x_test=transfer.transform(x_test), 训练集学参数+变换|测试集只变换, 这是预处理铁律的实战落地, critical]
鸢尾花案例.数据探索: [用seaborn.lmplot可视化特征散点图, 目的:确认特征能否分开不同类别, 特征选择:sepal-length-vs-petal-width, 探索先于建模, important]
鸢尾花案例.模型评估: [score返回准确率:100个测试样本中预测对了多少, 也可用accuracy_score对比y_test和y_predict, 评估是pipeline最后一步-决定模型是否可用, important]
鸢尾花案例.完整代码: [完整15行代码:导入4个包->load_iris->train_test_split->StandardScaler->fit_transform+transform->KNeighborsClassifier(n_neighbors=3)->fit->predict->score, 面试手写代码:能默写这15行=KNN完全掌握, critical]

# ═══ Page 6: 交叉验证 + 网格搜索 ═══

交叉验证: [cross-validation-CV, 目的:更准确可信地评估模型-避免单次划分的偶然性, 方法:训练集分N份-轮流1份验证其余训练-N次结果取平均, critical]
交叉验证.为何优于holdout: [简单holdout(一次train_test_split)的问题:划分不同->得分不同-运气成分大, CV用N次不同划分取平均->消除随机性, 类比:考一次试可能发挥失常-考N次取平均才是真实水平, 面试:为什么不直接split评估, critical]
交叉验证.流程: [以cv=4为例:第1次-份1验证+份2,3,4训练->第2次-份2验证+份1,3,4训练->...->4次评估取平均=模型得分, 常用:cv=5或cv=10, critical]
交叉验证.后续步骤: [选定最优超参后->用全部训练集(训练+验证)重新训练一遍->再用独立测试集做最终评估, 不能遗忘验证集数据-要完整利用, important]
交叉验证.本质: [划分数据集的方法-不是调参方法, 目的:得到可信模型评分, 与网格搜索是互补关系:CV评估+网格搜索调参, critical]

网格搜索: [GridSearchCV-网格搜索, 目的:自动穷举超参组合找最优, 本质:暴力搜索-每组超参都用CV评估, 是模型调参的有力工具, critical]
网格搜索.api: [GridSearchCV(estimator,param_grid,cv), param_grid:字典如{'n_neighbors':[1,3,5,7]}, 结果属性:best_params_最优参数|best_score_最优得分|best_estimator_最优模型|cv_results_全部结果, critical]
网格搜索.训练次数: [总次数=超参组合数*cv折数, 例:4个K值*5折CV=20次模型训练, 面试计算题, important]
网格搜索.高维困境: [超参多+候选值多->组合爆炸, 网格搜索=暴力破解-高维超空间代价极大, 替代方案:RandomizedSearchCV随机搜索, important]
网格搜索.组合威力: [CV解决数据划分->可靠评分, 网格搜索解决超参组合->高效调参, 两者组合=模型调优完整方案, critical]
网格搜索.refit陷阱: [GridSearchCV默认refit=True:找到最优超参后自动用全部训练集重新训练, best_estimator_已是最终可用模型-不需手动再训练, 面试陷阱:问你"网格搜索完还需要重新fit吗"->答:不需要-refit已自动完成, important]

# ═══ Page 7: 手写数字识别案例 ═══

MNIST案例: [MNIST手写数字识别, 1999年发布-分类基准经典, 6万训练+1万测试=7万张28x28灰度图, critical]
MNIST案例.数据结构: [每图28x28=784像素展平为一维向量, 像素值0-255:越大越深, train.csv:785列-第1列标签(0-9)-后784列pixel0到pixel783, critical]
MNIST案例.实战流程: [复用鸢尾花5步pipeline:1-加载csv数据->2-划分训练测试集->3-标准化784维像素特征->4-KNN+GridSearchCV调优K值->5-score评估, 证明pipeline的通用性, critical]
MNIST案例.完整代码: [import-pandas-as-pd, data=pd.read_csv('train.csv'), x=data.iloc[:,1:].values-y=data.iloc[:,0].values, train_test_split->StandardScaler->GridSearchCV(KNeighborsClassifier(),{'n_neighbors':[3,5,7]},cv=3), estimator.fit->estimator.score, critical]
MNIST案例.KNN局限: [KNN可做但效率低:遍历7万样本计算784维距离-代价巨大, 维度灾难在此最直观:784维空间中距离区分度急剧下降, 实际生产常用CNN卷积神经网络, important]
MNIST案例.与鸢尾花对比: [鸢尾花:150样本-4维-小数据入门|MNIST:7万样本-784维-大数据实战, 同一pipeline不同规模:体现标准化和调优在大数据下的必要性, important]
MNIST案例.算法选型: [KNN:准确率约96%-预测极慢|SVM:准确率约97%-训练慢|CNN:准确率99%+-速度快, KNN在此的意义:验证pipeline通用性-不是最优解, 面试:知道什么场景该用什么算法, important]

# ═══ 边 ═══
knn思想 -> knn分类流程: [KNN解决分类问题, critical]
knn思想 -> knn回归流程: [KNN解决回归问题, critical]
knn思想.特征空间相似性 -> 距离度量: [相似性通过距离度量实现, critical]
knn思想.惰性本质 -> knn思想.代价: [惰性学习导致计算和内存代价, critical]
knn思想.惰性本质 -> knn思想.非参数哲学: [惰性学习源于非参数本质, critical]
knn思想.代价 -> knn思想.KD-Tree加速: [代价驱动加速方案, important]
knn思想.KD-Tree加速 -> 距离度量.sklearn参数: [加速算法通过algorithm参数指定, important]
knn思想.Voronoi直觉 -> k值选择: [Voronoi边界随K变化, important]
knn分类流程 -> 距离度量: [流程第1步计算距离, critical]
knn回归流程 -> 距离度量: [流程第1步计算距离, critical]
k值选择 -> k值选择.过小: [K过小导致过拟合, critical]
k值选择 -> k值选择.过大: [K过大导致欠拟合, critical]
k值选择.过小 -> k值选择.偏差方差: [过拟合=高方差, critical]
k值选择.过大 -> k值选择.偏差方差: [欠拟合=高偏差, critical]
k值选择.实践 -> 交叉验证: [用CV选最优K, critical]
api.分类器 -> knn分类流程: [分类API实现分类流程, important]
api.回归器 -> knn回归流程: [回归API实现回归流程, important]
距离度量 -> 距离度量.闵可夫斯基: [闵氏距离统一三种距离, critical]
距离度量.闵可夫斯基 -> 距离度量.欧氏: [p=2即欧氏, critical]
距离度量.闵可夫斯基 -> 距离度量.曼哈顿: [p=1即曼哈顿, important]
距离度量.闵可夫斯基 -> 距离度量.切比雪夫: [p->inf即切比雪夫, important]
距离度量.量纲警示 -> 预处理: [量纲差异驱动预处理需求, critical]
预处理 -> 预处理.归一化: [归一化是方法之一, important]
预处理 -> 预处理.标准化: [标准化是首选方法, critical]
预处理.归一化弊端 -> 预处理.归一vs标准对比: [归一化缺陷驱动标准化需求, critical]
预处理.标准化 -> 预处理.标准化数学本质: [理解为什么标准化有效, critical]
预处理.标准化 -> 预处理.训练测试铁律: [标准化使用必须遵守fit/transform分离, critical]
预处理.训练测试铁律 -> 预处理.铁律因果: [铁律背后是数据泄露原理, critical]
预处理.铁律因果 -> 预处理.泄露扩展: [数据泄露的更广泛形式, important]
预处理 -> 鸢尾花案例: [鸢尾花案例体现预处理效果, important]
鸢尾花案例.标准流程 -> 预处理: [流程第3步是特征工程, critical]
鸢尾花案例.标准流程 -> api.分类器: [流程第4步是模型训练, critical]
鸢尾花案例.标准化实践 -> 预处理.训练测试铁律: [案例中铁律的实战落地, critical]
交叉验证 -> 网格搜索: [网格搜索内部使用CV, critical]
交叉验证.为何优于holdout -> 交叉验证: [holdout缺陷驱动CV需求, critical]
网格搜索 -> 网格搜索.api: [GridSearchCV是实现工具, important]
网格搜索.组合威力 -> 网格搜索.refit陷阱: [组合方案的隐藏行为, important]
网格搜索 -> MNIST案例: [MNIST案例用网格搜索调优K, important]
MNIST案例.实战流程 -> 鸢尾花案例.标准流程: [MNIST复用鸢尾花pipeline模板, critical]
knn思想.代价 -> MNIST案例.KNN局限: [KNN计算代价在MNIST上暴露无遗, important]
MNIST案例.KNN局限 -> MNIST案例.算法选型: [局限驱动算法升级, important]

# ~98%
