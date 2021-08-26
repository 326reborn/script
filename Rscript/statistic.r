#相关性统计检验
data<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\genome_depth\\Polyplastron.multivesiculatum.SAG8.dep_stat",header=TRUE,sep='\t')
cor.test(data$FPKM,data$FPKM.1, method = "pearson")