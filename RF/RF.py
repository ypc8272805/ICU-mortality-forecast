# -*- coding: utf-8 -*-
"""
Created on Fri Jan 12 09:26:48 2018

@author: zg
"""

import scipy.io as sio  
from sklearn.ensemble import RandomForestClassifier  
from sklearn import preprocessing
from sklearn.metrics import confusion_matrix  
from sklearn import metrics
from sklearn.metrics import roc_curve, auc
import matplotlib.pyplot as plt
import numpy as np
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


#简单的神经网络预测
 clf = RandomForestClassifier(n_estimators=100)  
 aam=clf.fit(x_train_minmax, y_train)
 y_pred=clf.predict(x_test_minmax)
 prob=clf.predict_proba(x_test_minmax)
 y_scor=prob[:,1:2]
 score.append(y_scor)
 label.append(y_pred)
#混淆矩阵参数
 tn, fp, fn, tp = confusion_matrix(y_test,y_pred).ravel()
 TPR=tp/(tp+fn);
 SPC=tn/(fp+tn);
 PPV=tp/(tp+fp);
 NPV=tn/(tn+fn);
 ACC=(tp+tn)/(tn+fp+fn+tp)
 Fscore=2*TPR*PPV/(TPR+PPV)
 test_auc = metrics.roc_auc_score(y_test,y_scor)
 resul=[TPR,SPC,PPV,NPV,ACC,Fscore,test_auc]
 result.append(resul)
A=np.array(result)
outscore = list(itertools.chain.from_iterable(score))
outlabel = list(itertools.chain.from_iterable(label))
m1 = np.array(outscore)
m2 = np.array(outlabel)