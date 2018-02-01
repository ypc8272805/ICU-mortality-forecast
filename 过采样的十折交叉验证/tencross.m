clc
clear
load xinfinalz2
xinfinalz=xinfinalz2;
a=find(xinfinalz(:,56)==0);
b=find(xinfinalz(:,56)==1);
cunN=xinfinalz(a,2:55);
siN=xinfinalz(b,2:55);
cun=cunN(1:16630,:);
si=siN(1:2400,:);

scrossnum=10;
sindices = crossvalind('Kfold',2400,scrossnum);
cindices = crossvalind('Kfold',16630,scrossnum);

for i=1:10
    stest = (sindices == i); 
    sitest=si(stest,:);
    strain = ~stest;
    sitrain=si(strain,:);
    
    ctest=(cindices==i);
    cuntest=cun(ctest,:);
    ctrain=~ctest;
    cuntrain=cun(ctrain,:);
    
    for iuo=1:9
      index_randb=randperm(2160); 
       for io=1:1663
          x_trainns(io,:)=sitrain(index_randb(io),:);
       end
       x_trains((1+1663*(iuo-1)):1663*iuo,:)=x_trainns;
    end
    
x_train((1+29934*(i-1)):29934*i,1:54)=[cuntrain;x_trains];
t_train((1+29934*(i-1)):29934*i,1)=[zeros(14967,1);ones(14967,1)];
x_test((1+1903*(i-1)):1903*i,1:54)=[cuntest;sitest];
t_test((1+1903*(i-1)):1903*i,1)=[zeros(1663,1);ones(240,1)];
end

train=[x_train,t_train];
test=[x_test,t_test];
