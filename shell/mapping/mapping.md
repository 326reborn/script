# 二代read比对

主要参考下面超链接
>(https://github.com/silvewheat/bioNotes/tree/master/02_readsMapping)

[bwa](https://github.com/lh3/bwa) 软件实现了三种比对算法 BWA-backtrack, BWA-SW 和 BWA-MEM。   
第一种算法适用于长度在 100bp 以下的 reads，后两种算法适用于70bp至数M的长 reads。BWA-MEM 是最新的算法，70bp以上的 reads 用 BWA-MEM 就好，70b p以下的用 BWA-backtrack。

------
## 比对mapping

快速生成bwa-mem的脚本路径：
`/stor9000/apps/users/NWSUAF/2015010778/05_software/python/produce_bwa_mem.py`  
```
python3 \
    produce_bwa_mem.py \
    --ref ref.fa \ ##参考基因组的路径
    --outdir outdir \ ##输出文件的路径
    --bwa bwa \ ##bwa的路径
    --samtools samtools \ ##samtools的路径
    --nt 4 \ ##线程数
    /*.fq.gz ##fastq文件 
``` 

```
bwa \
    mem \
    -t 4 \
    -R '@RG\tID:sample1_library1_lane1\tLB:library1\tPL:ILLUMINA\tSM:sample1' \
    reference.fa \
    sample1_library1_lane1_1.clean.fq.gz \
    sample1_library1_lane1_2.clean.fq.gz | \
samtools \
    fixmate \
    - - | \
samtools \
    sort \
    --reference reference.fa \   
    -o sample1_library1_lane1.bam \
    --output-fmt BAM \
    -
```
1.-t 是线程数  -R bam文件的header  
2.通常来说，这步得到的文件还需要使用 picard 去除 PCR 重复，如果后续不使用 picard 去重（或者只使用 samtools 去重） 的话，这一步可以直接生成 cram 文件，即把 --output-fmt BAM 改为 CRAM ，同时把 -o 的文件名后缀改为.cram  
3.这里使用了samtools fixmate来修复一些bwa直接输出的FLAG（以更好地兼容下游软件）。  

----
## picard去重
生成picard去重软件的脚本：
`/stor9000/apps/users/NWSUAF/2015010778/05_software/python/produce_picard_dedup_bam.py`  
```
python \
produce_picard_dedup_bam.py \
    --ref ref.fa \ ##参考基因
    --outdir outdir \ ##输出路径
    --picard picard.jar \ ##picard路径
    --tmpdir tmp \ ##临时文件
    --mem 10 \ ##运行内存 单位GB
    --samtools samtools \ ## samtools路径
    SRR*[0-9].bam ##bam文件
```
```
java -Djava.io.tmpdir=/stor9000/apps/users/NWSUAF/2012010954/tmp \
    -Xmx10g \
    -jar picard.jar \
    MarkDuplicates \
    I=SRR*.bam \
    O=SRR*.dedup.bam
    M=SRR*.marked_du
    REMOVE_DUPLICATES=true \ ##去重
    VALIDATION_STRINGENCY=LENIENT ## 

/stor9000/apps/users/NWSUAF/2012010954/Software/samtools/samtools-1.10/samtools \
    index \
    SRR*.dedup.bam
```
-----
## 矫正bam文件
生成矫正bam脚本路径：
`/stor9000/apps/users/NWSUAF/2015010778/05_software/python/produce_gatk_realn_bam.py`  
例如：
```
/stor9000/apps/users/NWSUAF/2012010954/Software/Anaconda4.4_py3.6/bin/python produce_gatk_realn_bam.py \
    --ref ref.fa \
    --outdir out \
    --gatk /stor9000/apps/users/NWSUAF/2012010954/Software/GATK3.8/GenomeAnalysisTK.jar \
    --samtools /stor9000/apps/users/NWSUAF/2012010954/Software/samtools/samtools-1.10/samtools \
    --tmpdir /stor9000/apps/users/NWSUAF/2012010954/tmp \
    --mem 4 \ 
    --nt 8 \ 
    *dedup.bam
```
先提交RTC.sh再提交IR.sh脚本  
例如RTC.sh
```
java -Djava.io.tmpdir=/stor9000/apps/users/NWSUAF/2012010954/tmp \
    -Xmx32g \
    -jar /stor9000/apps/users/NWSUAF/2012010954/Software/GATK3.8/GenomeAnalysisTK.jar \
    -T RealignerTargetCreator \
    -R /stor9000/apps/users/NWSUAF/2012010954/Genome/ASM_gaot/ASM.fa \
    -I /stor9000/apps/users/NWSUAF/2012010954/02_AncientDNA/01_data/NewIbex/02_BAM/out/SRR8437791.dedup.bam \
    -nt 8 \ 
    -o /stor9000/apps/users/NWSUAF/2012010954/02_AncientDNA/01_data/NewIbex/02_BAM/out/SRR8437791.RTC.intervals 
    -allowPotentiallyMisencodedQuals \
    && \
    echo 'RealignerTargetCreator Done'

```
例如IR.sh:
```
java -Djava.io.tmpdir=/stor9000/apps/users/NWSUAF/2012010954/tmp \
    -Xmx4g \
    -jar /stor9000/apps/users/NWSUAF/2012010954/Software/GATK3.8/GenomeAnalysisTK.jar \
    -T IndelRealigner \
    -R /stor9000/apps/users/NWSUAF/2012010954/Genome/ASM_gaot/ASM.fa \
    -I /stor9000/apps/users/NWSUAF/2012010954/02_AncientDNA/01_data/NewIbex/02_BAM/out/SRR8437784.dedup.bam \
    -targetIntervals /stor9000/apps/users/NWSUAF/2012010954/02_AncientDNA/01_data/NewIbex/02_BAM/out/SRR8437791.RTC.intervals#上一步-o输出结果
    -allowPotentiallyMisencodedQuals \
    -o /stor9000/apps/users/NWSUAF/2012010954/02_AncientDNA/01_data/NewIbex/02_BAM/out/SRR8437784.realn.bam \
    && \
    echo 'IndelRealigner Done' \
    && \
/stor9000/apps/users/NWSUAF/2012010954/Software/samtools/samtools-1.10/samtools \
    index \
    /stor9000/apps/users/NWSUAF/2012010954/02_AncientDNA/01_data/NewIbex/02_BAM/out/SRR8437784.realn.bam
```




