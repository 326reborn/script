#!/bin/sh
export fastq1=$1
export fastq2=$2
export prefix=$3
export ref=$4
#/stor9000/apps/users/NWSUAF/2012010954/Software/bwa-0.7.17/bwa index -a bwtsw ${ref}
#samtools faidx ${ref}
/stor9000/apps/users/NWSUAF/2012010954/Software/bwa-0.7.17/bwa mem -t 4 -R "@RG\tID:'$prefix'\tLB:'$prefix'\tPL:ILLUMINA\tSM:'$prefix'" -M ${ref} ${fastq1} ${fastq2}|samtools view -@ 4 -b -S -o $prefix.bam
samtools sort -@ 4 $prefix.bam > 02.bwa_mem/$prefix.sort.bam
rm $prefix.bam
#samtools depth 02.bwa_mem/$prefix.sort.bam > $prefix.sort.depth
