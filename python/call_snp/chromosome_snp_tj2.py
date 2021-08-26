#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   chromosome_snp_tj.py
@Time    :   2020/05/29 19:47:08
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click
@click.command()
@click.option('-i','--infile',type=click.File('r'),help='input the snptable file',required=True)
@click.option('-o','--out',type=click.File('w'),help='output a table with 2 allele information',required=True)

def main(infile,out):
    #f1=open(infile,'r')
    #dic = {}
    chrom = 'null'
    vf = 0
    n = 0
    heterozy = 0
    for line in infile:
        line = line.strip().split('\t')
        if chrom == line[0]:
            n = n+1
            vf = vf + eval(line[3])
            heterozy = heterozy + eval(line[4])
        else:
            if n == 0:
                pass
                n = 1
                chrom = line[0]
                vf = eval(line[3])
                heterozy = eval(line[4])
            else:
                vfrate = str(vf/n)
                He = str(heterozy/n)
                out.write(f'{chrom}\t{n}\t{vfrate}\t{He}\n')
                chrom = line[0]
                n = 1
                vf = eval(line[3])
                heterozy = eval(line[4])
    vfrate = str(vf/n)
    He = str(heterozy/n)
    out.write(f'{chrom}\t{n}\t{vfrate}\t{He}\n')
if __name__ == '__main__':
    main()
        