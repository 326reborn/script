export SENTIEON_TMPDIR=/stor9000/apps/users/NWSUAF/2013130172/software/tmp
export bwt_max_mem=20G
#cd ~/rumen_microbes/singlecell/01.genomic/01.assemble/05.genomic.V2
#cd index
#ln -s ../${1}.genomic.fa .
#bwa index ${1}.genomic.fa
#makeblastdb -dbtype nucl -in ${1}.genomic.fa
cd ~/rumen_microbes/singlecell/01.genomic/01.assemble/06.genomic.assessment/01.SNP/01.bam
/stor9000/apps/users/NWSUAF/2012010954/Software/Sentieon/sentieon-genomics-201911/bin/sentieon bwa mem -t 6 -k 25 \
 -M -R '@RG\tID:${1}-V\tLB:${1}\tPL:ILLUMINA\tSM:${1}' ~/rumen_microbes/singlecell/01.genomic/01.assemble/05.genomic.V2/index/${1}.genomic.fa ~/rumen_microbes/singlecell/01.genomic/00.cleandata/${1}_1.fq.gz \
 ~/rumen_microbes/singlecell/01.genomic/00.cleandata/${1}_2.fq.gz | \
 /stor9000/apps/users/NWSUAF/2012010954/Software/Sentieon/sentieon-genomics-201911/bin/sentieon util sort -t 6  --sam2bam \
 -o ${1}.sort.bam -i -
/stor9000/apps/users/NWSUAF/2012010954/Software/samtools1.9/bin/samtools flagstat ${1}.sort.bam > ${1}.sort.bam.txt
cd ~/rumen_microbes/singlecell/01.genomic/01.assemble/06.genomic.assessment/01.SNP/02.vcf
samtools faidx ~/rumen_microbes/singlecell/01.genomic/01.assemble/05.genomic.V2/index/${1}.genomic.fa
/stor9000/apps/users/NWSUAF/2012010954/Software/samtools1.9/bin/samtools sort -@ 6 -n ../01.bam/${1}.sort.bam >${1}.sort1.bam
filterBam --in ${1}.sort1.bam --out ${1}.filter.bam --paired --insertLimit 500 --uniq --minCover 70 --minId 94 --pairwiseAlignments
/stor9000/apps/users/NWSUAF/2012010954/Software/samtools1.9/bin/samtools sort ${1}.filter.bam > ${1}.sort.bam
samtools index ${1}.sort.bam
rm -f ${1}.sort1.bam ${1}.filter.bam
#建 ref 的 dict file 这里需要保证dict的名字与fa文件一致 如prefix.genomic.fa的dict必须为prefix.genomic.dict
/stor9000/apps/appsoftware/BioSoftware/bin/java -jar /stor9000/apps/users/NWSUAF/2015060152/bin/picard_2.18.17.jar CreateSequenceDictionary R=~/rumen_microbes/singlecell/01.genomic/01.assemble/05.genomic.V2/index/${1}.genomic.fa O=~/rumen_microbes/singlecell/01.genomic/01.assemble/05.genomic.V2/index/${1}.genomic.dict
source /stor9000/apps/users/NWSUAF/2012010954/.bashrc
export SENTIEON_TMPDIR=/stor9000/apps/users/NWSUAF/2013130172/software/tmp
export bwt_max_mem=20G
/stor9000/apps/users/NWSUAF/2012010954/Software/Sentieon/sentieon-genomics-201911/bin/sentieon \
    driver -t 8  -i ${1}.sort.bam \
    --algo LocusCollector \
    --fun score_info ${1}.score.txt.gz
/stor9000/apps/users/NWSUAF/2012010954/Software/Sentieon/sentieon-genomics-201911/bin/sentieon \
    driver -t 8  -i ${1}.sort.bam \
    --algo Dedup  --rmdup --score_info ${1}.score.txt.gz \
    ${1}.sort.dedup.bam
java -Djava.io.tmpdir=/stor9000/apps/users/NWSUAF/2013130172/software/tmp -Xmx32g -jar /stor9000/apps/users/NWSUAF/2012010954/Software/GATK3.8/GenomeAnalysisTK.jar -T RealignerTargetCreator \
  -R ~/rumen_microbes/singlecell/01.genomic/01.assemble/05.genomic.V2/index/${1}.genomic.fa -I ${1}.sort.dedup.bam -nt 8 -o ${1}.interval -allowPotentiallyMisencodedQuals
/stor9000/apps/users/NWSUAF/2012010954/Software/Sentieon/sentieon-genomics-201911/bin/sentieon \
    driver  -t 8 \
    -r ~/rumen_microbes/singlecell/01.genomic/01.assemble/05.genomic.V2/index/${1}.genomic.fa \
    -i ${1}.sort.dedup.bam \
    --algo Realigner --interval_list ${1}.interval \
    ${1}.sort.realigned.bam
#call snp
/stor9000/apps/users/NWSUAF/2012010954/Software/Sentieon/sentieon-genomics-201911/bin/sentieon \
    driver \
    -t 8 \
    -r ~/rumen_microbes/singlecell/01.genomic/01.assemble/05.genomic.V2/index/${1}.genomic.fa \
    -i ${1}.sort.realigned.bam \
    --interval ${1}.interval \
    --algo Haplotyper \
    --min_base_qual 10 \
    --call_conf 10 --emit_conf 10 \
    --emit_mode VARIANT   ${1}.vcf
rm -f ${1}.sort.dedup.bam*
/stor9000/apps/users/NWSUAF/2012010954/Software/bcftools1.9/bin/bcftools view -m2 -M2 -v snps ${1}.vcf |/stor9000/apps/users/NWSUAF/2012010954/Software/bcftools1.9/bin/bcftools query -i 'QUAL>20&&FORMAT/DP>20' -f '%CHROM\t%POS\t%REF\t%ALT\t%QUAL[\t%DP\t%AD\t%GT]\n'|sed 's/,/\t/g' > ${1}.1allele.snp_table
#chromosome position ref.frequency allele.frequency heterozygosity
awk 'BEGIN{FS="\t";OFS="\t"} $7+$8>=20 {print $1,$2,$7/($8+$7),$8/($8+$7)}' ${1}.1allele.snp_table|awk 'BEGIN{FS="\t";OFS="\t"} {print $0,1-$3^2-$4^2}' > ${1}.1allele.heterozygosity
/stor9000/apps/users/NWSUAF/2012010954/Software/Anaconda4.4_py3.6/bin/python3.6 /stor9000/apps/users/NWSUAF/2015010719/script/python/chromosome_snp_tj2.py -i ${1}.1allele.heterozygosity -o ${1}.tj
#chrom length snp/length variant_allele_FRACTION mean_snp_het
awk -F'_' 'BEGIN{OFS="\t"} {print $1"_"$2"_"$3,$4}' ${1}.tj|awk 'BEGIN{FS=OFS="\t"} {print $1"_"$2,$2,$3/$2,$4,$5}' > ${1}.chrom_SNP.het
/stor9000/apps/appsoftware/BioSoftware/bin/Rscript ~/software/py/snp_hist.r ${1}.chrom_SNP.het ${1}.chrom_SNP.pdf
/stor9000/apps/users/NWSUAF/2012010954/Software/samtools1.9/bin/samtools flagstat ${1}.sort.bam > ${1}.sort.bam.txt
cp ../01.bam/${1}.sort.bam.txt ${1}.sort1.bam.txt
Len=`grep "read1" ${1}.sort1.bam.txt |awk '{print $1}'`
Num=`grep "read2" ${1}.sort1.bam.txt |awk '{print $1}'`
Num1=`grep "read1" ${1}.sort.bam.txt |awk '{print $1}'`
Len1=`grep "read2" ${1}.sort.bam.txt |awk '{print $1}'`
echo -e "${1}\n${Num}\n${Len}\n${Num1}\n${Len1}" >${1}.snp.info 
samtools depth -aa ${1}.sort.bam |awk '{print $1,$2,$2+1,$3}' OFS="\t" > ${1}.sort.bam.readdepth.bed
bedtools merge -i ${1}.sort.bam.readdepth.bed -o median,mean,max,min -c 4 -d 100000000 > ${1}.sort.bam.readdepth.statistics
rm -f ${1}.sort.bam.readdepth.bed
NUM2=`awk '{print $5}' ${1}.sort.bam.readdepth.statistics|awk '{sum+=$1} END {print sum/NR}'`
NUM3=`awk '{print $5}' ${1}.sort.bam.readdepth.statistics|awk 'BEGIN {max = 0} {if ($1+0 > max+0) max=$1} END {print  max}'`
NUM4=`awk '{print $5}' ${1}.sort.bam.readdepth.statistics|awk  'BEGIN {min = 88888} {if ($1+0 < min+0) min=$1} END {print min}'`
echo -e "read.depth\n${NUM2}\n${NUM3}\n${NUM4}" >> ${1}.snp.info
echo -e "snp" >> ${1}.snp.info
less ${1}.1allele.snp_table |wc -l >> ${1}.snp.info
awk '$3>=0.005' ${1}.chrom_SNP.het |wc -l >> ${1}.snp.info
NUM1=`cat ${1}.chrom_SNP.het |wc -l` 
NUM2=`awk '{print $4}' ${1}.chrom_SNP.het |awk '{sum+=$1} END {print sum/NR}'`
NUM3=`awk '{print $4}' ${1}.chrom_SNP.het |awk 'BEGIN {max = 0} {if ($1+0 > max+0) max=$1} END {print  max}'`
NUM4=`awk '{print $4}' ${1}.chrom_SNP.het |awk  'BEGIN {min = 88888} {if ($1+0 < min+0) min=$1} END {print min}'`
echo -e "${NUM1}\n${NUM2}\n${NUM3}\n${NUM4}" >> ${1}.snp.info
