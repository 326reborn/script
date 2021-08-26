#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   stopcodon_rate.py
@Time    :   2020/01/02 16:16:48
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click

def polyA(file,number):
    f1=open(file,'r')
    dic={}
    poly={}
    a = eval(number)
    A = a*'A'
    T = a*'T'
    for line in f1:
        if line.startswith('>'):
            name = line.strip().split(' ')[0].split('>')[1]
            dic[name]=''
        else:
            dic[name]+=line.replace('\n','')
    for k,q in dic.items():
        if q.startswith(A):
            x=0
            while q[x] == 'A':
                x=x+1
            if 'AATAA' in q[:x+29] or 'AATTA' in q[:x+29] or 'AAATA' in q[:x+29]:
                name = k
                poly[name] = []
                poly[name].append(q)
        elif q.startswith(T):
            x=0
            while q[x] == 'T':
                x=x+1
            if 'TTATT' in q[:x+29] or 'TTAAT' in q[:x+29] or 'TTTAT' in q[:x+29]:
                name = k
                poly[name] = []
                poly[name].append(q)
                poly[name].append('-')           
        elif q.endswith(A):
            x=-1
            while q[x] == 'A':
                x=x-1
            if 'AATAA' in q[x-30:] or 'ATTAA' in q[x-30:] or 'ATAAA' in q[x-30:]:
                name = k
                poly[name] = []
                poly[name].append(q)
        elif q.endswith(T):
            x=-1
            while q[x] == 'T':
                x=x-1
            if 'TTATT' in q[x-30:] or 'TAATT' in q[x-30:] or 'TATTT' in q[x-30:]:
                name = k
                poly[name] = []
                poly[name].append(q)
                poly[name].append('-')
    return poly

def Getblast(set_blast):
    with open(set_blast) as Blast:
        blast_dict = {}
        key = 'null'
        blast_dict[key] = ''
        for i in Blast:
            if  i != '' :
                if key != i.strip().split("\t")[0]:
                    key = i.strip().split("\t")[0]
                    blast_dict[key] = []                                
                    if int(i.split("\t")[7]) <= int(i.split("\t")[8]):
                        value = i.split("\t")[8]
                    elif int(i.split("\t")[7]) > int(i.split("\t")[8]):
                        value = int(i.split("\t")[8])*-1
                    blast_dict[key].append(value)
                else:
                    if int(i.split("\t")[7]) <= int(i.split("\t")[8]):
                        value = i.split("\t")[8]
                    elif int(i.split("\t")[7]) > int(i.split("\t")[8]):
                        value = int(i.split("\t")[8])*-1
                    blast_dict[key].append(value)
    return blast_dict

def DNA_complement(sequence):
	sequence=sequence.upper()
	sequence=sequence.replace('A','t')
	sequence=sequence.replace('G','c')
	sequence=sequence.replace('T','a')
	sequence=sequence.replace('C','g')
	return sequence.upper()

def DNA_reverse(sequence):
	sequence=sequence.upper()
	return sequence[::-1]

@click.command()
@click.option('-n','--number',help='a number for real polyA',required=True)
@click.option('-b','--blastfile',help='result of blast',required=True)
@click.option('-i','--infasta',help='the seq of the query',required=True)
#@click.option('-s','--stat',help='the statistics of the stop codon',required=True)
@click.option('-o','--outfile',help='predicted protein of the seq',required=True)

def main(number,blastfile,infasta,outfile):
    poly = polyA(infasta,number)
    blast_dict = Getblast(blastfile)
#    f1 = open(stat,'w')
    f2 = open(outfile,'w')
    utr = {}
    for k,v in poly.items():
        if k in blast_dict.keys():
            n=0
            for i in blast_dict.get(k):
                n=n+1
                name =k+str(n)
                if int(i) < 0:#这里分别应加上反向和互补两种情况，T进行互补，《0进行反向
                    if len(v) != 1:
                        seq_com=DNA_complement(v[0])
                        seq_rev=DNA_reverse(seq_com)
                        utr[name] = seq_rev[int(i)+1:]
                    if len(v) == 1:
                        seq_rev=DNA_reverse(v[0])
                        utr[name] = seq_rev[int(i)+1:]
                else:
                    if len(v) != 1:
                        seq_com=DNA_complement(v[0])
                        utr[name] = seq_com[int(i)+1:]
                    if len(v) == 1:
                        utr[name] = v[0][int(i)+1:]
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
	'TGG': 'W', 'CGG': 'R', 'AGG': 'R', 'GGG': 'G'
	}
    for k,v in utr.items():
        protein = ''
        for a in range(0,len(v)-3,3):
            protein = protein +  protein_table[v[a:a+3]]
#        U_num = protein.count("U")
#        O_num = protein.count("O")
#        B_num = protein.count("B")
#        U_density = round(protein.count("U")*1.00/len(protein),2)
#        O_density = round(protein.count("O")*1.00/len(protein),2)
#        B_density = round(protein.count("B")*1.00/len(protein),2)
#        f1.write(k + "\t" + str(B_num) + "\t" +  str(B_density) + "\t"+ str(O_num) +"\t"+  str(O_density) + "\t"+ str(U_num) +"\t" + str(U_density)+"\t" + str(len(protein)) + "\n")
        f2.write(">"+k+"\n"+protein+"\n")
#    f1.close()
    f2.close()
if __name__ == '__main__':
    main()