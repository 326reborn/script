#!/bin/bash
source ~/.bashrc
if [ $# -ne 4 ]; then
 echo "error.. need args"
 echo "command:$0 <parts_num> <infasta> <targetdb> <Threads>"
 echo "Split the infasta by number of parts (parts_num) and then generating blast shells..."
 exit 1
fi
#### Arguments
parts_num=$1
infasta=$2
targetdb=$3
Threads=$4
#### Spliting fasta files
mkdir fasta shells blastout
echo "Spliting fasta files..."
seqkit split -p ${parts_num} -O fasta ${infasta}
#### megablast
for i in `ls fasta/*.part_*.fa`
do
name=`basename $i .fa`
echo "echo ${name}" > shells/${name}.sh
echo "blastn -task megablast -db ${targetdb} -query fasta/${name}.fa -max_hsps 1 -out blastout/${name}.blastout -max_target_seqs 1 -num_threads ${Threads} -evalue 0.00001 -outfmt \"6 qseqid sseqid pident qlen length mismatch gapopen qstart qend sstart send evalue bitscore qcovs\"" >> shells/${name}.sh
jys -n ${Threads} -M 20000000 -o shells/${name}.o -e shells/${name}.e -J ${name}.megablast bash shells/${name}.sh
done
