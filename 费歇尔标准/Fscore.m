function[Fisher]=Fscore(aaz,IHD)
%求Fisher标准得分
for ii=1:6341
   xa=aaz(ii,:);
   xa(xa==0)=[];
   xb(ii)=mean(xa);
end
xc=find(isnan(xb)==1);
IHDD=IHD;
IHDD(xc)=[];
xd=xb(~isnan(xb)); 

xsi=find(IHDD==1);
xcun=find(IHDD==0);
xd1=xd(xsi);
xdd1=mean(xd1);
xd0=xd(xcun);
xdd0=mean(xd0);
xme=mean(xd);
mu1=(xdd1-xme)^2;
mu2=(xdd0-xme)^2;
xnum=mu1+mu2;
for ia=1:length(xsi)
    xnua(ia)=(xd1(ia)-xdd1)^2;
end
xnuaa=sum(xnua);
mu3=xnuaa/(length(xsi)-1);
for ib=1:length(xcun)
    xnub(ib)=(xd0(ib)-xdd0)^2;
end
xnubb=sum(xnub);
mu4=xnubb/(length(xcun)-1);
xden=mu3+mu4;
Fisher=abs(xnum/xden);
end