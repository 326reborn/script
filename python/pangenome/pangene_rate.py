#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   pangene_rate.py
@Time    :   2020/07/28 21:51:48
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click

@click.command()
@click.option('-i','--incluster',help='input the cd-hit clstr file',required=True)
@click.option('-n','--number',help='input the total number of samples',required=True)#用于算generate
@click.option('-r','--generate',type=click.File('w'),help='the rate of pangene',required=True)
def main(incluster,number,generate):
    core={}#以cluster为键存个体,计算pangene rate
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
    for k,v in core.items():
        rate = format(len(v)/eval(number), '.2f')
        generate.write(f'{k}\t{str(rate)}\n')
if __name__ == '__main__':
    main()