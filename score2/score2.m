function [H]=lemeshow(data,show)
D=10; 
N=length(data(:,1));
M=floor(N/D); 
data=sortrows(data,2); 
CM=zeros(D,3)+NaN;
centroid=zeros(D-1,1)+NaN;
cstd=zeros(D-1,1)+NaN;
for i=1:D
    ind2=i*M;     
    ind1=ind2-M+1; 
    Obs=sum([data(ind1:ind2,1)]);
    centroid(i)=mean(data(ind1:ind2,2)); 
    cstd(i)=std(data(ind1:ind2,2));
    Exp=M*centroid(i); 
    Expp(i)=M* cstd(i);
    Htemp=(Obs-Exp)^2/(M*centroid(i)*(1-centroid(i)) + 0.001);
    CM(i,:)=[Obs Exp Htemp];
end

H=sum(CM(:,3))/(centroid(10)-centroid(1));

if(show)
    plot(centroid,CM(:,1),'bo','MarkerSize',10)
    grid on;xlim([0 1]);hold on
    errorbar(centroid,CM(:,2),Expp,'rx','MarkerSize',10)
    %plot(centroid,CM(:,2),'rx','MarkerSize',10)
    xlabel('Predicted Risk')
    ylabel('Number of Deaths')
    legend('Observed','Predicted')
end