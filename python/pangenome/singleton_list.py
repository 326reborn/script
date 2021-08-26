#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   singleton_list.py
@Time    :   2020/07/29 11:12:20
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click

@click.command()
@click.option('-i','--incluster',help='input the cd-hit clstr file',required=True)
@click.option('-n','--number',help='input the total number of samples',required=False)#用于算generate
@click.option('-s','--singleton',type=click.File('w'),help='the rate of pangene',required=True)
def main(incluster,number,singleton):
    core={}#以cluster为键存个体,计算pangene rate
    represent={}
    f1=open(incluster,'r')
    for line in f1:
        if line.startswith('>'):
            gene = line.strip()
            core[gene]=[]
        elif line.endswith('*\n'):
            seq = '.'.join(line.split(' ')[1].split('.')[0:5])
            length = line.split(' ')[0].split('\t')[1].split('n')[0]
            represent[gene]=seq+"\t"+length
            line='.'.join(line.split(' ')[1].split('.')[0:3])
            if line in core.get(gene):
                pass
            else:
                core[gene].append(line)            
        else:
            line='.'.join(line.split(' ')[1].split('.')[0:3])
            if line in core.get(gene):
                pass
            else:
                core[gene].append(line)
    for k,v in core.items():
        if len(v)==1:
            name=represent.get(k)
            singleton.write(f'{k}\t{name}\n')
if __name__ == '__main__':
    main()