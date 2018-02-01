clc
clear

load test4
xinfinalz=test4;
I=length(xinfinalz);
for i=1:I
hr=xinfinalz(i,19);
    if hr<40
        hrscore=2;
    elseif hr>=40 & hr<=50
        hrscore=1;
    elseif hr>=51 & hr<=100
        hrscore=0;
    elseif hr>=101 & hr<=110
        hrscore=1;
    elseif hr>111 & hr<=130
        hrscore=2;
    else
        hrscore=3;
    end
resp=xinfinalz(i,25);
    if resp<9
        respscore=2;
    elseif resp>=9 & resp<=14
        respscore=0;
    elseif resp>=15 & resp<=20
        respscore=1;
    elseif resp>=21 & resp<=29
        respscore=2;
    else
        respscore=3;
    end
gcs=xinfinalz(i,7);
    if gcs==15
        gcsscore=0;
    elseif gcs>=12 & gcs<=14
        gcsscore=1;
    elseif gcs>=9 & gcs<=11
        gcsscore=2;
    else
        gcsscore=3;
    end     
temp=xinfinalz(i,31);
    if temp<35
        tempscore=2;
    elseif temp>=35 & temp<=38.4
        tempscore=0;
    else
        tempscore=2;
    end  
sysabp=xinfinalz(i,43);
    if sysabp<70
        sysabpscore=3;
    elseif sysabp>=71 & sysabp<=80
        sysabpscore=2;
    elseif sysabp>=81 & sysabp<=100
        sysabpscore=1;
    elseif sysabp>=101 & sysabp<=199
        sysabpscore=0;
    else
        sysabpscore=2;
    end         
score=hrscore+respscore+gcsscore+tempscore+sysabpscore;
SAPS_SCORE=score;
md=3.27908902691511; 
st_d=1.89096903085869;
likelihood_saps_dying=normpdf(SAPS_SCORE,md,st_d);
parmhat =[2.97774211279244,1.78401044333353];
likelihood_saps_living=evpdf(SAPS_SCORE,parmhat(1),parmhat(2));
pdf_dying= 0.126;
posteriori_num=  (pdf_dying*likelihood_saps_dying);
posteriori_den=  (pdf_dying*likelihood_saps_dying + (1-pdf_dying)*likelihood_saps_living);
risk(i)=posteriori_num/posteriori_den;
end


% MX_SAPS=5;
% [Ndied,xx]=hist(saps_died,[0:MX_SAPS]);
% %bar(xx,Ndied);
% md=nanmean(saps_died);
% st_d=nanstd(saps_died);
% pdf_died=normpdf(xx,md,st_d);%正态分布概率密度函数
% plot(xx,Ndied./sum(Ndied));hold on;grid on;plot(xx,pdf_died,'r') %Check fit

% [Nalive,xx]=hist(saps_alive,[0:MX_SAPS]);
% parmhat = evfit(saps_alive(~isnan(saps_alive)));
% pdf_alive=evpdf(xx,parmhat(1),parmhat(2));
% figure
% plot(xx,Nalive./sum(Nalive));hold on;grid on;plot(xx,pdf_alive,'r')


