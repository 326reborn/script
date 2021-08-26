#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   3_utr_excepted.location.py
@Time    :   2020/01/07 16:46:13
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click
import pandas as pd
#get seqs start from the start of polyA  (ok)
def filter(file,number):#the number must be same as the number used for polyA
    f1=open(file,'r')
    dic = {}
    seq = {}
    a = eval(number)
    A = a*'A'
    for line in f1:
        if line.startswith('>'):
            name = line.strip()
            dic[name]=''
        else:
            dic[name]+=line.replace('\n','')
    for k,v in dic.items():
        protein = ''
        if v.endswith(A):
            for a in range(0,len(v)-3,3):
                if v[a:] != len(v[a:])*'A':#indentify the start of polyA
                    protein = protein + v[a:a+3]
            seq[k] = protein[::-1]#reverse for aligning 
#   print(seq)
    return seq
#convert dic to dataframe
def dic2frame(dictionary):
    frames = {}
    for k,v in dictionary.items():
        frames[k]=[]
        for a in range(0,len(v)-3,3):
            frames[k].append(v[a:a+3])
    df1 = pd.DataFrame.from_dict(frames,orient='index').T
    df2 = df1.fillna(0)
#    print(df2) #不同转录本未按行对应
    return df2
#get a dictionary for each position
def Getsize(dfT):
    dicTt={}
    for row in dfT.iterrows():
        index,fasta = row
        dicTt[index]=fasta.tolist()
    #print(dicTt)
    return dicTt

def Getaminoacid():#(ok)
    codons=[]
    protein_table = {'TTT': 'F', 'CTT': 'L', 'ATT': 'I', 'GTT': 'V', \
    'TTC': 'F', 'CTC': 'L', 'ATC': 'I', 'GTC': 'V', \
    'TTA': 'L', 'CTA': 'L', 'ATA': 'I', 'GTA': 'V', \
    'TTG': 'L', 'CTG': 'L', 'ATG': 'M', 'GTG': 'V', \
    'TCT': 'S', 'CCT': 'P', 'ACT': 'T', 'GCT': 'A', \
    'TCC': 'S', 'CCC': 'P', 'ACC': 'T', 'GCC': 'A', \
    'TCA': 'S', 'CCA': 'P', 'ACA': 'T', 'GCA': 'A', \
    'TCG': 'S', 'CCG': 'P', 'ACG': 'T', 'GCG': 'A', \
    'TAT': 'Y', 'CAT': 'H', 'AAT': 'N', 'GAT': 'D', \
    'TAC': 'Y', 'CAC': 'H', 'AAC': 'N', 'GAC': 'D', \
    'TAA': 'B', 'CAA': 'Q', 'AAA': 'K', 'GAA': 'E', \
    'TAG': 'O', 'CAG': 'Q', 'AAG': 'K', 'GAG': 'E', \
    'TGT': 'C', 'CGT': 'R', 'AGT': 'S', 'GGT': 'G', \
    'TGC': 'C', 'CGC': 'R', 'AGC': 'S', 'GGC': 'G', \
    'TGA': 'U', 'CGA': 'R', 'AGA': 'R', 'GGA': 'G', \
    'TGG': 'W', 'CGG': 'R', 'AGG': 'R', 'GGG': 'G'}
    for codon in protein_table.keys():
        codons.append(codon[::-1])#因为seq进行了reverse
#    print(codons)
    return codons

@click.command()
@click.option('-n','--number',help='A numbers for real polyA',required=True)
@click.option('-i','--infasta',help='the seq from the 3_utr_polyA_nucleotide.py',required=True)
@click.option('-o','--outfile',help='predicted protein of the seq',required=True)
def main(number,infasta,outfile):
    out = open(outfile,'w')
    codons = Getaminoacid()
    out.write('position')
    for x in codons:
        out.write('\t'+str(x[::-1]))#这里表头reverse回来方便查看
    out.write('\n')
    seq = filter(infasta,number)
    df2 = dic2frame(seq)
    dicTt = Getsize(df2)
    CodonCount = {}
    ends = []
    position = -1
#    line = []
    for k,v in dicTt.items():
        for i in range(0,len(v)):
            codon = v[i]
            CodonCount.setdefault(codon,0)
            CodonCount[codon]+=1
        ends.append(CodonCount)
        CodonCount={}    
    for a in ends:
        position += 1
        out.write(str(position))        
        for b in codons:
            if b in a.keys():
                s = str(a[b])
#            line.append(s)
                out.write("\t"+s)
            else:
                out.write("\t"+'0')
        out.write("\n")
    out.close()
if __name__ == "__main__":
    main()