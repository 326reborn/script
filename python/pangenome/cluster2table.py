#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   cluster2table.py
@Time    :   2021/01/26 10:57:36
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib

import click
import random
#get sample name as list
def getlist(samplelist):
    list1=[]
    f1=open(samplelist,'r')
    for i in f1:
        list1.append(str(i.strip()))
    return list1

@click.command()
@click.option('-i','--incluster',help='input the cd-hit clstr file',required=True)
@click.option('-s','--samplelist',help='input the lists of sample name',required=True)
@click.option('-o','--outfile',help='the table of cluster stat',required=True)
#@click.option('-c','--outcore',help='the list of coregene',required=True)

def main(incluster,samplelist,outfile):
    lists=getlist(samplelist)
    f1=open(incluster,'r')
    f2=open(outfile,'w')
    head='\t'.join(lists)
    f2.write(f'Clusters\t{head}\n')
    n=0
    for line in f1:
        if line.startswith('>'):
            if n==0:
                cluster = line.strip().replace(' ','')
                stat=dict.fromkeys(lists,0)#get dict{keys:0}
                n+=1
            else:
                genecounts=[]
                for i in lists:
                    genecounts.append(str(stat.get(i)))
                counts='\t'.join(genecounts)
                f2.write(f'{cluster}\t{counts}\n')
                cluster = line.strip().replace(' ','')
                stat=dict.fromkeys(lists,0)#get dict{keys:0}
                n+=1
        else:
            line='.'.join(line.split(' ')[1].split('.')[0:3]).replace('>','')#get sample name from gene
            if line in stat.keys():
                stat[line]+=1
if __name__ == '__main__':
    main()
