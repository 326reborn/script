library(ggplot2)
library(reshape2)
args<-(commandArgs(TRUE))
#data<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\test.f",sep="\t",header=TRUE)
data<-read.delim(file<-args[1],sep="\t",header=TRUE,encoding = "utf-8")
data2<-melt(data,id.vars = "position",variable.name = "base",value.name = "percentage")
l<-ggplot(data2,aes(x=position,y=percentage,color=base))+geom_line(size=0.5)+
  geom_point(size=1.5)+theme_bw()+
  theme(panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(),
        axis.text.y = element_text(size = 15),
        axis.title.x = element_blank(),
        axis.title.y = element_text(size = 15),
        axis.line.x = element_blank(),
        axis.ticks.x = element_blank())+
  labs(x="Position",y="% base")
#scale_y_continuous(position = "right") #y轴坐标右移
pdf(args[2],width = 12,height = 7)
print(l)
dev.off()