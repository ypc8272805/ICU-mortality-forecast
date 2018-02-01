clc
clear

load bingli
load inicutime

N=length(bingli);
for i=1:N
conn=database('PostgreSQL30','postgres','0');%连接数据库    
sql=strcat('SELECT cha.subject_id,cha.itemid,cha.charttime,cha.valuenum FROM mimiciii.chartevents cha where cha.subject_id=',num2str(bingli(i,1)),' and  cha.itemid in (select itemid from mimiciii.var)');
curs = exec(conn,sql);
curs = fetch(curs);
averia = curs.Data; 
nodata=length(averia);
if nodata==1
    continue;
end
[m,n]=size(averia);
a=averia(1:m,2:n);

aadata=a(:,2);
bbdata=a(:,1);
ccdata=a(:,3);

tim=inicutime{i,1};
NN=length(aadata);
chay=zeros(1,NN); 
shicha=zeros(1,NN); 

for ik=1:NN
tic=aadata{ik,1};
shicha(ik)=(datenum(tic)-datenum(tim));
if shicha(ik)<1
    chay(ik)=1;
else
    chay(ik)=0;
end
end

%提取前24小时的变量值
shicha=shicha';
achay=find(chay==1);
zhi=cell2mat(ccdata);
leixing=cell2mat(bbdata);
ashicha=shicha(achay);
aleixing=leixing(achay);
azhi=zhi(achay);

kzhi=isnan(azhi);
bchay=find(kzhi==0);
c=[ashicha(bchay),aleixing(bchay),azhi(bchay)];
eval(['save '  num2str(bingli(i,1)), ' c ']);
close(conn);
end




