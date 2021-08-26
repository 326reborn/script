#!/bin/bash
source ~/.bashrc
if [ $# -ne 4 ]; then
 echo "error.. need args"
 echo "command: $0 <parts_num> <balst db> <input fasta> <threads>"
 echo "Split the infasta by number of parts (parts_num) and then generating blast shells..."
 exit 1
fi
#### Arguements
parts_num=$1
BlastDB=$2
InFa=$3
Threads=$4
#### Spliting fasta files
mkdir fasta shells blastout
echo "Spliting fasta files..."
seqkit split -p ${parts_num} -O fasta ${InFa}
#### blastn
for i in `ls fasta/*.part_*.fa`
do
name=`basename $i .fa`
echo "echo ${name}" > shells/${name}.sh
echo "blastn -task blastn -db ${BlastDB} -query fasta/${name}.fa -out blastout/${name}.blastout -num_threads ${Threads} -word_size 20 -max_hsps 1 -max_target_seqs 1  -dust no -soft_masking false -evalue 0.00001 -outfmt \"6 qseqid sseqid pident qlen length mismatch gapopen qstart qend sstart send slen nident evalue bitscore qcovs\"" >> shells/${name}.sh
jys -n ${Threads} -M 20000000 -o shells/${name}.o -e shells/${name}.e -J ${name}.blastx bash shells/${name}.sh
#cpu -n ${Threads} -M 20000000 -o shells/${name}.o -e shells/${name}.e -J ${name}.blastx bash shells/${name}.sh
done
