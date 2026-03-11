一样的 我们现在开始做下一天的知识点总结 我会把我觉得重要的发给你 但是你需要筛选 你觉得重要的 并补全部分知识点 产出factor

KNN算法简介
KNN思想、分类和回归问题处理流程
KNN算法API介绍
分类、回归实现
距离度量
常用距离计算方法
特征预处理
归一化、标准化、鸢尾花识别案例
超参数选择方法
交叉验证、网格搜索、手写数字识别案例


学习目标
理解K近邻算法的思想
知道K近邻算法分类流程
知道K近邻算法回归流程

第一个问题： 样本的接近程度：
样本都是属于一个数据集。在特征空间中，样本距离越近则越相似。
利用K近邻算法预测电影类型
左表  注明 特征   标签    训练集   测试集
右图  讲明  特征空间2个样本点， 如何获得 两条直角边 ？ 如何获得斜边 ？
左表  手把手教一次 计算
末页参考
线性模型是指h(w)是关于w的函数，权重参数w1、w2、w3是1次幂（比如 0.4 0.3 0.2）

第二个问题   K值选择
K 太小  过拟合   分类决策边界过于复杂：
K值过小：用较小邻域中的训练实例进行预测 
容易受到异常点的影响
K值的减小：
对测试样本的特征值(坐标)高度敏感，稍微变化一丢丢，可能分类就变了。 ----
就意味着整体模型分类决策边界变得非常复杂，容易发生过拟合

K值过大：用较大邻域中的训练实例进行预测
举例：K=N（N为训练样本个数,  样本全体拿来做参考）
无论输入实例是什么，只会按训练集中最多的类别进行预测,
和新样本的特征值（坐标位置）关系不大
受到样本均衡的问题 
且K值的增大就意味着整体的模型变得傻瓜，
无论测试样本在哪，分类不怎么变化。
模型无法捕捉参数空间的局部特征  -- 欠拟合


解决问题：分类问题、回归问题
算法思想：若一个样本在特征空间中的 k 个最相似的样本大多数属于某一个类别，则该样本也属于这个类别
相似性：欧氏距离

分类流程
计算未知样本到每一个训练样本的距离
将训练样本根据距离大小升序排列
取出距离最近的 K 个训练样本
进行多数表决，统计 K 个样本中哪个类别的样本个数最多
将未知的样本归属到出现次数最多的类别

回归流程
计算未知样本到每一个训练样本的距离
将训练样本根据距离大小升序排列
取出距离最近的 K 个训练样本
把这个 K 个样本的目标值计算其平均值
作为将未知的样本预测的值

1 KNN概念 K Nearest Neighbor 
一个样本最相似的 k 个样本中的大多数属于某一个类别，则该样本也属于这个类别 

2 KNN分类流程  
计算未知样本到每一个训练样本的距离
将训练样本根据距离大小升序排列
取出距离最近的 K 个训练样本
进行多数表决，统计 K 个样本中哪个类别的样本个数最多
将未知的样本归属到出现次数最多的类别

3 KNN回归流程
计算未知样本到每一个训练样本的距离
将训练样本根据距离大小升序排列
取出距离最近的 K 个训练样本
把这个 K 个样本的目标值计算其平均值
将未知的样本预测的值了

4 K值的选择
K值过小：过拟合
K值过大：欠拟合

1、有关KNN的K值选择，以下说法中正确的是？（多选）

A）若k值过小，意味着模型更易受到异常点影响，更易学习到嘈杂数据，模型有过拟合的风险。

C）若k值与训练集样本数相同，会导致最终模型的结果都是指向训练集中类别数
      最多的那一类，忽略了数据当中其它的重要信息，模型会过于简单。

D）实际工作中经常使用交叉验证的方式去选取最优的k值，而且一般情况下，
      k值都是比较小的数值。

KNN解决什么问题
1）KNN：K Nearest Neighbor。
即解决的是寻找与未知样本 _______ 的K个样本，并对未知样本所属的分类或者属性进行预测的问题。
2）距离度量：
空间中两个样本的距离通过 _________ 来度量的。
答案解析：① 最近邻；② 欧氏距离

学习目标
掌握KNN算法分类API
掌握KNN算法回归API

 KNN分类API
         sklearn.neighbors.KNeighborsClassifier(n_neighbors=5) 
         n_neighbors：int,可选（默认= 5）

from sklearn.neighbors import KNeighborsClassifierdef dm01_knnapi_分类():    estimator =  KNeighborsClassifier(n_neighbors=1)    X = [[0], [1], [2], [3]]          必须二维结构 （代表4样本，1列特征 矩阵）    y = [0, 0, 1, 1]    estimator.fit(X, y)    myret = estimator.predict([[4]])    必须二维结构    print('myret-->', myret)

KNN回归API：
sklearn.neighbors.KNeighborsRegressor(n_neighbors=5)

from sklearn.neighbors import KNeighborsRegressordef dm02_knnapi_回归():    estimator =  KNeighborsRegressor(n_neighbors=2)    X = [[0, 0, 1],                                                         必须二维结构         [1, 1, 0],         [3, 10, 10],         [4, 11, 12]]    y = [0.1, 0.2, 0.3, 0.4]    estimator.fit(X, y)    myret = estimator.predict([[3, 11, 10]])           必须二维结构    print('myret-->', myret)

以下关于KNN算法API的使用有误的一项是？

1）导入算法对象：
      from sklearn.neighbors import KNeighborsClassifier  ----------------- A

2）构造数据：
      x = [[0], [1], [2], [3]]
      y = [0, 0, 1, 1]

3）实例化算法API：
     estimator = KNeighborsClassifier(n_neighbors=2)  --------------------- B

4）训练模型并预测：
      estimator.fit(x, y)  ------------------------------------------------------- C
      estimator.predict([1])  --------------------------------------------------- D
答案解析：D。正确代码应为：estimator.predict([[1]]) 


学习目标
掌握欧氏距离的计算方法 
掌握曼哈顿距离的计算方法
了解切比雪夫距离的计算方法
了解闵可夫斯基距离的计算方法

距离度量 distance measure – 常见距离公式 
欧氏距离 Euclidean Distance
举个例子：ABCD四点 X=[[1,1],[2,2],[3,3],[4,4]] ，计算AB AC AD BC BD距离
      	经计算得: AB = √(〖(2−1)〗^2  +〖(2−1)〗^2 )  = √( 2 ) = 1.414
       	d = 1.4142 	2.8284 	4.2426 	1.4142 	2.8284 	1.4142

特征量纲不同，这就是为啥需要归一化

曼哈顿距离(Manhattan Distance)
     也称为“城市街区距离”(City Block distance)，曼哈顿城市特点：横平竖直 = 对应维度的绝对值，求和
举个例子：
ABCD四点 X=[ [1,1], [2,2], [3,3], [4,4] ] ，
计算AB AC AD BC BD曼哈顿距离
经计算得: AB =|2−1|+ ⌈2−1⌉= 2         
d = 2 4 6 2 4 2

切比雪夫距离 Chebyshev Distance   棋盘距离    
国际象棋中，国王可以直行、横行、斜行，所以国王走一步可以移动到相邻8个方格中的任意一个。
国王从格子(x1,y1)走到格子(x2,y2)最少需要多少步？这个距离就叫切比雪夫距离。

闵可夫斯基距离 Minkowski Distance  闵氏距离
不是一种新的距离的度量方式。
是对多个距离度量公式的概括性的表述
两个n维变量 a( x11 ,x12, …, x1n ) 与  b( x21, x22,…, x2n )
       间的闵可夫斯基距离定义为
其中p是一个变参数：
        当 p=1 时，就是曼哈顿距离；
        当 p=2 时，就是欧氏距离；
        当 p→∞ 时，就是切比雪夫距离      为啥 ？？
根据 p 的不同，闵氏距离可表示某一类种的距离

闵可夫斯基距离  当 p无穷大时，相当于切比雪夫距离？
指明 参数归一化标准化的意义。 避免距离计算被主导
1、对于n维空间中的两个点 a(x11, x12, …, x1n) 和 b(x21, x22, …, x2n) 来说，
    下列哪个公式是闵可夫斯基距离的一般表达式？

学习目标
知道为什么进行归一化、标准化
能应用归一化API处理数据
能应用标准化API处理数据
使用KNN算法进行鸢尾花分类

为什么做归一化和标准化 ?
特征的单位或者大小相差较大，或者某特征的方差相比其他的特征要大出几个数量级，容易影响（支配）预测结果，使得一些模型（算法）无法学习到其它的特征。
比如  KNN 欧式距离的计算

归一化：通过对原始数据进行变换把数据映射到【mi,mx】(默认为[0,1])之间
弊端，受到奇异值影响，存在 过度压缩问题
import numpy as np from sklearn.preprocessing import MinMaxScaler
def dm01_MinMaxScaler():  # 1. 准备数据
    data = [[90, 2, 10, 40],
            [60, 4, 15, 45],
            [75, 3, 13, 46]]

    # 2. 初始化归一化对象
    transformer = MinMaxScaler()

    # 3. 对原始特征进行变换
    data = transformer.fit_transform(data)

    # 4. 打印归一化后的结果
    print(data)

数据归一化API：
1.sklearn.preprocessing.MinMaxScaler (feature_range=(0,1)… )
       feature_range 缩放区间
2. fit_transform(X) 将特征进行归一化缩放

数据标准化：通过对原始数据进行标准化，转换为均值为0标准差为1 的分布的数据
from sklearn.preprocessing import StandardScaler
def dm03_StandardScaler():      # 对特征值进行标准化    # 1. 准备数据
    data = [[  90, 2, 10, 40 ],
                 [  60, 4, 15, 45 ],
                 [  75, 3, 13, 46 ]]        

    # 2. 初始化标准化对象
    transformer = StandardScaler()

    # 3. 对原始特征进行变换
    data = transformer.fit_transform(data)

    # 4. 打印归一化后的结果
    print(data)
    # 5 打印每1列数据的均值和标准差    print('transfer.mean_-->', transfer.mean_)    print('transfer.var_-->', transfer.var_)

1.sklearn.preprocessing. StandardScaler()
2. fit_transform(X) 将特征进行归一化缩放

正态分布是一种概率分布，大自然很多数据或者特征符合正态分布
也叫高斯分布。正态分布记作  N ( μ，σ )
μ决定了其位置，其标准差σ决定了分布的幅度
当μ = 0, σ = 1时的正态分布是标准正态分布
方差"𝞼" ^𝟐是在概率论和统计方差衡量一组数据时 弥散 程度的度量
               其中 μ 为均值  n为数据总数
函数轮廓：高斯分布的概率密度
下方的积分面积：  概率
用网子捞人  1σ  捞到了 68%的人
问题，从1σ到2σ之间  捞到了多少人？


数据归一化
如果出现异常点，影响了最大值和最小值，那么结果显然会发生改变
应用场景：最大值与最小值非常容易受异常点影响，             鲁棒性较差，只适合传统精确小数据场景
sklearn.preprocessing.MinMaxScaler (feature_range=(0,1)… )

数据标准化
如果出现异常点，由于具有一定数据量，少量的异常点对于平均值的影响并不大
应用场景：适合现代嘈杂大数据场景。
      (以后就是用你了）
sklearn.preprocessing.StandardScaler( )

度量值 X’容易受到样本中 ______ 最大值最小值____ 的影响，鲁棒性差。（提示：1分布  2最大值最小值 3方差）

在 ____样本数量较大______ 的情况下，异常值对样本的均值和标准差的影响可以忽略不计。
（提示：1样本数量小   2样本数量大）

利用KNN算法对鸢尾花分类  
实现流程：
# 1 获取数据# 2 数据基本处理# 3 数据集预处理-数据标准化# 4 机器学习(模型训练)# 5 模型评估# 6 模型预测
利用KNN算法对鸢尾花分类 -加载鸢尾花数据集
from sklearn.datasets import load_iris
# 加载鸢尾花数据集, 并显示属性 dataset.data .target .target_names .feature_names .DESCRdef dm01_loadiris():    # 加载数据集    mydataset = load_iris()    # 查看数据集信息    print('\n查看数据集信息-->\n', mydataset.data[:5])    # 查看目标值    print('mydataset.target-->\n', mydataset.target)    # 查看目标值名字    print('mydataset.target_names-->\n', mydataset.target_names)    # 查看特征名    print('mydataset.feature_names-->\n', mydataset.feature_names)    # 查看数据集描述    print('\nmydataset.DESCR-->\n', mydataset.DESCR)    # 数据文件路径    print('mydataset.filename-->\n', mydataset.filename)
E:\LLM-class\code\day02\04-鸢尾花数据查看.py
利用KNN算法对鸢尾花分类 -加载鸢尾花数据集
import seaborn as snsimport matplotlib.pyplot as pltimport pandas as pdfrom sklearn.datasets import load_iris# 显示鸢尾花数据def dm02_showiris():    # 1 载入鸢尾花数据集 并显示特征名称.feature_names    mydataset = load_iris()    print(mydataset.feature_names)    # 2 把数据转换成dataframe格式 设置data, columns属性 目标值名称    iris_d = pd.DataFrame(mydataset['data'], columns=mydataset.feature_names)    iris_d['Species'] = mydataset.target    print('\niris_d-->\n', iris_d)    col1 = 'sepal length (cm)'    col2 = 'petal width (cm)'    # 3 sns.lmplot()显示    sns.lmplot(x=col1, y=col2, data=iris_d, hue='Species', fit_reg=False)    plt.xlabel(col1)    plt.ylabel(col2)    plt.title('iris')    plt.show()

利用KNN算法对鸢尾花分类 - 数据集划分
from sklearn.model_selection import train_test_split
# 数据集划分def dm03_traintest_split():    # 1 加载数据集    mydataset = load_iris()    # 2 划分数据集    X_train, X_test, y_train, y_test =  train_test_split(mydataset.data, mydataset.target, test_size=0.3, random_state=22)    print('数据总数量', len(mydataset.data))    print('训练集中的x-特征值', len(X_train))    print('测试集中的x-特征值', len(X_test))    print(y_train)    

E:\LLM-class\code\day02\06-鸢尾花数据集的切分.py

利用KNN算法对鸢尾花分类
                – 模型训练
E:\LLM-class\code\day02\07-鸢尾花数据集的模型训练.py
E:\LLM-class\code\day02\08-鸢尾花数据集的模型网格搜索+交叉验证.py
补充说明：训练集和测试集的标准化差异
利用KNN算法对鸢尾花分类 – 模型评估
# 1 获取数据集mydataset = load_iris()# 2 数据基本处理x_train, x_test, y_train, y_test = train_test_split(mydataset.data, mydataset.target, test_size=0.2, random_state=22)# 3 数据集预处理-数据标准化transfer = StandardScaler()x_train = transfer.fit_transform(x_train)# 让测试集的均值和方法, 转换测试集数据;x_test = transfer.transform(x_test)# 4 机器学习(模型训练)estimator = KNeighborsClassifier(n_neighbors=3)estimator.fit(x_train, y_train)# 5-1 直接使用score函数 模型评估 100个样本中模型预测对了多少myscore = estimator.score(x_test, y_test)print('myscore-->', myscore)# 5-2 利用sklearn.metrics包中的 accuracy_score 方法
y_predict = estimator.predict(x_test)myresult = accuracy_score(y_test, y_predict)print('myresult-->', myresult)

1 鸢尾花数据集下载和使用 
加载数据集mydataset = load_iris()
数据集属性 dataset.data .target .target_names .feature_names .DESCR

2 案例的总体处理流程  
1 获取数据集
2 数据基本处理
3 特征工程
4 机器学习(模型训练)
5 模型评估

3 使用可视化加载和探索数据，以确定特征是否能将不同类别分开
4 通过标准化特征，并随机抽样到训练集和测试集来准备数据。
5 通过统计学，利用准确率评估机器学习模型

学习目标
知道交叉验证是什么？
知道网格搜索是什么？
知道交叉验证网格搜索API函数用法
能实践交叉验证网格搜索进行模型超参数调优
利用KNN算法实现手写数字识别

什么是交叉验证？
是一种模型评估方法，利用分割后的数据集
将训练集划分为 n 份，拿一份做验证集、其他n-1份做训练集 
交叉验证法原理：将数据集划分为 cv=4 份
第一次：把第一份数据做验证集，其他数据做训练
第二次：把第二份数据做验证集，其他数据做训练
... 以此类推，总共训练4次，评估4次。
使用训练集+验证集多次评估模型，取平均值做交叉验证为模型得分

更换模型超参数，比如 KNN 的 K （邻居数）， 再做交叉验证
若k=5模型得分最好，再使用全部训练集(训练集+验证集) 对k=5模型再训练一遍（即正常训练，不要遗忘），再使用独立测试集对k=5模型做评估
交叉验证法，是划分数据集的一种方法，目的就是为了得到更加准确可信的模型评分。

为什么需要网格搜索？
模型有很多超参数，其不同的超参组合使得模型性能也存在很大的差异。需要手动产生很多超参数组合，来尝试训练不同的模型
每组超参数都采用交叉验证评估，最后选出最优参数组合建立模型。
   
网格搜索是模型调参的有力工具。寻找最优超参数的工具！
只需要将若干参数传递给网格搜索对象，它自动帮我们完成不同超参数的组合、模型训练、模型评估，最终返回一组最优的超参数。

网格搜索 + 交叉验证的强力组合 (模型选择和调优)
交叉验证解决模型的数据输入问题(数据集划分)得到更可靠的模型
网格搜索解决超参数的组合
两个组合再一起形成一个模型参数调优的解决方案
提问：网格搜索 + 交叉验证的强力组合 需要训练几次模型 ？ 

高维网格搜索
但是如果超参很多，选择很广，则  超空间的  网格搜索(暴力破解)越难


利用KNN算法对鸢尾花分类 – 交叉验证网格搜索  
from sklearn.datasets import load_irisimport matplotlib.pyplot as pltimport pandas as pdfrom sklearn.model_selection import train_test_splitfrom sklearn.preprocessing import StandardScalerfrom sklearn.model_selection import train_test_split, GridSearchCVfrom sklearn.neighbors import KNeighborsClassifier

def dm01_鸢尾花knn分类_交叉验证网格搜索():    # 1 获取数据集    mydataset = load_iris()    # 2 数据基本处理-划分数据集    x_train, x_test, y_train ,y_test = train_test_split(mydataset.data, mydataset.target, test_size=0.2,random_state=22)    # 3 数据集预处理-数据标准化    transfer = StandardScaler()    x_train = transfer.fit_transform(x_train)    x_test = transfer.transform(x_test)    # 4 机器学习(模型训练)    estimator = KNeighborsClassifier()    print('estimator-->', estimator)

# 4-2 使用校验验证网格搜索param_grid = {'n_neighbors':[1,3,5,7]}# 输入一个estimator, 出来一个estimator(功能变的强大)estimator = GridSearchCV(estimator=estimator, param_grid=param_grid, cv=5)estimator.fit(x_train, y_train)  # 4个模型 每个模型进行网格搜素找到做好的模型# 4-3 交叉验证网格搜索结果查看# estimator.best_score_ .best_estimator_ .best_params_ .cv_results_print('estimator.best_score_---', estimator.best_score_)print('estimator.best_estimator_---', estimator.best_estimator_)print('estimator.best_params_---', estimator.best_params_)print('estimator.cv_results_---', estimator.cv_results_)# 4-4 保存交叉验证结果myret = pd.DataFrame(estimator.cv_results_)myret.to_csv(path_or_buf='./mygridsearchcv.csv')# 5 模型评估myscore = estimator.score(x_test, y_test)print('myscore-->', myscore)

1、交叉验证和网格搜索的目的是什么？（多选题）

A）为了让被评估的模型更加准确可信，一般会使用交叉验证网格搜索去完成任务。

B）有些算法模型本身自带较多的超参数，无法高效的去筛选比较合适的
      超参数组合。

C）使用交叉验证和网格搜索可以提升模型的可信度和查找最佳参数组合
     的效率。

利用KNN算法实现手写数字识别  

已知数据
MNIST手写数字识别 
1999年发布，成为分类算法基准测试的基础
MNIST仍然是研究人员和学习者的可靠资源

需求
从数万个手写图像的数据集中正确识别数字                6万训练集+1万测试集 共7万张  28x28像素

拓展 ：  通常可以使用CNN  来当做模型进行预测

利用KNN算法实现手写数字识别  
1 数据文件 train.csv 和 test.csv 包含从 0 到 9 的手绘数字的灰度图像。
2 每个图像高 28 像素，宽28 像素，共784个像素。
3 每个像素取值范围 0  ~  255，取值越大意味着该像素颜色越深
4 训练数据集（train.csv）共785列。
      第一列为 "标签"，为该图片对应的手写数字。其余784列为该图像的像素值
5 训练集中的特征名称均有pixel前缀，后面的数字（[0,783])代表了像素的序号。            灰度色表
E:\LLM-class\code\day02\09-手写数字识别.py

演示
CV工程师用openCV读取图像（注意通道顺序）
用opencv进行图像的读取 和 处理 （归一化）
