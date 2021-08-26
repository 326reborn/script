library(reshape2,ggplot2)
data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\classify\\end.report",sep="\t",header=FALSE)
colnames(data)<- c("sample","BFAP","mags","rumen_ciliate")
data2 <- melt(data,id.vars=c("sample"),variable.name="database",value.name="percentage")
ggplot(data2, aes(y=database, x=percentage, fill=database,color=database))+geom_boxplot(alpha=0.2,outlier.size = 0,size=0.7,width=0.5)+geom_jitter(width=0.17,height=0.17,size=0.2,alpha=0.7)+scale_x_continuous(breaks=seq(0, 100, 10))+theme(legend.margin = margin(10,10,50,10),legend.position="none")+labs(y="database", x="classification rate (%)")

#species_change分面图
data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\classify\\five_study_species.txt",sep="\t",header=TRUE)
data2 <- melt(data,id.vars=c("dataset"),variable.name="species",value.name="percentage")
data2$dataset<-factor(data2$dataset,levels=c('(Shi et al., 2014)','(Stewart et al., 2019)','(Xue et al., 2020)','(Shen et al., 2020)','This study'))
data2$species<-factor(data2$species,levels=c('Bacteria','Archaea','Viruses','Fungi'))
ggplot(data2,aes(x=percentage,y=species,fill=species))+geom_boxplot(alpha=0.5,outlier.shape = NA,size=0.2,width=0.5)+facet_grid(dataset ~ .,switch = "y")+geom_jitter(width=0,height=0.17,size=1,alpha=1,aes(colour=species))+scale_x_continuous(breaks=seq(0, 80, 20))+ theme_bw() + theme(legend.position="none",panel.border = element_blank(), axis.line = element_line(colour = "black"),panel.grid.minor =element_blank(),panel.grid.major.y = element_blank(),axis.title.x = element_text(size = 15),axis.text.x = element_text(size = 15),axis.text.y = element_text(size = 15))+labs(x="Corrected classification rate (%)")

#dataset_change分面图
data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\classify\\dataset_change.txt",sep="\t",header=TRUE)
data2 <- melt(data,id.vars=c("dataset"),variable.name="database",value.name="percentage")
data2$dataset<-factor(data2$dataset,levels=c('(Shi et al., 2014)','(Stewart et al., 2019)','(Xue et al., 2020)','(Shen et al., 2020)','This study'))
ggplot(data2,aes(x=percentage,y=database,fill=database))+geom_boxplot(alpha=0.5,outlier.shape = NA,size=0.2,width=0.5)+facet_grid(dataset ~ .,switch = "y")+geom_jitter(width=0,height=0.17,size=1,alpha=1,aes(colour=database))+scale_x_continuous(breaks=seq(0, 80, 20))+ theme_bw() + theme(legend.position="none",panel.border = element_blank(), axis.line = element_line(colour = "black"),panel.grid.minor =element_blank(),panel.grid.major.y = element_blank(),axis.title.x = element_text(size = 15),axis.text.x = element_text(size = 15),axis.text.y = element_text(size = 15))+labs(x="Classification rate (%)")

#Trichostomatia_boxplot(major)
data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\classify\\Trichostomatia.txt",sep="\t",header=TRUE)
data2<-melt(data,id.vars=c("dataset","corrected_percentage"),measure.vars=c("Trichostomatia"),variable.name="species",value.name="percentage")
p1<-ggplot(data2,aes(x=percentage,y=dataset,fill=dataset))+geom_boxplot(alpha=0.5,outlier.size = 0,size=0.2,width=0.5)+geom_jitter(width=0,height=0.17,size=1,alpha=1,aes(colour=dataset))+scale_y_discrete(limits=c("This study","Shen et al., 2020","Stewart et al., 2019","Shi et al., 2014","Xue et al., 2020")) + theme_bw() + theme(legend.position="none",panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.title.x = element_text(size = 15),axis.text.x = element_text(size = 15),axis.text.y = element_text(size = 15))+scale_x_continuous(limits=c(0,0.8),breaks=seq(0, 0.8, 0.2))+labs(x="Classification rate (%)")
p2<- ggplot(data2,aes(x=corrected_percentage,y=species))+geom_boxplot(fill='blueviolet',color='blueviolet',alpha=0.5,outlier.size = 0,size=0.2,width=0.5)+geom_jitter(width=0,height=0.17,size=1,alpha=1,color='blueviolet')+ theme_bw() + theme(legend.position="none",panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.title.x = element_text(size = 15),axis.text.x = element_text(size = 15),axis.text.y = element_text(size = 15))+scale_x_continuous(limits=c(0,0.7),breaks=seq(0, 0.7, 0.2))+labs(x="Corrected rate (%)")
library(grid)
vp<-viewport(width = 0.4,height=0.3,x=0.9,y=0.9,just=c("right","top"))
print(p1)
print(p2,vp=vp)

#RED
library(ggplot2)
library(reshape2)
#RED_data<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig3\\RED.txt",sep="\t",header=TRUE)
#RED_data<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig3\\RED_adjusted.txt",sep="\t",header=TRUE)
RED_data<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig3\\RED_adjusted_lzj.txt",sep="\t",header=TRUE)
RED_data1<-melt(RED_data,variable.name = "Rank",value.name = "RED")
Isf<-median(RED_data$Inter.subfamily,na.rm = TRUE)
Ig<-median(RED_data$Inter.genus,na.rm = TRUE)
Is<-median(RED_data$Inter.species,na.rm = TRUE)
ggplot(RED_data1,aes(x=RED,y=Rank,group=Rank))+
  geom_jitter(color="black",fill="#9fc69f",size=3.5,height = 0.3,shape=21)+
  geom_boxplot(fill="PaleGreen",alpha=0.3,width=0.5,size=0.15,outlier.colour = NA)+
  geom_segment(aes(x=Isf+0.1, y=1.75, xend=Isf+0.1, yend=2.25), color="black")+
  geom_segment(aes(x=Isf-0.1, y=1.75, xend=Isf-0.1, yend=2.25), color="black")+
  geom_segment(aes(x=Ig+0.1, y=2.75, xend=Ig+0.1, yend=3.25), color="black")+
  geom_segment(aes(x=Ig-0.1, y=2.75, xend=Ig-0.1, yend=3.25), color="black")+
  geom_segment(aes(x=Is+0.1, y=3.75, xend=Is+0.1, yend=4.25), color="black")+
  geom_segment(aes(x=Is-0.1, y=3.75, xend=Is-0.1, yend=4.25), color="black")+
  theme_bw()+
  scale_x_continuous(breaks = seq(0,1,0.1))+
  expand_limits(x=0,y=0)+
  scale_x_continuous(expand = c(0, 0))
#ggplot(RED_data1,aes(x=RED,y=Rank,group=Rank))+geom_jitter(color="black",fill="#9fc69f",size=5,height = 0.1,shape=21)+geom_boxplot(fill="PaleGreen",alpha=0.3,width=0.5,size=0.3,outlier.colour = NA)+geom_segment(aes(x=Isf+0.1, y=1.75, xend=Isf+0.1, yend=2.25), color="black")+geom_segment(aes(x=Isf-0.1, y=1.75, xend=Isf-0.1, yend=2.25), color="black")+geom_segment(aes(x=Ig+0.1, y=2.75, xend=Ig+0.1, yend=3.25), color="black")+geom_segment(aes(x=Ig-0.1, y=2.75, xend=Ig-0.1, yend=3.25), color="black")+geom_segment(aes(x=Is+0.1, y=3.75, xend=Is+0.1, yend=4.25), color="black")+geom_segment(aes(x=Is-0.1, y=3.75, xend=Is-0.1, yend=4.25), color="black")+theme_bw()+scale_x_continuous(breaks = seq(0,1,0.1))+expand_limits(x=0,y=0)+scale_x_continuous(expand = c(0, 0))
