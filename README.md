# ICU-mortality-forecast
## 小样本ICU死亡率预测
包含提取数据（challenge中下载的4000份病例数据）
数据预处理（选择所需变量进行高斯标准化，缺失值插补等处理后提取特征集）
预测ICU死亡率模型主要使用SVM-GLM，与挑战赛的saps对比
变量的降维筛选使用三个指标分别为相关性、费歇尔和mRMR，排序后代入模型
预测结果使用score1=min(Se,PPV)，score2=Hosmer-lemeshow
## MIMICIII大样本数据提取
两种方法实现，分别为PostgreSQL与MATLAB结合（提取的信息更全面，包含各时间点的变量值）；
PostgreSQL方法则直接提取特征集，简单方便
## 大样本数据预处理
包括病例筛选整体过程流程图、归一化的三种方法、异常值的处理和缺失值的多重插补法（MI）、
利用两种方法降维对比（随机森林过滤封装法和逐步代入法）、对于不均衡的数据集采用过采样的十折交叉验证
## 大样本预测方法
包含机器学习算法MLP、SVM、LR、Adaboost、SVM-GLM、RF、SVM-Adaboost、
传统评分SAPSII、APSIII、OASIS、MEWS、SOFA
参数寻优方法有网格搜索法与粒子群法
## 结果评价与分析
包括10个评价指标TPR、NPR、PPV、NPV、ACC、F1、AUROC、Hosmer-lemeshow、NRI、IDI
