function [fea]=mRMR(aaz,IHD)
%求mRMR标准得分
load hutezheng;
aa=hutezheng';
ak=34;
for ii=1:4000
   xa=aaz(ii,:);
   xa(xa==0)=[];
   xb(ii)=mean(xa);
end
xc=find(isnan(xb)==1);
IHDD=IHD;
IHDD(xc)=[];
xd=xb(~isnan(xb)); 

fea1=mutualinfo(xd, IHDD);
for k=1:34
fea2(k)=mutualinfo(aa(:,ak), aa(:,k));
end
fea2(ak)=[];
fea3=fea1-fea2;
fea=abs(max(fea3));
end