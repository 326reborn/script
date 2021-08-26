#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   blat.mapped_region.py
@Time    :   2019/12/02 11:16:16
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click

@click.command()
@click.option('--infile')
@click.option('--outfile')

def region(infile,outfile):
    target = 'null'
    start = '1'
    end ='1'
    region = {}
    length = {}
    n = 0
    region[target] = []
    df1=open(infile,'r')
    df2=open(outfile,'w')
    for line in df1:
        transcript=line.split('\t')[0]
        contig =line.split('\t')[5]
        cstart=line.split('\t')[6]
        cend = line.split('\t')[7]
        if target != contig:
            region[target].append([start,end])
            n = eval(end) - eval(start) + n
            length[target] = n
            n = 0
            target = contig
            start = cstart
            end = cend
            region[target] = []
        else:
            if (eval(end)-10) < eval(cstart):#这里的10代表至少重合10个碱基才可认为是一个基因,可自行调整
                region[target].append([start,end])
                n = eval(end) - eval(start) + n
                start = cstart
                end = cend
            else:
                end = cend
    region[target].append([start,end])
    n = eval(end) - eval(start) + n
    length[target] = n
    for k,v in region.items():
        df2.write(k+"\t"+str(len(v))+"\t"+str(length.get(k))+"\t"+str(v)+"\n")
    df2.close()
if __name__ == "__main__":
    region()

