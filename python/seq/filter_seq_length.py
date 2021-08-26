#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   filter_sequence_length.py
@Time    :   2019/08/20 20:20:27
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''
#用于提取特定长度的序列
# here put the import lib
import click
@click.command()
@click.option('--rawdata')
@click.option('--filterdata')
def main(rawdata,filterdata):
    seq = {}
    res = open(filterdata,'w')
    with open(rawdata,'r') as raw:
        for line in raw:
            if line.startswith('>'):
                name = line.strip()
                seq[name] = ''
            else:
                seq[name] += line.replace('\n','')
    for k, v in seq.items():
        if len(v) >= 1 and len(k) > 2:
            res.write(k+'\n'+v+'\n') 
        else:
            pass
    res.close()
if __name__ == "__main__":
     main()               
