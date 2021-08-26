export database=$1
export dbname=$2
export query=$3
export out=$4
/stor9000/apps/users/NWSUAF/2016050001/software/diamond makedb --in ${database} -d ${dbname}
/stor9000/apps/users/NWSUAF/2016050001/software/diamond blastp --db ${dbname} --query ${query} -p 8 --more-sensitive --max-target-seqs 2 --outfmt 6 qseqid sseqid pident length qcovhsp mismatch gapopen qlen qstart qend slen sstart send evalue bitscore --out ${out}
