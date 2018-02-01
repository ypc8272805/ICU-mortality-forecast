function[correlation]=corre(aaz,IHD)
%求correlation标准得分
for ii=1:6341
   xa=aaz(ii,:);
   xa(xa==0)=[];
   xb(ii)=mean(xa);
end
xc=find(isnan(xb)==1);
IHDD=IHD;
IHDD(xc)=[];
xd=xb(~isnan(xb)); 
xu=mean(xd);
yu=mean(IHDD);
for ib=1:length(xd)
    xnu(ib)=(xd(ib)-xu)*(IHDD(ib)-yu);
    xde(ib)=(xd(ib)-xu)^2;
    yde(ib)=(IHDD(ib)-yu)^2;
end
xnum=sum(xnu);
xdee=sum(xde);
ydee=sum(yde);
xden=sqrt(xdee*ydee);
correlation=abs(xnum/xden);
end