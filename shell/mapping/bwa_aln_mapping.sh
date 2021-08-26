#!/bin/sh
export fastq1=$1
export fastq2=$2
export prefix=$3
export ref=$4
/stor9000/apps/users/NWSUAF/2012010954/Software/bwa-0.7.17/bwa aln -n 0.01 -o 1 -e 50 -i 15 -L -l 32 -t 4 -q 10 -f $prefix\_1.sai $ref $fastq1
/stor9000/apps/users/NWSUAF/2012010954/Software/bwa-0.7.17/bwa aln -n 0.01 -o 1 -e 50 -i 15 -L -l 32 -t 4 -q 10 -f $prefix\_2.sai $ref $fastq2
#/stor9000/apps/users/NWSUAF/2012010954/Software/bwa-0.7.17/bwa sampe -r '@RG\tID:'$prefix'\tLB:'$prefix'\tPL:ILLUMINA\tSM:'$prefix'' -a 800 $ref $prefix\_1.sai $prefix\_2.sai $fastq1 $fastq2 | /stor9000/apps/users/NWSUAF/2012010954/Software/samtools1.9/bin/samtools view -b -S -o $prefix.bam
