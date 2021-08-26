export species1=$1
#used for one specie
cd /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/01.diamond_result
/stor9000/apps/users/NWSUAF/2016050001/software/diamond blastp --db /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/00.data/${species1}_db --query /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/00.data/${species1}.pep.faa -p 8 --more-sensitive --max-target-seqs 2 --outfmt 6 qseqid sseqid pident length qcovhsp mismatch gapopen qlen qstart qend slen sstart send evalue bitscore --out ${species1}_self.diamond
#get RBH homologs
awk '$1!=$2&&$14+0<1e-20' ${species1}_self.diamond|cut -f1,2|sort -u > ${species1}_self.list
awk '$1!=$2&&$14+0<1e-20' ${species1}_self.diamond|cut -f1,2|sort -u|awk '{print $2"\t"$1}' > ${species1}_self_r.list
cat ${species1}_self_r.list ${species1}_self.list|sort|uniq -c|awk -F' ' '{if($1>1) {print $2"\t"$3}}' > ${species1}_self.homolog_pre
python3 /stor9000/apps/users/NWSUAF/2015010719/script/python/filter_samelen_list.py -i ${species1}_self.homolog_pre -o ${species1}_self.homolog_list
perl -e 'open(IN1, shift); open(IN2, shift); while(<IN1>){chomp; @A=split/\s+/; $hash{$A[0]}=$_} while(<IN2>){chomp; @B=split/\s+/; print $_,"\t",$hash{$B[0]},"\n"}' ${species1}_self.homolog_pre  ${species1}_self.homolog_list |  awk '{$1="";print $0}'  | sed -e 's/^\s*//'  | sed 's/ /\t/g' > ${species1}_self.homolog
#prepare for paml
mkdir /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/03.specie_self_Ka_Ks/${species1}_self.paml_Ka_Ks
cd /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/03.specie_self_Ka_Ks/${species1}_self.paml_Ka_Ks
cp ../../ParaAT.sh ./
cp ../../proc ./
cp ../../codeml.ctl ./
cp ../../tree ./
cp /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/01.diamond_result/${species1}_self.homolog ./
ln -s /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/00.data/${species1}.cds.fa ./
ln -s /stor9000/apps/users/NWSUAF/2015010719/rumen_microorganism/04.compare_genom/04.Ka_Ks/00.data/${species1}.pep.faa ./
bash ParaAT.sh ${species1}_self.homolog ${species1}.cds.fa ${species1}.pep.faa ${species1}_self
cat ${species1}_self_paml_result/* > ${species1}_self.cod
