export species1=$1
export species2=$2
#used for two species
cd /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/01.diamond_result
/stor9000/apps/users/NWSUAF/2016050001/software/diamond blastp --db /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/00.data/${species1}_db --query /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/00.data/${species2}.pep.faa -p 8 --more-sensitive --max-target-seqs 1 --outfmt 6 qseqid sseqid pident length qcovhsp mismatch gapopen qlen qstart qend slen sstart send evalue bitscore --out ${species1}_${species2}.diamond
/stor9000/apps/users/NWSUAF/2016050001/software/diamond blastp --db /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/00.data/${species2}_db --query /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/00.data/${species1}.pep.faa -p 8 --more-sensitive --max-target-seqs 1 --outfmt 6 qseqid sseqid pident length qcovhsp mismatch gapopen qlen qstart qend slen sstart send evalue bitscore --out ${species2}_${species1}.diamond
#get RBH homologs
awk '$14+0<1e-20' ${species1}_${species2}.diamond|cut -f1,2|sort -u > ${species1}_${species2}.list
awk '$14+0<1e-20' ${species2}_${species1}.diamond|cut -f1,2|sort -u|awk '{print $2"\t"$1}' > ${species2}_${species1}_r.list
cat ${species2}_${species1}_r.list ${species1}_${species2}.list|sort|uniq -c|awk -F' ' '{if($1>1) {print $2"\t"$3}}' > ${species1}_${species2}.homolog
#prepare for paml
mkdir /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/02.2species_Ka_Ks/${species1}_${species2}.paml_Ka_Ks
cd /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/02.2species_Ka_Ks/${species1}_${species2}.paml_Ka_Ks
cp ../../ParaAT.sh ./
cp ../../proc ./
cp ../../codeml.ctl ./
cp ../../tree ./
cp /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/01.diamond_result/${species1}_${species2}.homolog ./
cat /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/00.data/${species1}.cds.fa /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/00.data/${species2}.cds.fa > ${species1}_${species2}.cds.fa
cat /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/00.data/${species1}.pep.faa /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/00.data/${species2}.pep.faa > ${species1}_${species2}.pep.faa
bash ParaAT.sh ${species1}_${species2}.homolog ${species1}_${species2}.cds.fa ${species1}_${species2}.pep.faa ${species1}_${species2}
cat ${species1}_${species2}_paml_result/* > ${species1}_${species2}.cod
