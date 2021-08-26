#�������ݱ�ͼ
library(ggplot2)
library(scatterpie)#�������ݱ�ͼר��
data<-read.csv(file<-"D:\\�����о����ĵ�\\����\\��θ΢������ھ�ʦ�֣�\\genomic\\ԭ����Ŀ������Դ.txt",header=TRUE,sep='\t')
x<-sqrt(data$Counts)/4#���ڵ������İ뾶
radius<-data.frame(x)
my_data<-cbind(data,radius)
ggplot()+ 
  geom_scatterpie(data=my_data,aes(x=Delete,y=S_number,r=x),cols=c("M_specie1","M_specie2","M_specie3"),color=NA)+
  scale_x_continuous(limits=c(0,19))+#�豣֤x����y�᳤����ȣ����ܱ�֤�����Ƶı�Ϊ��Բ
  geom_scatterpie_legend(my_data$x, x=10, y=1,n=3,labeller=function(x) round((x*4)^2))+#��ӱ��Ĵ�Сͼ��
  scale_fill_manual(values = c("#767676","#bbbbbb","#3b3b3b"))+
  theme_bw()+
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.text.x = element_blank(),axis.text.y = element_blank(),axis.title.x = element_blank(),axis.title.y = element_blank())
#����ø��ͼ
library(ggplot2)
library(scatterpie)
enzyme_data <- read.csv(file<-"D:\\�����о����ĵ�\\����\\��θ΢������ھ�ʦ�֣�\\����\\��ͼ\\Fig4\\ԭ�������ø����ͳ��.txt",sep="\t",header=TRUE)
x<-sqrt(enzyme_data$Gene_number)/40
radius1<-data.frame(x)
my_data1<-cbind(enzyme_data,radius1)
ggplot()+geom_scatterpie(data=my_data1,aes(x=X_pos,y=S_number,r=x),cols=c("cellulose","hemicellulose","pectin","peptidoglycan","fructan","starch"),color=NA)+scale_x_continuous(limits = c(0,5.5))+geom_scatterpie_legend(my_data1$x, x=4, y=2,n=4,labeller=function(x) round((x*40)^2))+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+labs(y="Subfamily")+scale_fill_manual(values=c("cellulose" = "#F2B379", "hemicellulose" = "#DD5F60", "pectin" = "#4169B2","starch"="#FDDC7B","fructan"="#479E9B","peptidoglycan"="#B1A4C0"))
#���Ʊ�ͼ
library(ggplot2)
data<-read.csv(file<-"D:\\�����о����ĵ�\\����\\��θ΢������ھ�ʦ�֣�\\����\\���ʱ����\\��18S�����Ʋ�ʱ��Ϊ������\\��ţ��������ԭ���������.txt",header=TRUE,sep='\t')
ggplot(data,aes(x="Content",y=Abundance,fill=Genus))+
  geom_bar(stat = 'identity', position = 'stack',width = 1)+
  scale_fill_manual(values = c('#f2c11c','#8491B4','#F39B7F','#4DBBD5','#91D1C2'))+coord_polar("y", start=0) + 
  labs(x = '', y = '', title = '') +
  theme_bw()+ 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(),axis.text = element_blank()) + 
  theme(axis.ticks = element_blank())

library(ggplot2)
rate_date<-read.csv(file<-"D:\\�����о����ĵ�\\����\\��θ΢������ھ�ʦ�֣�\\comparative genomics\\evolution_rate\\evolution_rate.txt",sep="\t",header=TRUE)
ggplot(rate_date,aes(x=Node,y="1"))+geom_point(shape=19,stat='identity',aes(size=AA_rate))+scale_size(rang=c(1.5,4))