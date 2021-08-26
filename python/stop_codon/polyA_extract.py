#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   polyA_extract.py
@Time    :   2020/01/01 11:24:16
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click
@click.command()
@click.option('-i','--infile',help='input the transcript file',required=True)
@click.option('-o','--outfile',help='output the file with seqs that have polyA',required=True)
@click.option('-n','--number',help='a number for real polyA',required=True)
def extract(infile,outfile,number):
    f1=open(infile,'r')
    f2=open(outfile,'w')
    dic={}
    a = eval(number)
    A = a*'A'
    T = a*'T'
    for line in f1:
        if line.startswith('>'):
            name = line.strip()
            dic[name]=''
        else:
            dic[name]+=line.replace('\n','')
    for k,q in dic.items():
        if q.startswith(A) or q.endswith(A) or q.startswith(T) or q.endswith(T):
            f2.write(k+'\n'+q+'\n')
    f1.close()
    f2.close()
if __name__ == "__main__":
    extract()