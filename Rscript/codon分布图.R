
###3*15
#install.packages("ggseqlogo")
library("ggseqlogo")
library(ggplot2)
#library(ggseqlogo)
fasta_input <- read.table("D:\\selfsoftware\\Rstudy\\Rscript\\»­Í¼\\Ô­³æ\\stop_codon\\Polyplastron.final.condonstat.t.head32",  header=F, row.names=NULL)
fasta_input <- as.vector(fasta_input$V1)
head(fasta_input)
#ggseqlogo(seqs_dna$MA0001.1)
ggplot()+geom_logo(fasta_input)+theme_logo()
ggseqlogo(fasta_input, seq_type="aa",method="prob")
#ggplot()+geom_logo(fasta_input)+theme_logo()

fasta_input <- read.table("D:\\selfsoftware\\Rstudy\\Rscript\\»­Í¼\\Ô­³æ\\stop_codon\\Polyplastron.final.condonstat.t.tail32",  header=F, row.names=NULL)
fasta_input <- as.vector(fasta_input$V1)
ggseqlogo(fasta_input, seq_type="aa",method="prob")


#########################################################
fasta_input <- read.table("D:\\selfsoftware\\Rstudy\\Rscript\\»­Í¼\\Ô­³æ\\stop_codon\\Entodinium.final.condonstat.t.tail32",  header=F, row.names=NULL)
fasta_input <- as.vector(fasta_input$V1)
ggseqlogo(fasta_input, seq_type="aa",method="prob")

fasta_input <- read.table("D:\\selfsoftware\\Rstudy\\Rscript\\»­Í¼\\Ô­³æ\\stop_codon\\Entodinium.final.condonstat.t.head32",  header=F, row.names=NULL)
fasta_input <- as.vector(fasta_input$V1)
ggseqlogo(fasta_input, seq_type="aa",method="prob")

#####################################################
fasta_input <- read.table("D:\\selfsoftware\\Rstudy\\Rscript\\»­Í¼\\Ô­³æ\\stop_codon\\Eremodinium.final.condonstat.t.tail32",  header=F, row.names=NULL)
fasta_input <- as.vector(fasta_input$V1)
ggseqlogo(fasta_input, seq_type="aa",method="prob")

fasta_input <- read.table("D:\\selfsoftware\\Rstudy\\Rscript\\»­Í¼\\Ô­³æ\\stop_codon\\Eremodinium.final.condonstat.t.head32",  header=F, row.names=NULL)
fasta_input <- as.vector(fasta_input$V1)
ggseqlogo(fasta_input, seq_type="aa",method="prob")
#######################################################
fasta_input <- read.table("D:\\selfsoftware\\Rstudy\\Rscript\\»­Í¼\\Ô­³æ\\stop_codon\\Ophryoscolex.final.condonstat.t.tail32",  header=F, row.names=NULL)
fasta_input <- as.vector(fasta_input$V1)
ggseqlogo(fasta_input, seq_type="aa",method="prob")

fasta_input <- read.table("D:\\selfsoftware\\Rstudy\\Rscript\\»­Í¼\\Ô­³æ\\stop_codon\\Ophryoscolex.final.condonstat.t.head32",  header=F, row.names=NULL)
fasta_input <- as.vector(fasta_input$V1)
ggseqlogo(fasta_input, seq_type="aa",method="prob")




