# call SNP
脚本call snp主要用到[bcftools](http://samtools.github.io/bcftools/bcftools.html)软件：
```
chrom=$1
/stor9000/apps/users/NWSUAF/2012010954/Software/bcftools/bcftools-1.10.2/bcftools \
        mpileup \
        -A \
        -C 50 \
        -q 30 \
        -Q 20 \
        -r $chrom \
        -a INFO/AD,FORMAT/AD,FORMAT/DP,FORMAT/ADF,FORMAT/ADR \
        -f /stor9000/apps/users/NWSUAF/2012010954/Genome/ASM_gaot/ASM.fa \
        -b BAM.list | \
/stor9000/apps/users/NWSUAF/2012010954/Software/bcftools/bcftools-1.10.2/bcftools \
        call \
        -v \
        -m \
        -f GQ,GP \
        --threads 3 \
        -O z \
        -o outVcfs/chr${chrom}.raw.vcf.gz

/stor9000/apps/users/NWSUAF/2012010954/Software/bcftools/bcftools-1.10.2/bcftools \
        index \
        outVcfs/chr${chrom}.raw.vcf.gz
```

--------

mpileup命令可以避免数据导入bcftools时产生的bcftools与samtools版本不兼容导致的错误。  
-A 是指保留variant calling  
-C 调整包括对错误匹配的容忍度，默认为50 ##我的理解。  
-r 指基因区域  
-a 注释列表  
-f 参考基因组  
-b BAM文件绝对路径 
-q 比对的最小质量  
-Q 考虑的基础最低质量 

call命令中  
-v 只输出变异  
-m 对于多等位基因和rare-variant的一种call模式。与-c冲突  

-----

## 过滤vcf






