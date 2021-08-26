library(ggplot2)
library(reshape2)
heatdata<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\comparative genomics\\Domain\\clade_specific_gene.domain.txt",sep="\t",header=TRUE)
heatdatam<-melt(heatdata,id.vars="Individual",variable.name="Gene",value.name = "counts")
test_data<-transform(heatdatam,lcount=log10(heatdatam$counts+1))
ggplot(test_data, aes(x=Gene,y=Individual))+
  geom_tile(aes(fill=lcount))+ 
  theme_bw()+
  scale_fill_gradient2(low = "lightblue", high =  "red",midpoint = 2)+
  scale_y_discrete(limits=c("Ophryoscolex.caudatus","Epidinium.cattanei","Epidinium.caudatum","Polyplastron.multivesiculatum","Ostracodinium.dentatum","Ostracodinium.gracile","Eremoplastron.rostratum","Metadinium.minomm","Enoploplastron.triloricatum","Diplodinium.flabellum","Diplodinium.dentatum","Entodinium.caudatum","Entodinium.bursa","Entodinium.longinucleatum","Dasytricha.ruminantium","Isotricha.jalaludinii","Isotricha.intestinalis","Isotricha.paraprostoma","Isotricha.prostoma"))
