clc
clear
load sofa

%aa=find(sofa(:,3)==0);
score=sofa(:,2);

for i=1:19093
SAPS_SCORE=score(i);
md=6.57888198757764; 
st_d=4.09380090803572;
likelihood_saps_dying=normpdf(SAPS_SCORE,md,st_d);
parmhat =[4.65904527969075,3.36065013172164];
likelihood_saps_living=evpdf(SAPS_SCORE,parmhat(1),parmhat(2));
pdf_dying= 0.126;
posteriori_num=  (pdf_dying*likelihood_saps_dying);
posteriori_den=  (pdf_dying*likelihood_saps_dying + (1-pdf_dying)*likelihood_saps_living);
risk(i)=posteriori_num/posteriori_den;
end

% saps_alive=score;
% MX_SAPS=13;
% [Ndied,xx]=hist(saps_died,[0:MX_SAPS]);
% md=nanmean(saps_died);
% st_d=nanstd(saps_died);
% pdf_died=normpdf(xx,md,st_d);%正态分布概率密度函数
% plot(xx,Ndied./sum(Ndied));hold on;grid on;plot(xx,pdf_died,'r') 

% [Nalive,xx]=hist(saps_alive,[0:MX_SAPS]);
% parmhat = evfit(saps_alive(~isnan(saps_alive)));
% pdf_alive=evpdf(xx,parmhat(1),parmhat(2));
% figure
% plot(xx,Nalive./sum(Nalive));hold on;grid on;plot(xx,pdf_alive,'r')



