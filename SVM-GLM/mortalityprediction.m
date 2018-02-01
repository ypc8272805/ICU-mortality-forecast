function [risk,prediction]=mortalityprediction(tr,trout,tein,teout)

 tr1=tr(:,1);
 tr2=tr(:,2);
 tr3=tr(:,3);
 tr4=tr(:,4);
 tr5=tr(:,5);
 tr6=tr(:,6);
 tr7=tr(:,7);
 tr8=tr(:,8);

%训练
trainin=[tr1;tr2;tr3;tr4;tr5;tr6;tr7;tr8];
trainout=[trout;trout;trout;trout;trout;trout;trout;trout];
%训练支持向量机模型
model1=libsvmtrain(trout ,tr1,'-s 1 -t 1 -d 2 -g 0.02 -r 1 -n 0.52 -b 1');
model2=libsvmtrain(trout ,tr2,'-s 1 -t 1 -d 2 -g 0.05 -r 1 -n 0.52 -b 1');
model3=libsvmtrain(trout ,tr3,'-s 1 -t 1 -d 2 -g 0.126 -r 1 -n 0.52 -b 1');
model4=libsvmtrain(trout ,tr4,'-s 1 -t 1 -d 2 -g 0.126 -r 1 -n 0.58 -b 1');
model5=libsvmtrain(trout ,tr5,'-s 1 -t 1 -d 2 -g 0.05 -r 1 -n 0.58 -b 1');
model6=libsvmtrain(trout ,tr6,'-s 1 -t 1 -d 2 -g 0.02 -r 1 -n 0.56 -b 1');
model7=libsvmtrain(trout ,tr7,'-s 1 -t 1 -d 2 -g 0.05 -r 1 -n 0.56 -b 1');
model8=libsvmtrain(trout ,tr8,'-s 1 -t 1 -d 2 -g 0.126 -r 1 -n 0.56 -b 1');
%训练广义线性模型
[label1,accuracy1,prob_estimates1]=libsvmpredict(trainout, trainin, model1, '-b 1');
[label2,accuracy2,prob_estimates2]=libsvmpredict(trainout, trainin, model2, '-b 1');
[label3,accuracy3,prob_estimates3]=libsvmpredict(trainout, trainin, model3, '-b 1');
[label4,accuracy4,prob_estimates4]=libsvmpredict(trainout, trainin, model4, '-b 1');
[label5,accuracy5,prob_estimates5]=libsvmpredict(trainout, trainin, model5, '-b 1');
[label6,accuracy6,prob_estimates6]=libsvmpredict(trainout, trainin, model6, '-b 1');
[label7,accuracy7,prob_estimates7]=libsvmpredict(trainout, trainin, model7, '-b 1');
[label8,accuracy8,prob_estimates8]=libsvmpredict(trainout, trainin, model8, '-b 1');

N=length(trainin);
for i=1:N
    a1=prob_estimates1(i,2);
    a2=prob_estimates2(i,2);
    a3=prob_estimates3(i,2);
    a4=prob_estimates4(i,2);
    a5=prob_estimates5(i,2);
    a6=prob_estimates6(i,2);
    a7=prob_estimates7(i,2);
    a8=prob_estimates8(i,2);
    b=[a1,a2,a3,a4,a5,a6,a7,a8];
    a(i,1:8)=sort(b);
end
c=glmfit(a,trainout,'binomial','link','probit');
xrisk=glmval(c,a,'probit');
aa=xrisk(1:812);
xris=sort(xrisk,1,'descend');
%通过训练集得到阈值
IHD=trainout;
for TH=1:1:N
    th=TH/N;
DATA=xrisk>=th;
TP=sum(DATA(IHD==1,1));
FN=sum(~DATA(IHD==1,1));
FP=sum(DATA(IHD==0,1));  
Se(TH)=TP/(TP+FN);
PPV(TH)=TP/(TP+FP);
end
%TH=1:1:N;
% plot(Se,'r');
% hold on;
% plot(PPV,'b');
% hold on;
% plot(xris,'g');
% legend('Se','PPV','risk');
THc=0.4928;
%测试
[labe1,accurac1,prob_estimate1]=libsvmpredict(teout, tein, model1, '-b 1');
[labe2,accurac2,prob_estimate2]=libsvmpredict(teout, tein, model2, '-b 1');
[labe3,accurac3,prob_estimate3]=libsvmpredict(teout, tein, model3, '-b 1');
[labe4,accurac4,prob_estimate4]=libsvmpredict(teout, tein, model4, '-b 1');
[labe5,accurac5,prob_estimate5]=libsvmpredict(teout, tein, model5, '-b 1');
[labe6,accurac6,prob_estimate6]=libsvmpredict(teout, tein, model6, '-b 1');
[labe7,accurac7,prob_estimate7]=libsvmpredict(teout, tein, model7, '-b 1');
[labe8,accurac8,prob_estimate8]=libsvmpredict(teout, tein, model8, '-b 1');

n=length(tein);
for i=1:n
    b1=prob_estimate1(i,2);
    b2=prob_estimate2(i,2);
    b3=prob_estimate3(i,2);
    b4=prob_estimate4(i,2);
    b5=prob_estimate5(i,2);
    b6=prob_estimate6(i,2);
    b7=prob_estimate7(i,2);
    b8=prob_estimate8(i,2);
    d=[b1,b2,b3,b4,b5,b6,b7,b8];
    e(i,1:8)=sort(d);
end

risk=glmval(c,e,'probit');
prediction=risk>=THc;
end

