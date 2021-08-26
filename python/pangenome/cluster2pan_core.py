#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   cluster2pan_core.py
@Time    :   2020/07/07 16:42:15
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''
import click
import random

def sample(incluster,number):
    dic={}#以个体为键存cluster
    core={}#以cluster为键存个体
    real_core=[]
    f1=open(incluster,'r')
    for line in f1:
        if line.startswith('>'):
            gene = line.strip().replace(' ','')
            core[gene]=[]
        else:
            line='.'.join(line.split(' ')[1].split('.')[0:3])
            if line in core.get(gene):
                pass
            else:
                core[gene].append(line)
            if line in dic.keys():
                dic[line].append(gene)
            else:
                dic[line]=[]
                dic[line].append(gene) 
    for k in core.keys():
        if len(core.get(k)) == eval(number):
            real_core.append(k)
    return dic,real_core

@click.command()
@click.option('-i','--incluster',help='input the cd-hit clstr file',required=True)
@click.option('-n','--number',help='input the total number of samples',required=True)#用于算core gene
@click.option('-p','--outpan',help='the result of random combinations data for pangene',required=True)
@click.option('-c','--outcore',help='the list of coregene',required=True)

def main(incluster,outpan,outcore,number):
    dic,real_core=sample(incluster,number)
    of1=open(outpan,'w')
    of2=open(outcore,'w')
    for i in range(0,100):#100次抽样
        pan_count=[]
        for m in range(1,eval(number)+1):#随机抽样组合C1-Cn
            samples=random.sample(dic.keys(),m)
            pan_list=[]
            for x in samples:
                pan_list=pan_list + dic.get(x)
            uniq=list(set(pan_list))#对基因进行去重
            pan_genes=len(uniq)
            pan_count.append(str(pan_genes))
            #for g in uniq:
                #if g in real_core:
                    #core_list.append(g)
            #core_genes=len(core_list)
            #core_count.append(str(core_genes))
        p='\t'.join(pan_count)
        #c='\t'.join(core_count)
        of1.write(f'{p}\n')
    for r in real_core:
        of2.write(f'{r}\n')
if __name__ == '__main__':
    main()
