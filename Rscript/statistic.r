#�����ͳ�Ƽ���
data<-read.csv(file<-"D:\\�����о����ĵ�\\����\\��θ΢������ھ�ʦ�֣�\\genomic\\genome_depth\\Polyplastron.multivesiculatum.SAG8.dep_stat",header=TRUE,sep='\t')
cor.test(data$FPKM,data$FPKM.1, method = "pearson")