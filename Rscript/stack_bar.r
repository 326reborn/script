#new gene familys
library(ggplot2)
library(reshape2)
data<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\文章\\主图\\comparative_genome\\main_clade_stat.txt",header=TRUE,sep='\t')
data1<-melt(data,id.vars = "Clade",variable.name = "Type",value.name = "Number")
ggplot(data = data1,aes(x=Clade,y=Number,fill=Type))+
  geom_bar(stat="identity",position=position_stack(reverse = TRUE),width=0.2)+
  scale_fill_manual(values = c("New"="#619CFF","Expansion"="#00BA38","Contraction"="#F8766D"))+ 
  theme_bw() + 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

#comparative genomics statistics
library(ggplot2)
library(reshape2)
#gene composition
com_data<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\comparative genomics\\gene_family_stat\\02.tree_stat\\Comparative_gene_family2.txt",header=TRUE,sep='\t')
com_data1<-melt(com_data,id.vars = "Individual",variable.name = "Class",value.name = "Gene_numbers")
ggplot(com_data1,aes(x=Gene_numbers,y=Individual,fill=Class))+
  geom_bar(stat="identity",position=position_stack(reverse=TRUE),width=0.6)+
  scale_y_discrete(limits=c('Ophryoscolex.caudatus.SAGT3','Epidinium.cattanei.SAG3','Epidinium.caudatum.SAG1','Polyplastron.multivesiculatum.SAG8','Ostracodinium.dentatum.SAG1','Ostracodinium.gracile.SAG1','Eremoplastron.rostratum.SAG2','Metadinium.minomm.SAG1','Enoploplastron.triloricatum.SAGT1','Diplodinium.flabellum.SAG1','Diplodinium.dentatum.SAGT1','Entodinium.caudatum.SAG4','Entodinium.bursa.SAGT1','Entodinium.longinucleatum.SAG4','Dasytricha.ruminantium.SAG3','Isotricha.jalaludinii.SAG3','Isotricha.intestinalis.SAG3','Isotricha.prostoma.SAG3','Isotricha.paraprostoma.SAG1')) + 
  scale_fill_manual(values = c('X1_1'='#F8766D','X_X'='#ebce7d',"Iso_specific"="#75c2d5","Ent_clade_specific"="#eb977d","Oph_clade_specific"="#8ecabc","patchy"="#add8e6","Species_specific"="#a3aeba"))+
  theme_bw()+
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
#genefamily composition
gf_data<-read.csv(file<-"D:\\张禹研究生文档\\课题\\瘤胃微生物（李宗军师兄）\\comparative genomics\\gene_family_stat\\comparative_genefamily.txt",header=TRUE,sep='\t')
gf_data1<-melt(gf_data,id.vars = "Individual",variable.name = "Class",value.name = "Genefamily_numbers")
ggplot(gf_data1,aes(x=Genefamily_numbers,y=Individual,fill=Class))+
  geom_bar(stat="identity",position=position_stack(reverse=TRUE),width=0.6)+
  scale_y_discrete(limits=c('Ophryoscolex.caudatus.SAGT3','Epidinium.cattanei.SAG3','Epidinium.caudatum.SAG1','Polyplastron.multivesiculatum.SAG8','Ostracodinium.dentatum.SAG1','Ostracodinium.gracile.SAG1','Eremoplastron.rostratum.SAG2','Metadinium.minomm.SAG1','Enoploplastron.triloricatum.SAGT1','Diplodinium.flabellum.SAG1','Diplodinium.dentatum.SAGT1','Entodinium.caudatum.SAG4','Entodinium.bursa.SAGT1','Entodinium.longinucleatum.SAG4','Dasytricha.ruminantium.SAG3','Isotricha.jalaludinii.SAG3','Isotricha.intestinalis.SAG3','Isotricha.prostoma.SAG3','Isotricha.paraprostoma.SAG1')) + 
  scale_fill_manual(values = c('X1_1'='#F8766D','X_X'='#ebce7d',"Iso_specific"="#75c2d5","Ent_clade_specific"="#eb977d","Oph_clade_specific"="#8ecabc","patchy"="#add8e6","Species_specific"="#a3aeba"))+
  theme_bw()+
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
