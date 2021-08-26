#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   get_pointer.py
@Time    :   2020/08/12 14:45:24
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click
@click.command()
@click.option('-i','--blast',type=click.File('r'),help='input the sorted result of blast6',required=True)
@click.option('-o','--outbed',type=click.File('w'),help='bedfile of the pointer',required=True)
def main(blast,outbed):
    dic={}#存pointer位置
    name='null'
    for line in blast:
        if line.startswith('\n'):
            pass
        else:
            line=line.strip().split('\t')
            if line[0] != name:
                name=line[0]
                dic[name]=[]
                start1=line[9]
                end1=line[10]                
            else:
                start2=line[9]
                end2=line[10]
                if eval(end1) <= eval(start2):
                    pass
                elif eval(start2) > eval(start1) and eval(start2)<eval(end1):
                    dic[name].append(str(eval(start2)-1)+'\t'+str(end1))
                start1=line[9]
                end1=line[10]
    for k,v in dic.items():
        m=0
        v=list(set(v))
        for i in v:
            m+=1
            feature=k+'_pointer'+str(m)
            outbed.write(f'{k}\t{i}\t{feature}\n')
if __name__ == "__main__":
    main()