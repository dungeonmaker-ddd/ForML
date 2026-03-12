# use-this-graph-to-build: Day03 线性回归全流程 — 从KNN到学出公式
# confirm-sufficiency-before-start: 覆盖KNN对比、预处理、损失函数、正规方程/梯度下降、训练全流程、两个fit
# scope: ML-day03-linear-regression
# status: pending

# ═══ Page 0: 封面 — Day03 · 线性回归 ═══

封面: [Day03-线性回归, 英文:Linear-Regression, 副标题:从KNN到学出公式, 目录:5页-KNN对比|预处理与公式|损失函数|求解方法|训练全流程, critical]

# ═══ Page 1: KNN vs 线性回归 — 两种学习范式 ═══

范式对比: [KNN:懒惰学习-不产出模型-预测时才计算距离, 线性回归:参数学习-训练时学出w和b-预测时代入公式, 核心区别:有没有学出一个公式, critical]
范式对比.模型产物: [KNN:无模型-存储全部训练集-O(m·n)遍历, 线性回归:产出一组参数w和b-预测O(n)代入公式, KNN预测慢-线性回归预测快, critical]
范式对比.任务类型: [KNN:主要做分类-输出离散标签(0-9), 线性回归:做回归-输出连续数值(房价350万), 共同点:都是监督学习-都需要带标签数据(x,y), critical]
范式对比.共通基础: [特征-标签-训练集-测试集-标准化:KNN里学过的概念-线性回归全部复用, KNN也能做回归:取K个邻居均值, 线性回归扩展加sigmoid->逻辑回归->能做分类, important]
范式对比.监督学习树: [监督学习-分类:KNN分类|逻辑回归|..., 监督学习-回归:线性回归|KNN回归|..., KNN和线性回归不是完全不同-是同一框架下的不同工具, important]

# ═══ Page 2: 数据预处理与公式选择 ═══

预处理: [线性回归处理数值型表格数据-不是图片像素, 输入:多个特征(面积|楼层|房龄)-输出:一个连续值(房价), 预处理核心:特征缩放-让所有特征量级对齐, critical]
预处理.标准化: [StandardScaler-Z-score, 公式:x'=(x-μ)/σ, 结果:均值=0-标准差=1-95%落在±2, 线性回归常用-适合有噪声的大数据, critical]
预处理.归一化: [MinMaxScaler, 公式:x'=(x-min)/(max-min), 结果:映射到[0,1], 适合已知范围-无异常值-如像素0-255, important]
预处理.易错点: [标准化不是缩放到0~1-那是归一化, 标准化是缩放到±2正态分布, 标准化对象是特征X-不是目标y, y不需要标准化-模型自动通过调w和b适配, critical]

公式选择: [人决定公式形状-机器算参数值, 先一次方程:ŷ=w₁x₁+w₂x₂+b, 效果不好:加平方项PolynomialFeatures(degree=2), 还不行:换模型(决策树|神经网络), critical]
公式选择.多项式: [每个特征可有自己的次方-可交叉相乘, degree=2自动展开:x₁|x₂|x₁²|x₁x₂|x₂², 本质还是线性回归:对参数w是线性的, 代价:特征爆炸-容易过拟合-需正则化, important]
公式选择.线性含义: [⭐-线性的真正含义:对参数w是线性的-不是对数据x, ŷ=w₁×面积+w₂×面积²:x有平方-但对w还是一次的, 所以MSE对w还是碗形-还是线性回归, critical]

# ═══ Page 3: 损失函数 — MSE的碗形保证 ═══

损失函数: [衡量预测值与真实值的差距-数字越小模型越好, 两个用途:训练时指导调参-选型时比较好坏, critical]
损失函数.MAE: [Mean-Absolute-Error, MAE=1/n×Σ|y-ŷ|, 直觉最好:平均偏了多少-单位和y一致, 缺点:0点不可导-优化算法不好算, 用途:评估时看, critical]
损失函数.MSE: [Mean-Squared-Error, MSE=1/n×Σ(y-ŷ)², 平方放大大误差:偏差10→100-偏差40→1600, 处处可导-梯度下降算得顺, 用途:训练时用, critical]
损失函数.RMSE: [Root-MSE, RMSE=√MSE, 单位回到和y一致-可直接理解, 用途:评估时看, important]

碗形保证: [MSE=(y-wx)²对w是二次函数, 二次函数只有一个极值点=最小值, 碗+碗+碗=还是碗:多数据点不改变形状, 多参数:高维碗-还是只有一个最低点, critical]
碗形保证.不可能双坑: [假设两个坑:w=2和w=5都让MSE=0, 意味着2x=5x-不可能, 一个方程对同一输入只有一个最准参数-所以只有一个坑, critical]
碗形保证.求导意义: [导数<0:w太小-增大, 导数>0:w太大-减小, 导数=0:最优解-到了, 导数告诉方向和步幅-这就是梯度下降的全部原理, critical]

# ═══ Page 4: 正规方程与梯度下降 ═══

求解方法: [目标:找让MSE最小的那组w和b, 两种方式:正规方程(一步到位)|梯度下降(一步步逼近), 结果相同-按数据量选, critical]
正规方程: [Normal-Equation, 公式:w=(XᵀX)⁻¹Xᵀy, 一步算出所有w和b-精确解, 优点:精确-不用迭代, 缺点:数据量大时算不动(要求逆矩阵), sklearn的LinearRegression默认用此方法, critical]
正规方程.手算验证: [数据:面积[50,80,100]-房价[150,250,300], 随便猜w=1,b=0→MSE=26300, 正规方程算出w=3.026,b=1.316→MSE=21.9, 从26300到21.9:这就是找最优w的意义, important]

梯度下降: [Gradient-Descent, 思路:从随机w开始-每次沿导数方向微调-反复迭代逼近最优, 优点:数据再大也能跑, 缺点:需调学习率和迭代次数-不是精确解, critical]
梯度下降.选择: [数据量小(几万条内)→正规方程, 数据量大(几十万以上)→梯度下降, sklearn默认帮你选好-不用操心, important]

矩阵作用: [矩阵=把数据打包-一次算完, 没有矩阵:100万条数据写100万行公式, 有矩阵:y_pred=X@w+b一行搞定, 正规方程用矩阵:一个公式解出所有w, important]
矩阵作用.代码等价: [手算版:自己算sum_x-sum_y代入公式, 矩阵版:np.linalg.inv(X.T@X)@X.T@y, sklearn版:model.fit(X,y), 三种写法-同一件事-结果完全一样, important]

# ═══ Page 5: 训练全流程 + 两个 fit ═══

训练流程: [⭐-正确顺序(用户答错后纠正版), step1:数据预处理(标准化+处理缺失值), step2:分割训练集/测试集(80/20), step3:选公式(先用一次线性), step4:训练(正规方程or梯度下降-求最优w和b), step5:评估(测试集上算MSE/RMSE), step6:效果不好→加平方项→还不行→换模型, critical]
训练流程.易错纠正: [标准化是前置步骤-不是效果不好才做, 正规方程和梯度下降不是效果好坏区别-结果相同-只是计算方式不同, 做成矩阵不是独立步骤-数据本身就是矩阵, critical]

两个fit: [⭐-同名不同义-初学者大坑, scaler.fit:看一遍数据-记住均值和标准差(尺子), model.fit:训练模型-算出最优w和b, fit_transform=fit+transform合一步, critical]
两个fit.测试集铁律: [训练集:scaler.fit_transform(X_train)-算尺子+标准化, 测试集:scaler.transform(X_test)-只标准化-复用训练集的尺子, 绝对不能对测试集fit_transform-等于偷看答案, critical]
两个fit.预测保障: [scaler保存了训练集的均值和标准差, 新数据来了必须用同一把尺子标准化, 否则:w的含义对不上-预测结果就错, 类比:模型学的w是基于标准化数据的-新数据不标准化就是用错单位, critical]

代码模板: [from-sklearn.linear_model-import-LinearRegression, from-sklearn.preprocessing-import-StandardScaler, from-sklearn.model_selection-import-train_test_split, from-sklearn.metrics-import-mean_squared_error, 正规方程不做标准化也能算-梯度下降必须标准化, critical]
代码模板.完整流程: [X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.2), scaler=StandardScaler()-X_train=scaler.fit_transform(X_train)-X_test=scaler.transform(X_test), model=LinearRegression()-model.fit(X_train,y_train), y_pred=model.predict(X_test)-mse=mean_squared_error(y_test,y_pred), critical]

# ═══ Page 6: 小结 + 易错点 + Day04预告 ═══

小结.核心认知: [线性回归=在选定公式下找让偏差最小的参数, 线性的真正含义:对w线性-不是对x线性, MSE碗形是数学保证:平方→二次→唯一最低点, 两个fit同名不同义:scaler记尺子-model算参数, critical]
小结.易错清单: [标准化≠缩放到0~1(那是归一化), 标准化是前置步骤-不是补救, 正规方程和梯度下降结果相同-按数据量选, 多个x→预测一个y-不是反过来, critical]
小结.公式速查: [ŷ=w₁x₁+w₂x₂+...+b线性模型, MSE=1/n×Σ(y-ŷ)²均方误差, w=(XᵀX)⁻¹Xᵀy正规方程, x'=(x-μ)/σ标准化, critical]
小结.API速查: [LinearRegression().fit().predict().coef_.intercept_, StandardScaler().fit_transform().transform(), train_test_split(X,y,test_size,random_state), mean_squared_error(y_test,y_pred), PolynomialFeatures(degree).fit_transform(), critical]

day04预告: [梯度下降深入:学习率|迭代次数|收敛判断, 波士顿房价实战:完整Pipeline, 欠拟合与过拟合:正则化L1/L2, important]

# ~95%
