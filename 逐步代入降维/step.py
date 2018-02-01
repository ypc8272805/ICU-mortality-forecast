# -*- coding: utf-8 -*-
"""
Created on Thu Dec 21 09:10:47 2017

@author: zg
"""
import scipy.io as sio  
from sklearn import svm
from sklearn import preprocessing
from sklearn.metrics import confusion_matrix  
from sklearn import metrics
from sklearn.metrics import roc_curve, auc
import matplotlib.pyplot as plt
import numpy as np

#载入数据
matfna='E:/工作汇报/代亚菲工作汇报45/trainj1.mat'  
matfnb='E:/工作汇报/代亚菲工作汇报45/testj1.mat'  
dataa=sio.loadmat(matfna)  
datab=sio.loadmat(matfnb)  
load_matrixa = dataa['trainj1']
load_matrixb = datab['testj1']
#数据预处理
B=[]
C=[]
for j in range(1,29):  
 result=[]
 for i in range(1,11):
  x_train=load_matrixa[30006*(i-1):30006*i,0:j]
  min_max_scaler = preprocessing.MinMaxScaler()
  x_train_minmax = min_max_scaler.fit_transform(x_train)
  x_test=load_matrixb[1908*(i-1):1908*i,0:j]
  x_test_minmax = min_max_scaler.transform(x_test)
  y_train=load_matrixa[30006*(i-1):30006*i,28]
  y_test=load_matrixb[1908*(i-1):1908*i,28]
#这里使用支持向量机作为预测模型
  clf=svm.SVC(C=0.1, kernel='linear', decision_function_shape='ovr',probability=True)

  aam=clf.fit(x_train_minmax, y_train)
  y_pred=clf.predict(x_test_minmax)
  prob=clf.predict_proba(x_test_minmax)
  y_scor=prob[:,1:2]
#查看AUROC值选择最佳变量个数
  tn, fp, fn, tp = confusion_matrix(y_test,y_pred).ravel()
  test_auc = metrics.roc_auc_score(y_test,y_scor)
  resul=[test_auc]
  result.append(resul)
 A=np.array(result)
 B=np.mean(A, axis=0)
 C.append(B)
