#!bash
/stor9000/apps/users/NWSUAF/2012010954/Software/muscle/muscle3.8.31_i86linux64 -in 18S.fasta -out 18S.muscle.fa
#3.构树
/stor9000/apps/users/NWSUAF/2012010954/Software/iqtree-1.6.6.a-Linux/bin/iqtree \
	-s 18S.muscle.fa \
	-bb 1000 \
	-nt 6 -m GTR+I+Γ
