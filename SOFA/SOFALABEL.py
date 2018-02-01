# -*- coding: utf-8 -*-
"""
Created on Tue Jan  2 17:08:51 2018

@author: zg
"""
from sklearn.metrics import roc_curve, auc
import matplotlib.pyplot as plt
import scipy.io as sio  
import numpy as np
from sklearn.metrics import confusion_matrix  
from sklearn import metrics
import itertools
import copy

matfna='E:/工作汇报/代亚菲工作汇报45/score3.mat'  
dataa=sio.loadmat(matfna)  
load_matrixa = dataa['score3']

y_test=load_matrixa[:,6]
sofa=load_matrixa[:,7]

fpr, tpr, thresholds = roc_curve(y_test, sofa, pos_label=1)
roc_auc=(auc(fpr, tpr))

RightIndex=(tpr+(1-fpr)-1)
positon=np.argmax(RightIndex)
aw=int(positon)   
th=thresholds[aw]
result=[]
score=[]
label=[]

for i in range(1,11):
 y_scor=sofa[1908*(i-1):1908*i,]
 yb=y_test[1908*(i-1):1908*i,]
 ya=copy.deepcopy(y_scor)
 for iii in range(len(ya)):
     if ya[iii,]>=th:
         ya[iii,]=1;
     else:
         ya[iii,]=0; 

 y_pred=ya
 score.append(y_scor)
 label.append(y_pred)
#混淆矩阵参数
 tn, fp, fn, tp = confusion_matrix(yb,y_pred).ravel()
 TPR=tp/(tp+fn);
 SPC=tn/(fp+tn);
 PPV=tp/(tp+fp);
 NPV=tn/(tn+fn);
 ACC=(tp+tn)/(tn+fp+fn+tp)
 Fscore=2*TPR*PPV/(TPR+PPV)
 test_auc = metrics.roc_auc_score(yb,y_scor)
 resul=[TPR,SPC,PPV,NPV,ACC,Fscore,test_auc]
 result.append(resul)
A=np.array(result)
outscore = list(itertools.chain.from_iterable(score))
outlabel = list(itertools.chain.from_iterable(label))
m1 = np.array(outscore)
m2 = np.array(outlabel)

