awk '{for(i=2;i<=3;i++)$i="";print $0}' N0.tsv |tail -n +2|sed 's/\r//g'|sed 's/   /: /g'|sed 's/,//g' > Phylogenetic_Hierarchical.Orthogroups
