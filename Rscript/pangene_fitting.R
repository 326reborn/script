library(ggplot2)
library(reshape2)
data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\pangenome\\Polyplastron.multivesiculatum.cov80_ide90_aS_pan.data",sep="\t",header=FALSE)
colnames(data)<- c("1","2","3","4","5","6","7","8","9")
data2<-melt(data,variable.name="samples",value.name = "genes")
data2<-transform(data2,group="up")
data2$samples<-as.numeric(data2$samples)
data2$genes<-as.numeric(data2$genes)
x<-data2$samples
y<-data2$genes
lrcnls_lm<-nls(y ~ k*(x+1)^r+m,start=list(k=23291,r=0.5,m=26295))#start的值应该与真实值相差不大，不然会报错“缺省值”
summary(lrcnls_lm)#拟合函数的常数项的解
ggplot(data2,aes(x=samples,y=genes,col=group,group=group))+geom_smooth(method='loess',size=0.01,col="black",fill="red")


#pan genefamily
library(ggplot2)
library(reshape2)
data_Iso<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\pangenome\\pan_genefamily\\Isotricha.jalaludinii.pan",sep="\t",header=FALSE)
colnames(data_Iso)<- c("1","2","3","4","5")
data_Iso2<-melt(data_Iso,variable.name="samples",value.name = "genes")
data_Iso2<-transform(data_Iso2,group="Isotricha.jalaludinii")
data_pm<- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\pangenome\\pan_genefamily\\Polyplastron.multivesiculatum.pan",sep="\t",header=FALSE)
colnames(data_pm)<- c("1","2","3","4","5","6","7")
data_pm2<-melt(data_pm,variable.name="samples",value.name = "genes")
data_pm2<-transform(data_pm2,group="Polyplastron.multivesiculatum")
data_Oph<- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\pangenome\\pan_genefamily\\Ophryoscolex.caudatus.pan",sep="\t",header=FALSE)
colnames(data_Oph)<- c("1","2","3","4","5","6")
data_Oph2<-melt(data_Oph,variable.name="samples",value.name = "genes")
data_Oph2<-transform(data_Oph2,group="Ophryoscolex.caudatus")
test_data<-rbind(data_Iso2,data_pm2,data_Oph2)
ggplot(test_data,aes(x=samples,y=genes,col=group,group=group,fill=group))+geom_smooth(method='loess',size=0.01)+ theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
