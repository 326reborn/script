library(ggplot2)
library(RColorBrewer)#调色板
#genome size
data3<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\genomic_stat_size.txt",header=TRUE,sep='\t')
ggplot(data3,aes(x=size,y=species,fill=species,color=species))+
  geom_boxplot(size=0.1,alpha=0.3)+
  geom_jitter()+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(panel.border = element_blank(),axis.ticks = element_blank())+
  scale_x_continuous(position = "top")+
  labs(y="Species",x="Genome size (Mb)")

#以科为单位
#colour: 
#Dip:'#1a5694','#1a3894','#1a4294','#1a4c94','#1a5694','#1a6094','#1a6a94','#1a7594'
#Iso:'#D54F83','#d54f83','#c32e68','#da6492','#df78a0'
#Ent:'#a7a953','#a9a453','#a0a953'
#Oph:'#1D8740','#229c4a','#1d872e'

#colour(new):
#Iso:#4eb1c9
#Dr:#e8bb28
#Ent:#eb977d
#Dip:#818daf
#Oph:#8ecabc
library(grid)

data3<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig1\\genomic_stat20210409.txt",header=TRUE,sep='\t')
p0<-ggplot(data3,aes(x=Size,y=Species,fill=Family,color=Family))+
  geom_boxplot(size=0.1,alpha=0.3)+
  geom_jitter()+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank())+
  scale_x_continuous(position = "top",limits = c(20,160))+
  labs(y="Species",x="Genome size (Mb)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p1<-ggplot(data3,aes(x=Size,y=Species,fill=Family,color=Family))+
  geom_boxplot(size=0.1,alpha=0.3)+
  geom_jitter()+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(y="Species",x="Genome size (Mb)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p2<-ggplot(data3,aes(x=Scaffolds_number,y=Species,fill=Family,color=Family))+
  geom_boxplot(size=0.1,alpha=0.3)+
  geom_jitter()+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(x="Scaffold numbers (×1000)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p3<-ggplot(data3,aes(x=N50,y=Species,fill=Family,color=Family))+
  geom_boxplot(size=0.1,alpha=0.3)+
  geom_jitter()+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(x="N50(Kb)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p4<-ggplot(data3,aes(x=T_NP,y=Species,fill=Family,color=Family))+
  geom_boxplot(size=0.1,alpha=0.3)+
  geom_jitter()+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(x="T.scaffolds content (%)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p5<-ggplot(data3,aes(x=Gene_number,y=Species,fill=Family,color=Family))+
  geom_boxplot(size=0.1,alpha=0.3)+
  geom_jitter()+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(x="Gene numbers (×1000)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p6<-ggplot(data3,aes(x=BUSCO_alveolata,y=Species,fill=Family,color=Family))+
  geom_boxplot(size=0.1,alpha=0.3)+
  geom_jitter()+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(x="BUSCO_alveolata (%)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

grid.newpage()  ###新建图表版面
pushViewport(viewport(layout = grid.layout(1,7))) ####将版面分成1行7列1*7矩阵
vplayout <- function(x,y){viewport(layout.pos.row = x, layout.pos.col = y)}
print(p0,vp=vplayout(1,1))
print(p1,vp=vplayout(1,2))
print(p2,vp=vplayout(1,3))
print(p3,vp=vplayout(1,4))
print(p4,vp=vplayout(1,5))
print(p5,vp=vplayout(1,6))
print(p6,vp=vplayout(1,7))

#19best_indevidual genome stat
library(ggplot2)
library(RColorBrewer)#调色板
library(grid)
data1<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig1\\19best_genomic_stat20210409.txt",header=TRUE,sep='\t')
#Genome size
p0<-ggplot(data1,aes(x=Size,y=Species,fill=Family,color=Family))+
  geom_bar(stat='identity',width = 0.8)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),)+
  scale_x_continuous(position = "top")+
  labs(y="Species",x="Genome size (Mb)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p1<-ggplot(data1,aes(x=Size,y=Species,fill=Family,color=Family))+
  geom_bar(stat='identity',width = 0.8)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(y="Species",x="Genome size (Mb)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p4<-ggplot(data1,aes(x=Scaffolds_number,y=Species,fill=Family,color=Family))+
  geom_bar(stat='identity',width = 0.8)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(y="Species",x="Scaffold numbers (×1000)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p3<-ggplot(data1,aes(x=BT_M,y=Species,fill=Family,color=Family))+
  geom_bar(stat='identity',width = 0.8)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(y="Species",x="Mean chromosome length (Kb)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p2<-ggplot(data1,aes(x=Gene_number,y=Species,fill=Family,color=Family))+
  geom_bar(stat='identity',width = 0.8)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(y="Species",x="Gene numbers (×1000)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p5<-ggplot(data1,aes(x=T_NP,y=Species,fill=Family,color=Family))+
  geom_point(stat='identity',size=7)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top",limits=c(0,100))+
  labs(y="Species",x="T.scaffolds content (%)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p6<-ggplot(data1,aes(x=BUSCO_alveolata,y=Species,fill=Family,color=Family))+
  geom_point(stat='identity',size=7)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top",limits=c(50,100))+
  labs(y="Species",x="BUSCO_alveolata (%)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

pushViewport(viewport(layout = grid.layout(1,7))) ####将版面分成1行7列1*7矩阵
vplayout <- function(x,y){viewport(layout.pos.row = x, layout.pos.col = y)}
print(p0,vp=vplayout(1,1))
print(p1,vp=vplayout(1,2))
print(p2,vp=vplayout(1,3))
print(p3,vp=vplayout(1,4))
print(p4,vp=vplayout(1,5))
print(p5,vp=vplayout(1,6))
print(p6,vp=vplayout(1,7))

#19best调整为scaffold堆叠柱形图
library(reshape2)
library(ggplot2)
data1<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig2\\19best_genomic_stat20210315.txt",header=TRUE,sep='\t')
p0<-ggplot(data1,aes(x=Size,y=Species,fill=Family,color=Family))+#用于提供Y轴的名字
  geom_bar(stat='identity',width = 0.8)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank())+
  scale_x_continuous(position = "top")+
  labs(y="Species",x="Genome size (Mb)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

NT_scaffold<-data.frame(data1$NT_NP/100*data1$Scaffolds_number)
BT_scaffold<-data.frame(data1$BT_NP/100*data1$Scaffolds_number)
ST_scaffold<-data.frame(data1$ST_NP/100*data1$Scaffolds_number)
mydata<-cbind(data1$Species,data1$Family,NT_scaffold,ST_scaffold,BT_scaffold)
colnames(mydata)<-c("Species","Family","NT_scaffold","ST_scaffold","BT_scaffold")
mydata1<-melt(mydata,id.vars = c("Species","Family"),variable.name = "Scaffolds",value.name = "Scaffolds_number")
p1<-ggplot()+geom_col(mydata1,mapping=aes(x=Scaffolds_number,y=Species,fill=Scaffolds),width = 0.8)+ #p1需手动改色为透明度
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(y="Species",x="Scaffold numbers (×1000)")+  
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))

p2<-ggplot(data1,aes(x=N50,y=Species,fill=Family,color=Family))+
  geom_bar(stat='identity',width = 0.8)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.ticks = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(y="Species",x="N50(Kb)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p3<-ggplot(data1,aes(x=Size,y=Species,fill=Family,color=Family))+
  geom_bar(stat='identity',width = 0.8)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(y="Species",x="Genome size (Mb)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

p4<-ggplot(data1,aes(x=BUSCO_alveolata,y=Species,fill=Family,color=Family))+
  geom_point(stat='identity',size=7)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top",limits=c(50,100))+
  labs(y="Species",x="BUSCO_alveolata (%)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))

pushViewport(viewport(layout = grid.layout(1,5))) ####将版面分成1行5列1*5矩阵
vplayout <- function(x,y){viewport(layout.pos.row = x, layout.pos.col = y)}
print(p0,vp=vplayout(1,1))
print(p1,vp=vplayout(1,2))
print(p2,vp=vplayout(1,3))
print(p3,vp=vplayout(1,4))
print(p4,vp=vplayout(1,5))

#Gene_number 堆叠柱形图
Gene_data<-cbind(data.frame(data1$Species),data.frame(data1$Family),data.frame(data1$Complete_gene),data.frame(data1$Uncomplete_gene))
colnames(Gene_data)<-c("Species","Family","Complete_gene","Uncomplete_gene")
Gene_data1<-melt(Gene_data,id.vars = c("Species","Family"),variable.name = "Gene_type",value.name = "Gene_number")
p_gene_number<-ggplot()+geom_col(Gene_data1,mapping=aes(x=Gene_number,y=Species,fill=factor(Gene_type,levels=c("Uncomplete_gene","Complete_gene"))),width = 0.8)+ #p1需手动改色为透明度
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top")+
  labs(y="Species",x="Gene numbers (K)")+  
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))

#Gene_density
p_gene_density<-ggplot(data1,aes(x=Gene_density,y=Species,fill=Family,color=Family))+
  geom_point(stat='identity',size=7)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.prostoma","Isotricha.paraprostoma"))+
  theme_bw() +
  theme(legend.position="none",panel.border = element_blank(),axis.ticks = element_blank(),axis.text.y = element_blank(),axis.title.y = element_blank())+
  scale_x_continuous(position = "top",limits = c(50,100,10))+
  labs(y="Species",x="Gene_density (%)")+
  scale_fill_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))+
  scale_colour_manual(values = c('#e8bb28','#818daf','#eb977d','#4eb1c9','#8ecabc'))
#Contig_len 箱型图
contig_len_Ii<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig1\\Isotricha.jalaludinii.SAG3.contig_len",header=FALSE,sep='\t')
contig_len_Op<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig1\\Ophryoscolex.caudatus.SAGT3.contig_len",header=FALSE,sep='\t')
contig_len_Dr<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig1\\Dasytricha.ruminantium.SAG3.contig_len",header=FALSE,sep='\t')
colnames(contig_len_Ii)<-c("Contig","Len","Species")
colnames(contig_len_Op)<-c("Contig","Len","Species")
colnames(contig_len_Dr)<-c("Contig","Len","Species")
total<-rbind(contig_len_Ii,contig_len_Op,contig_len_Dr)
total_test<-transform(total,Len_log=log10(total$Len*1000))
ggplot(total_test,aes(x=Species,y=Len_log))+geom_boxplot()
