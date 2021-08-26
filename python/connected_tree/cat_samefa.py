#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   cat_samefa.py
@Time    :   2019/09/12 16:16:01
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click
@click.command()
@click.option('--infile')
@click.option('--out')
def cat(infile,out):
    seq ={}
    raw = open(infile,'r')
    outfile = open(out,'w')
    name = 'delete'
    for line in raw:
        if line.startswith('>'):
            if line.strip() == name:
                pass
            else:
                name = line.strip()
                seq[name] = ''
        else:
            seq[name] += line.replace('\n','')
    for k, v in seq.items():
        outfile.write(k+'\n'+v+'\n')
    outfile.close()
if __name__ == '__main__':
    cat()   
