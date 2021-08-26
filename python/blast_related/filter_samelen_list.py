#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   filter_samelen_list.py
@Time    :   2020/09/23 19:51:08
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click
@click.command()
@click.option('-i','--inlist',type=click.File('r'),help='input the list with $1 and $2',required=True)
@click.option('-o','--outlist',type=click.File('w'),help='output the filtered list',required=True)
def filter_samelen_list(inlist,outlist):
    sumlist=[]
    dic={}
    for line in inlist:
        line=line.strip().split('\t')
        name=line[0]
        if name in dic.keys():
            dic[name]+=line
        else:
            dic[name]=line
        sumlist+=line
    sumlist=list(set(sumlist))
    for k,v in dic.items():
        if k in sumlist:
            outlist.write(f'{k}\n')
            sumlist=list(set(sumlist)-set(v))
        else:
            pass
if __name__ == "__main__":
    filter_samelen_list()