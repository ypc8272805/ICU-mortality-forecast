library(caret)
data1<-read.table("C:/Users/zg/Desktop/bb.csv",header=TRUE,sep=",")
mdrrDescr<-data1[,1:54]
mdrrClass<-data1[,55]
zerovar <- nearZeroVar(mdrrDescr)
newdata1 <- mdrrDescr
descrCorr <- cor(newdata1)
highCorr <- findCorrelation(descrCorr, 0.90)
newdata2 <- newdata1[, -highCorr]
Process <- preProcess(newdata2)
newdata3 <- predict(Process, newdata2)
data.filter <- sbf(newdata3,mdrrClass,
                   sbfControl = sbfControl(functions=rfSBF,
                                           verbose=F,
                                           method='cv'))
x <- newdata3[data.filter$optVariables]
profile <- rfe(x,mdrrClass,
               sizes = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30),
               rfeControl = rfeControl(functions=rfFuncs
                                       ,method='cv'))
plot(profile,type=c('o','g'))
