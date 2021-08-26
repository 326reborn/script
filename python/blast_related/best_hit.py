import sys
args=sys.argv
import pandas as pd
df = pd.read_csv(args[1],sep="\t",names=["qseqid","sseqid","pident","length","qcovhsp","mismatch","gapopen","qlen","qstart","qend","slen","sstart","send","evalue","bitscore"])
df1=df.groupby('qseqid').apply(lambda t: t[t.bitscore==t.bitscore.max()]).round(decimals=2).reset_index(drop=True)
df1.to_csv(args[2],sep="\t",header=0,index=False)
