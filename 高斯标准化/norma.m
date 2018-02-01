function [xl, xu ,xm ,w1 ,w2 ,w3,z]=norma(aaz)
%该函数的功能是进行数据预处理，高斯标准化
%输入：
%     需处理的数据
%输出：
%     xl：由分位数法得到的变量最低有效值
%     xu：由分位数法得到的变量最高有效值
%     xm：当该变量未检测到值，根据imputation方法，以该值替代
%     w1、w2、w3，为新数据进行标准化需要的权值系数
%提取数据，对有效值排序
x=aaz;
x(x==0)=[]; 
xx=sort(x);
dxx=find(xx>0);
daxx=min(dxx);
xx=xx(daxx:length(xx));
%xx=log10(xx);
%设置分位数，得到有效的参数范围
N=length(xx);
for ii=1:N
    q(ii)=(ii-0.5)/N;
end
il=min(find(q>0.01));
iu=max(find(q<0.99));
xl=xx(il);
xu=xx(iu);
%根据公式得到标准化的权值
zhongx=xx(il:iu);
lzhongx=length(zhongx);
qii=q(il:iu);
for ix=1:N
    R(ix,1:3)=[1 xx(ix) log(1+xx(ix))];
end
miu=0;
sigma=1;
qcdf=normcdf(q,miu,sigma);
y=1./(3.*qcdf);
RT=R';
yT=y';
wa=inv(RT*R);
wb=RT*yT;
w=(wa*wb)';
%对有效参数进行标准化，查看图形与参数验证
z=w(1,1)+w(1,2).*zhongx+w(1,3).*log(1+zhongx);
z=mapminmax(z,-1,1);

%得到标准化表的系数，参数有效范围、替代值与权值
w1=w(1,1);
w2=w(1,2);
w3=w(1,3);
xm=mean(z);
a=[xl, xu ,xm ,w1 ,w2 ,w3];
end







