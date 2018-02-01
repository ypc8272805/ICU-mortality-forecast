function [az,laz]=tiqudata(time,para,value)
%该函数的功能是提取一个病例中想要得到的变量
%输入：
%     time：变量检测的时间，可根据需要设置
%     para：变量名称
%     value：变量数值
%输出：
%     az：想要提取的变量数组
%     laz：提取的变量数组的长度

vari={{'Height'},...
    {'HCT'},{'PaCO2'},{'ALP'},{'HR'},{'PaO2'},{'ALT'},{'K'},...
    {'pH'},{'AST'},{'Lactate'},{'Platelets'},{'Bilirubin'},...
    {'Mg'},{'MAP'},{'RespRate'},{'BUN'},{'SaO2'},{'Cholesterol'},...
    {'SysABP'},{'Creatinine'},{'Na'},{'DiasABP'},{'NIDiasABP'},...
    {'Temp'},{'FiO2'},{'NIMAP'},{'Urine'},{'GCS'},{'NISysABP'},...
    {'WBC'},{'Glucose'},{'Weight'},{'HCO3'}};

for as=1:length(vari)
    asaps_var=vari{as};%依次提取变量名称
    asig_ind= value.*0;
    for ia=1:length(asaps_var)
        asig_ind=asig_ind | strcmp(asaps_var(ia),para);
    end
    al=find(asig_ind==1);
    all(as)=length(al);
    atmp_data(as,1:all(as))=value(asig_ind);%提取出所有变量的顺序检测值   
end
%根据vari中的变量次序设定数值提取出该变量
az=atmp_data(1,:);
laz=length(az);

end



