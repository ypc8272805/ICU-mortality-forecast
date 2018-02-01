NRIcalculate=function(m1="dia1",m2="dia2",gold="gold"){
  
  datanri=datanri[complete.cases(datanri),];
  
  for (i in 1:length(names(datanri))){
    
    if (names(datanri)[i]==m1)nm1=as.numeric(i);
    
    if (names(datanri)[i]==m2)nm2=as.numeric(i);
    
    if(names(datanri)[i]==gold)ngold=as.numeric(i);
    
  };
  
  if(names(table(datanri[,nm1]))[1]!="0" ||
     
     names(table(datanri[,nm1]))[2]!="1")stop("指标1诊断值不�?0�?1");
  
  if(names(table(datanri[,nm2]))[1]!="0" ||
     
     names(table(datanri[,nm2]))[2]!="1")stop("指标2诊断值不�?0�?1");
  
  if(names(table(datanri[,ngold]))[1]!="0" ||
     
     names(table(datanri[,ngold]))[2]!="1")stop("金标准诊断值不�?0�?1");
  
  datanri1=datanri[datanri[,ngold]==1,]
  
  table1=table(datanri1[,nm1],datanri1[,nm2]);
  
  datanri2=datanri[datanri[,ngold]==0,]
  
  table2=table(datanri2[,nm1],datanri2[,nm2]);
  
  
  
  p1=as.numeric(table1[2,1]/table(datanri[,ngold])[2]);
  
  p2=as.numeric(table1[1,2]/table(datanri[,ngold])[2]);
  
  p3=as.numeric(table2[2,1]/table(datanri[,ngold])[1]);
  
  p4=as.numeric(table2[1,2]/table(datanri[,ngold])[1]);
  
  NRI=round(p1-p2-p3+p4,3);
  
  z=NRI/sqrt((p1+p2)/table(datanri[,ngold])[2]+(p3+p4)/table(datanri[,ngold])[1]);
  
  z=round(as.numeric(z),3);
  
  pvalue=round((1-pnorm(abs(z)))*2,3);
  
  if(pvalue<0.001)pvalue="<0.001";
  
  result=paste("NRI=",NRI,",z=",z,",p=",pvalue,sep= "");
  
  return(result)
  
}



IDIcalculate=function(m1="v1",m2="v2",gold="gold"){
  
  dataidi= dataidi [complete.cases(dataidi),];
  
  for (i in 1:length(names(dataidi))){
    
    if(names(dataidi)[i]==m1)nm1=as.numeric(i);
    
    if(names(dataidi)[i]==m2)nm2=as.numeric(i);
    
    if(names(dataidi)[i]==gold)ngold=as.numeric(i);
    
  };
  
  if(names(table(dataidi[,ngold]))[1]!="0" ||
     
     names(table(dataidi[,ngold]))[2]!="1")stop("金标准诊断值不�?0�?1");
  
  logit1=glm(dataidi[,ngold]~dataidi[,nm1],family=binomial(link='logit'),data=dataidi)
  
  dataidi$pre1=logit1$fitted.values;
  
  logit2=glm(dataidi[,ngold]~dataidi[,nm2],family=binomial(link='logit'),data=dataidi)
  
  dataidi$pre2=logit2$fitted.values;
  
  dataidi$predif=dataidi$pre1-dataidi$pre2;
  
  
  
  dataidi1=dataidi[dataidi[,ngold]==1,];
  
  dataidi2=dataidi[dataidi[,ngold]==0,];
  
  
  
  p1=mean(dataidi1$pre1);
  
  p2=mean(dataidi1$pre2);
  
  p3=mean(dataidi2$pre1);
  
  p4=mean(dataidi2$pre2);
  
  IDI=round(p1-p2-p3+p4,3);
  
  z=IDI/sqrt(sd(dataidi1$predif)/length(dataidi1$predif)+sd(dataidi2$predif)/length(dataidi2$predif));
  
  z=round(as.numeric(z),3);
  
  pvalue=round((1-pnorm(abs(z)))*2,3);
  
  if(pvalue<0.001)pvalue="<0.001";
  
  result=paste("IDI=",IDI,",z=",z,",p=",pvalue,sep= "");
  ll<-c(IDI,z,pvalue)
  
  return(result)
  
}



dataid<-read.table("E:/工作汇报/代亚菲工作汇�?47/aa.csv",header=TRUE,sep=",")
a1<-dataid[1:1908,1:3]
a2<-dataid[1909:3816,1:3]
a3<-dataid[3817:5724,1:3]
a4<-dataid[5725:7632,1:3]
a5<-dataid[7633:9540,1:3]
a6<-dataid[9541:11448,1:3]
a7<-dataid[11449:13356,1:3]
a8<-dataid[13357:15264,1:3]
a9<-dataid[15265:17172,1:3]
a10<-dataid[17173:19080,1:3]



for(i in list(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10))
{
  dataidi=i
  idi<-IDIcalculate(m1="v1",m2="v2",gold="gold")
  print(idi)
  datanri=i
  nri<-NRIcalculate(m1="v1",m2="v2",gold="gold")
  print(nri)
}
