function [tezhengji]=extractfeature(tm,category,val)
load norgai;

vari={{'Age'},{'Gender'},{'Height'},{'ICUType'},{'Albumin'},...
    {'HCT'},{'PaCO2'},{'ALP'},{'HR'},{'PaO2'},{'ALT'},{'K'},...
    {'pH'},{'AST'},{'Lactate'},{'Platelets'},{'Bilirubin'},...
    {'Mg'},{'MAP'},{'RespRate'},{'BUN'},{'SaO2'},{'Cholesterol'},...
    {'SysABP'},{'Creatinine'},{'Na'},{'DiasABP'},{'NIDiasABP'},...
    {'Temp'},{'FiO2'},{'NIMAP'},{'Urine'},{'GCS'},{'NISysABP'},...
    {'WBC'},{'Glucose'},{'Weight'},{'HCO3'}};
%将48小时分为前24小时与后24小时两部分
tm=cell2mat(tm);%多个矩阵构成的元胞数组合成为一个矩阵
afr_data=find(str2num(tm(:,1:2))<24);
aval=val(afr_data);
atm=tm(afr_data);
acategory=category(afr_data);
bfr_data=find(str2num(tm(:,1:2))>=24);
bval=val(bfr_data);
btm=tm(bfr_data);
bcategory=category(bfr_data);
%提取出前24小时变量中所有变量的顺序检测值   
for as=1:length(vari)
    asaps_var=vari{as};%依次提取变量名称
    asig_ind= aval.*0;
    for ia=1:length(asaps_var)
        asig_ind=asig_ind | strcmp(asaps_var(ia),acategory);
    end
    al=find(asig_ind==1);
    all(as)=length(al);
    atmp_data(as,1:all(as))=aval(asig_ind);
end
%特殊值的处理,年龄，性别，身高，ICU类型,直接作为特征值
age=atmp_data(1,:);
age(age==0)=[];
if isempty(age)
   age=randi([10 90]);
end  
age=0.4*(age-10)/80 + 0.3; 
gender=atmp_data(2,1); 
gender=0.4*(gender-0)/1 + 0.3; 
height=atmp_data(3,:);
height(height==0)=[];
if isempty(height)||height==-1||height>200||height<50
   height=randi([80 200]);
end  
height=0.4*(height-80)/120 + 0.3; 
icutype=atmp_data(4,:);
icutype(icutype==0)=[];
if isempty(icutype)
   icutype=randi([1 4]);
end  
 icutype=0.4*( icutype-1)/3 + 0.3; 
%提取出后24小时变量中所有变量的顺序检测值
for bs=1:length(vari)
    bsaps_var=vari{bs};%依次提取变量名称
    bsig_ind= bval.*0;
    for ib=1:length(bsaps_var)
        bsig_ind=bsig_ind | strcmp(bsaps_var(ia),bcategory);
    end
    bl=find(bsig_ind==1);
    bll(bs)=length(bl);
    btmp_data(bs,1:bll(bs))=bval(bsig_ind);
end
%求出尿量和，直接作为特征值
qurine=sum(atmp_data(32,:));
hurine=sum(btmp_data(32,:));
qurine=0.4*( qurine-0)/10000 + 0.3; 
hurine=0.4*( hurine-0)/10000 + 0.3; 
%ALT、AST、Lactate、Plateletes、BUN、Urine取对数
atmp_data(11,:)=log10(atmp_data(11,:));
atmp_data(14,:)=log10(atmp_data(14,:));
atmp_data(15,:)=log10(atmp_data(15,:));
atmp_data(16,:)=log10(atmp_data(16,:));
atmp_data(21,:)=log10(atmp_data(21,:));
atmp_data(32,:)=log10(atmp_data(32,:));
%ALT、AST、Lactate、Plateletes、BUN、Urine取对数
btmp_data(11,:)=log10(btmp_data(11,:));
btmp_data(14,:)=log10(btmp_data(14,:));
btmp_data(15,:)=log10(btmp_data(15,:));
btmp_data(16,:)=log10(btmp_data(16,:));
btmp_data(21,:)=log10(btmp_data(21,:));
btmp_data(32,:)=log10(btmp_data(32,:));
%循环得34个时间序列标准值,标准化后得到最大，最小，平均值
for i=1:34
qalbumin=atmp_data(i+4,:);
qalbumin(qalbumin==0)=[];
qalbumin=sort(qalbumin);
halbumin=btmp_data(i+4,:);
halbumin(halbumin==0)=[];
halbumin=sort(halbumin);

aqalbumin=qalbumin(min(find(qalbumin>norgai(i,1))):max(find(qalbumin<norgai(i,2))));
aaqalbumin=norgai(i,4)+norgai(i,5).*aqalbumin+norgai(i,6).*log(1+aqalbumin);

ahalbumin=halbumin(min(find(halbumin>norgai(i,1))):max(find(halbumin<norgai(i,2))));
aahalbumin=norgai(i,4)+norgai(i,5).*ahalbumin+norgai(i,6).*log(1+ahalbumin);


a=isempty(aaqalbumin);
b=isempty(aahalbumin);
if a==1 && b==0
    aa=max(aahalbumin);
    dd=max(aahalbumin);
    bb=min(aahalbumin);
    ee=min(aahalbumin);
    cc=mean(aahalbumin);
    ff=mean(aahalbumin);
elseif a==0 && b==1
    aa=max(aaqalbumin);
    dd=max(aaqalbumin);
    bb=min(aaqalbumin);
    ee=min(aaqalbumin);
    cc=mean(aaqalbumin);
    ff=mean(aaqalbumin);
elseif a==0 && b==0
    aa=max(aaqalbumin);
    dd=max(aahalbumin);
    bb=min(aaqalbumin);
    ee=min(aahalbumin);
    cc=mean(aaqalbumin);
    ff=mean(aahalbumin);
elseif a==1 && b==1
    aa=norgai(i,3);
    bb=norgai(i,3);
    cc=norgai(i,3);
    dd=norgai(i,3);
    ee=norgai(i,3);
    ff=norgai(i,3);
end 

albumin(i,1:6)=[aa,bb,cc,dd,ee,ff];

end
albumin=albumin';
aalbumin=albumin(:);
tezhengji=[age;gender;height;icutype;qurine;hurine;aalbumin];
end
