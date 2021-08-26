library(ggplot2)
library(reshape2)
data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\mapping\\snp_result\\Enoploplastron.triloricatum.SAGT1.chrom_SNP.het",sep="\t",header=FALSE)
colnames(data)<- c("chrom","length","snp_p","VAF","heterozygosity")
ggplot(data,aes(x=VAF),cex.axis=1.5)+geom_histogram(binwidth=0.01, colour="black", fill="PaleGreen",alpha=0.3) +geom_vline(aes(xintercept=mean(VAF, na.rm=T)),color="red", linetype="dashed", size=1)+ theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 15),axis.text.y = element_text(size = 15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15))+labs(x="VAF (Variant allele fraction)",y="Contig numbers")+geom_density()
#colnames(data2)<- c("qseqid","sseqid","pident","length","qcovs","qcovhsp","mismatch","gapopen","gaps","qstart","qend","sstart","send","evalue","bitscore")
#ggplot(data2, aes(x=pident)) + geom_histogram(aes(y=..density..),binwidth=.5,colour="black", fill="PaleGreen",alpha=0.3)+geom_density(alpha=.2, fill="#FF6666")

#ANI频数分布图
data<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\ANI\\ani1.class_withgenus",header=TRUE,sep="\t")
ggplot(data,aes(x=value,fill=genus))+
  geom_histogram(binwidth=0.01) +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 15),axis.text.y = element_text(size = 15),
        axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15))+
  labs(x="FastANI estimate",y="Count of comparisons")+
  scale_x_continuous(breaks=seq(0.4, 1, 0.1))
ggplot(data,aes(x=value,fill=type))+geom_histogram(binwidth=0.01) +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 15),axis.text.y = element_text(size = 15),
        axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15))+
  labs(x="FastANI estimate",y="Count of comparisons")+
  scale_x_continuous(breaks=seq(0.4, 1, 0.1))
#genome_ploidy密度曲线
data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\genome_ploidy\\19best.merge.depth",sep='\t',header=FALSE)
colnames(data)<-c("Contig","Depth","Individual","Lg_dep")
#data$Depth[which(data$Depth>1000)]<-1001  #可将Depth列大于1000的数据换为1001
ggplot(data,aes(x=Lg_dep,colour=Individual),cex.axis=1.5)+ 
  theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                   panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),
                   axis.text.x = element_text(size = 15),axis.text.y = element_text(size = 15),
                   axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15))+
  labs(x="Read depth (lg)",y="Frequency density")+
  geom_density(alpha=.7,size=2)+
  scale_colour_manual(values=c('#D54F83','#1a5694','#1a3894','#1a4294','#a7a953','#a9a453','#a0a953','#1D8740','#229c4a','#1a4c94','#d54f83','#c32e68','#da6492','#df78a0','#1a5694','#1d872e','#1a6094','#1a6a94','#1a7594'))
#同时调整顺序和颜色（一一对应）
#ggplot(data,aes(x=Depth,colour=Individual),cex.axis=1.5)+ theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 15),axis.text.y = element_text(size = 15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.position = c(0.7,0.6))+labs(x="Read depth",y="Frequency density")+geom_density(alpha=0.3,size=0.8)+scale_x_continuous(limits=c(0,1003))+scale_colour_manual(values=c('#D54F83','#d54f83','#c32e68','#da6492','#df78a0','#1a5694','#1a3894','#1a4294','#1a4c94','#1a5694','#1a6094','#1a6a94','#1a7594','#a7a953','#a9a453','#a0a953','#1D8740','#229c4a','#1d872e'),breaks=c("Dasytricha.ruminantium.SAG3","Isotricha.intestinalis.SAG3","Isotricha.jalaludinii.SAG3","Isotricha.paraprostoma.SAG1","Isotricha.prostoma.SAG3","Diplodinium.dentatum.SAGT1","Diplodinium.flabellum.SAG1","Enoploplastron.triloricatum.SAGT1","Eremoplastron.rostratum.SAG2","Metadinium.minomm.SAG1","Ostracodinium.dentatum.SAG1","Ostracodinium.gracile.SAG1","Polyplastron.multivesiculatum.SAG8","Entodinium.longinucleatum.SAG4","Entodinium.caudatum.SAG4","Entodinium.bursa.SAGT1","Epidinium.cattanei.SAG3","Epidinium.caudatum.SAG1","Ophryoscolex.caudatus.SAGT3"))

#SNP Vaf(variant allele fraction)密度曲线
data2<- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\genome_ploidy\\19best.merge.snp_het",sep='\t',header=FALSE)
colnames(data2)<- c("chrom","length","snp_p","VAF","heterozygosity","Individual")
ggplot(data2,aes(x=VAF,colour=Individual),cex.axis=1.5)+ theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 15),axis.text.y = element_text(size = 15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15),legend.position = c(0.7,0.6))+labs(x="VAF (Variant allele fraction)",y="Frequency density")+geom_density(alpha=0.3,size=0.8)+scale_colour_manual(values=c('#D54F83','#d54f83','#c32e68','#da6492','#df78a0','#1a5694','#1a3894','#1a4294','#1a4c94','#1a5694','#1a6094','#1a6a94','#1a7594','#a7a953','#a9a453','#a0a953','#1D8740','#229c4a','#1d872e'),breaks=c("Dasytricha.ruminantium.SAG3","Isotricha.intestinalis.SAG3","Isotricha.jalaludinii.SAG3","Isotricha.paraprostoma.SAG1","Isotricha.prostoma.SAG3","Diplodinium.dentatum.SAGT1","Diplodinium.flabellum.SAG1","Enoploplastron.triloricatum.SAGT1","Eremoplastron.rostratum.SAG2","Metadinium.minomm.SAG1","Ostracodinium.dentatum.SAG1","Ostracodinium.gracile.SAG1","Polyplastron.multivesiculatum.SAG8","Entodinium.longinucleatum.SAG4","Entodinium.caudatum.SAG4","Entodinium.bursa.SAGT1","Epidinium.cattanei.SAG3","Epidinium.caudatum.SAG1","Ophryoscolex.caudatus.SAGT3"))

#dS分布图
library(ggplot2)
data<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\构树\\直系同源单拷贝基因\\Ka_Ks\\dS_value.stat",header=FALSE,sep='\t')
colnames(data)<-c("dS","Class")
ggplot(data,aes(x=dS,fill=Class),cex.axis=1.5)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 15),axis.text.y = element_text(size = 15),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15))+labs(x="Ks",y="Frequency density")+geom_density(alpha=.7,size=0.7)

library(ggplot2)
library(reshape2)
#genome_identity ANI
identity_data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig3\\ANI.genome_identity.distinguish.filter",sep="\t",header=TRUE)
identity_data <-identity_data[,-4:-4]
identity_data1<-melt(identity_data,variable.name = "Class",value.name = "ANI")
ggplot(identity_data1,aes(x=ANI,color=Class,fill=Class),cex.axis=1.5)+geom_histogram(binwidth=0.005,alpha=0.1,size=0.5)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 8.5),axis.text.y = element_text(size = 8.5),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15))+ labs(x="Identity",y="Count")+scale_x_continuous(breaks = seq(0.82,1,0.01)) +scale_fill_manual(values = c('#eb977d','#8ecabc','#4eb1c9','#6C49B8','#D81159'))+scale_colour_manual(values = c('#eb977d','#8ecabc','#4eb1c9','#6C49B8','#D81159'))+scale_y_continuous(expand = c(0, 0))

xt_data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig3\\ANI.genome_identity_rename.distinguish.cut",sep="\t",header=TRUE)
xt_data1<-melt(identity_data,variable.name = "Class",value.name = "ANI")
ggplot(xt_data1,aes(x=ANI,color=Class,fill=Class),cex.axis=1.5)+geom_histogram(mapping=aes(fill=Class),binwidth=0.01,size=0)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 8.5),axis.text.y = element_text(size = 8.5),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15))+ labs(x="Identity",y="Count")+scale_x_continuous(breaks = seq(0.82,1,0.01)) +scale_y_continuous(expand = c(0, 0))
#cov ANI 
cov_data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig3\\genome_cov.distinguish.filter",sep="\t",header=TRUE)
cov_data<-cov_data[,-4:-4]
cov_data1<-melt(cov_data,variable.name = "Class",value.name = "ANI")
ggplot(cov_data1,aes(x=ANI,color=Class,fill=Class),cex.axis=1.5)+geom_histogram(binwidth=0.005,alpha=0.1,size=0.5)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 8.5),axis.text.y = element_text(size = 8.5),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15))+ labs(x="Coverage",y="Count")+scale_x_continuous(breaks = seq(0,1,0.05))+scale_fill_manual(values = c('#eb977d','#8ecabc','#4eb1c9','#6C49B8','#D81159'))+scale_colour_manual(values = c('#eb977d','#8ecabc','#4eb1c9','#6C49B8','#D81159'))+scale_y_continuous(expand = c(0, 0))
#18_28S distance
distance_data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig3\\18_28S_distance.distinguish.filter",sep="\t",header=TRUE)
distance_data1<-melt(distance_data,variable.name = "Class",value.name = "ANI")
#18_28S_identity
S_identity_data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig3\\18_28S_identity.distinguish.filter",sep="\t",header=TRUE)
S_identity_data<-S_identity_data[,-4:-4]
S_identity_data1<-melt(S_identity_data,variable.name = "Class",value.name = "ANI")
ggplot(S_identity_data1,aes(x=ANI,color=Class,fill=Class),cex.axis=1.5)+geom_histogram(binwidth=0.0005,alpha=0.1,size=0.5)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 8.5),axis.text.y = element_text(size = 8.5),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15))+ labs(x="Identity",y="Count")+scale_x_continuous(breaks = seq(0.95,1,0.0025)) +scale_fill_manual(values = c('#eb977d','#8ecabc','#4eb1c9','#6C49B8','#D81159'))+scale_colour_manual(values = c('#eb977d','#8ecabc','#4eb1c9','#6C49B8','#D81159'))+scale_y_continuous(expand = c(0, 0))
ggplot(S_identity_data1,aes(x=ANI,color=Class,fill=Class),cex.axis=1.5)+geom_histogram(mapping=aes(x=ANI,fill=Class),binwidth=0.001,size=0)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 8.5),axis.text.y = element_text(size = 8.5),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15))+ labs(x="Identity",y="Count")+scale_y_continuous(expand = c(0, 0))+scale_fill_manual(values = c("inter_species"="#F8766D","inter_genus"="#7CAE00","intra_species"="#00BFC4","inter_family"="#C77CFF"))+scale_colour_manual(values = c("inter_species"="#F8766D","inter_genus"="#7CAE00","intra_species"="#00BFC4","inter_family"="#C77CFF"))
ggplot(S_identity_data1,aes(x=ANI,color=Class,fill=Class),cex.axis=1.5)+geom_histogram(mapping=aes(x=ANI,fill=Class),binwidth=0.001,size=0)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 8.5),axis.text.y = element_text(size = 8.5),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15))+ labs(x="Identity",y="Count")+scale_y_continuous(expand = c(0, 0))+scale_fill_manual(values = c("inter_species"="#F8766D","inter_genus"="#7CAE00","intra_species"="#00BFC4","inter_subfamily"="#619CFF","inter_family"="#C77CFF"))+scale_colour_manual(values = c("inter_species"="#F8766D","inter_genus"="#7CAE00","intra_species"="#00BFC4","inter_subfamily"="#619CFF","inter_family"="#C77CFF"))

S_identity_data <- read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\Fig3\\RED_adjusted_result\\18_28identity.distinguish.filter",sep="\t",header=TRUE)
S_identity_data1<-melt(S_identity_data,variable.name = "Class",value.name = "ANI")
ggplot(S_identity_data1,aes(x=ANI,color=Class,fill=Class),cex.axis=1.5)+geom_histogram(mapping=aes(x=ANI,fill=Class),binwidth=0.001,size=0)+theme_bw()+theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"),axis.text.x = element_text(size = 8.5),axis.text.y = element_text(size = 8.5),axis.title.x = element_text(size = 15),axis.title.y = element_text(size = 15))+ labs(x="Identity",y="Count")+scale_y_continuous(expand = c(0, 0))+scale_fill_manual(values = c("inter_species"="#F8766D","inter_genus"="#7CAE00","intra_species"="#00BFC4","inter_subfamily"="#619CFF","inter_family"="#C77CFF","inter_order"="#B79F00"))+scale_colour_manual(values = c("inter_species"="#F8766D","inter_genus"="#7CAE00","intra_species"="#00BFC4","inter_subfamily"="#619CFF","inter_family"="#C77CFF","inter_order"="#B79F00"))
