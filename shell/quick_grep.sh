export file=$1
export list=$2
perl -e 'open(IN1, shift); open(IN2, shift); while(<IN1>){chomp; @A=split/\s+/; $hash{$A[0]}=$_} while(<IN2>){chomp; @B=split/\s+/; print $_,"\t",$hash{$B[0]},"\n"}' ${file} ${list} |  awk '{$1="";print $0}'  | sed -e 's/^\s*//'  | sed 's/ /\t/g'|grep -v '^$'
