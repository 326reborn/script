export query=$1
export subject=$2
export name=$3
#subject时无法多线程
/stor9000/apps/users/NWSUAF/2015050469/anaconda3/bin/blastn -query ${query} -subject ${subject} -outfmt '6 qseqid sseqid pident length qcovs qcovhsp mismatch gapopen gaps qstart qend sstart send evalue bitscore' -out ${name}.blast6
