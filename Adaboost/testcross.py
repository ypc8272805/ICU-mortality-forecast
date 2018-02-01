# -*- coding: utf-8 -*-
"""
Created on Fri Aug 25 16:09:36 2017

@author: John
"""
import adaboost
import numpy as np
import scipy.io as sio  
from sklearn import preprocessing
from sklearn.metrics import confusion_matrix  
from sklearn import metrics
from numpy import sign
import itertools
#载入数据
matfna='E:/工作汇报/代亚菲工作汇报45/train5.mat'  
matfnb='E:/工作汇报/代亚菲工作汇报45/test5.mat'  
dataa=sio.loadmat(matfna)  
datab=sio.loadmat(matfnb)  
load_matrixa = dataa['train5']
load_matrixb = datab['test5']
#数据预处理
result=[]
evaluate_test=[];
score=[]
label=[]
for i in range(1,11):
 x_train=load_matrixa[30006*(i-1):30006*i,0:54]
 min_max_scaler = preprocessing.MinMaxScaler()
 x_train_minmax = min_max_scaler.fit_transform(x_train)
 x_test=load_matrixb[1908*(i-1):1908*i,0:54]
 x_test_minmax = min_max_scaler.transform(x_test)
 y_train=load_matrixa[30006*(i-1):30006*i,54]
 y_test=load_matrixb[1908*(i-1):1908*i,54]

 dataArr=x_train_minmax
 labelArr=y_train
 dataBrr=x_test_minmax
 labelBrr=y_test

 for iii in range(len(labelArr)):
     if labelArr[iii]==0:
         labelArr[iii]=-1;#adaboost只能区分-1和1的标签
 for ii in range(len(labelBrr)):
     if labelBrr[ii]==0:
         labelBrr[ii]=-1;#adaboost只能区分-1和1的标签

 train_in=dataArr.tolist()
 train_out=labelArr.tolist();

 test_in=dataBrr.tolist()
 test_out=labelBrr

 classifierArray,aggClassEst=adaboost.adaBoostTrainDS(train_in,train_out,50);            
# prediction_train=adaboost.adaClassify(train_in,classifierArray);#测试训练集
 prob=adaboost.adaClassify(test_in,classifierArray);#测试测试集
 y_pred=sign(prob)
 score.append(prob)
 label.append(y_pred)

# tmp_test=adaboost.evaluatemodel(test_out,y_pred);
# evaluate_test.extend(tmp_test);
# evaluate_test=np.array(evaluate_test);
#混淆矩阵参数

 tn, fp, fn, tp = confusion_matrix(test_out,y_pred).ravel()
 TPR=tp/(tp+fn);
 SPC=tn/(fp+tn);
 PPV=tp/(tp+fp);
 NPV=tn/(tn+fn);
 ACC=(tp+tn)/(tn+fp+fn+tp)
 Fscore=2*TPR*PPV/(TPR+PPV)
 test_auc = metrics.roc_auc_score(test_out,prob)
 resul=[TPR,SPC,PPV,NPV,ACC,Fscore,test_auc]
 result.append(resul)
A=np.array(result)
outscore = list(itertools.chain.from_iterable(score))
outlabel = list(itertools.chain.from_iterable(label))
m1 = np.array(outscore)
m2 = np.array(outlabel)

