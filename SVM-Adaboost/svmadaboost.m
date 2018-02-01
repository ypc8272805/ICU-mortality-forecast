clc
clear

load x_trainj
load t_trainj
load x_testj
load t_testj
il=1;
x_traina=x_trainj((1+9684*(il-1)):9684*il,1:30);
t_traina=t_trainj((1+9684*(il-1)):9684*il,1);
x_testa=x_testj((1+633*(il-1)):633*il,1:30);
t_testa=t_testj((1+633*(il-1)):633*il,1);

input_train=x_traina;
output_train=t_traina;
input_test=x_testa;
output_test=t_testa;
output_train(output_train==0)=-1;
output_test(output_test==0)=-1;

[mm,nn]=size(input_train);
D(1,:)=ones(1,mm)/mm;
% [a,b]=mapminmax(input_train');
k=5;%弱分类器数量
for i=1:k
    error(i)=0;

    [bestacc,bestc,bestg] = SVMcg(output_train,input_train,-10,10,-10,10);
    cmd=[' -c ',num2str(bestc),' -g ',num2str(bestg)];
    model1=libsvmtrain(output_train ,input_train,cmd);
    [test_simu1(:,i)]=libsvmpredict(output_train , input_train, model1);
    [test_simu(:,i)]=libsvmpredict(output_test, input_test, model1);

    %统计错误样本数
    for j=1:mm
        if test_simu1(j,i)~=output_train(j);
            error(i)=error(i)+D(i,j);
        end
    end
    %弱分类器i权重
    at(i)=0.5*log((1-error(i))/error(i));
    %更新D值
    outtrain=output_train';
    for j=1:mm
        D(i+1,j)=D(i,j)*exp(-at(i)*outtrain(j)*test_simu1(j,i));%最后的是训练数据输出
    end
    %D值归一化
    Dsum=sum(D(i+1,:));
    D(i+1,:)=D(i+1,:)/Dsum;
end
%由弱分类器组成的强分类器对测试样本进行分类
%     test_simu(test_simu==0)=-1;
%     test_simu1(test_simu1==0)=-1;
for q=1:k
    ww(:,q)=at(1,q)*test_simu(:,q);
    www(:,q)=at(1,q)*test_simu1(:,q);
end
boutput=sign(sum(ww,2));
aoutput=sign(sum(www,2));
aDATAc=aoutput;
aDATAc(aDATAc==-1)=0;
aIHDc=output_train;
aIHDc(aIHDc==-1)=0;
aTPc=sum(aDATAc(aIHDc==1,1));
aFNc=sum(~aDATAc(aIHDc==1,1));
aFPc=sum(aDATAc(aIHDc==0,1));  
aTNc=sum(~aDATAc(aIHDc==0,1));  
aSec(il)=aTPc/(aTPc+aFNc);
ateyixing(il)=aTNc/(aTNc+aFPc);
azhunq(il)=(aTPc+aTNc)/(aTPc+aFNc+aFPc+aTNc);

bDATAc=boutput;
bDATAc(bDATAc==-1)=0;
bIHDc=output_test;
bIHDc(bIHDc==-1)=0;
bTPc=sum(bDATAc(bIHDc==1,1));
bFNc=sum(~bDATAc(bIHDc==1,1));
bFPc=sum(bDATAc(bIHDc==0,1));  
bTNc=sum(~bDATAc(bIHDc==0,1));  
bSec(il)=bTPc/(bTPc+bFNc);
bteyixing(il)=bTNc/(bTNc+bFPc);
bzhunq(il)=(bTPc+bTNc)/(bTPc+bFNc+bFPc+bTNc);
%end
AA=[aSec',ateyixing',azhunq',bSec',bteyixing',bzhunq'];

