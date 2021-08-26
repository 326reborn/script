#使用前需要先确认fastp可否使用
for i in `cat Acc.list`
do
/home/caiyudong/Software/fastp \
  -i ${i}_1.fastq.gz -I ${i}_2.fastq.gz \
  -o cleanData/${i}_1.fq.gz -O cleanData/${i}_2.fq.gz \
  -j cleanData/${i}.json -h cleanData/${i}.html
done
