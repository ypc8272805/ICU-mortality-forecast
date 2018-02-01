library(mice)
data<-read.table("C:/Users/zg/Desktop/nibp.csv",header=TRUE,sep=",")
data1<-data[,c(14,32)]
imp<-mice(data1,m=2,method='norm.predict')
fit<-with(imp,lm(qnimeanbp_min~qmeanbp_min))
pooled<-pool(fit)
summary(pooled)
aa<-complete(imp,action=1)


data2<-data[,c(15,33)]
imp<-mice(data2,m=2,method='norm.predict')
fit<-with(imp,lm(qnimeanbp_max~qmeanbp_max))
pooled<-pool(fit)
summary(pooled)
bb<-complete(imp,action=1)

data3<-data[,c(16,34)]
imp<-mice(data3,m=2,method='norm.predict')
fit<-with(imp,lm(qnimeanbp_mean~qmeanbp_mean))
pooled<-pool(fit)
summary(pooled)
cc<-complete(imp,action=1)

data4<-data[,c(17,35)]
imp<-mice(data4,m=2,method='norm.predict')
fit<-with(imp,lm(hnimeanbp_min~hmeanbp_min))
pooled<-pool(fit)
summary(pooled)
dd<-complete(imp,action=1)

data5<-data[,c(18,36)]
imp<-mice(data5,m=2,method='norm.predict')
fit<-with(imp,lm(hnimeanbp_max~hmeanbp_max))
pooled<-pool(fit)
summary(pooled)
ee<-complete(imp,action=1)

data6<-data[,c(19,37)]
imp<-mice(data6,m=2,method='norm.predict')
fit<-with(imp,lm(hnimeanbp_mean~hmeanbp_mean))
pooled<-pool(fit)
summary(pooled)
ff<-complete(imp,action=1)

aaa<-cbind(aa[,2],bb[,2],cc[,2],dd[,2],ee[,2],ff[,2])
write.csv(aaa,file="C:/Users/zg/Desktop/mi3.csv",quote=T,row.names=T)

