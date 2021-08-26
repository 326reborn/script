#genome_structure_feature
library(ggplot2)
structure<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\genomic\\genome_structure\\Polyplastron.multivesiculatum.SAG8.len_gene",sep="\t",header=FALSE)
colnames(structure)<-c("ID","Species","Gene_number","Length")
ggplot(structure,aes(x=Length,y=Gene_number))+geom_point(color = 'gray', alpha = 0.6, pch = 19, size = 0.5)+stat_density2d(aes(fill = ..density.., alpha = ..density..), geom = 'tile', contour = FALSE, n = 500)+scale_fill_gradientn(colors = c('transparent', 'gray', 'yellow', 'red'))
