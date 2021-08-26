#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   getSnptable.py
@Time    :   2020/05/29 09:06:18
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
#import gzip
#import zipfile
import click
@click.command()
@click.option('-i','--vcf',type=click.File('r'),help='input the vcf file',required=True)
@click.option('-o','--out',type=click.File('w'),help='output a table information',required=True)

def main(vcf,out):
    #Vcf = zipfile.ZipFile(vcf,mode='r')
    out.write(f'chrom\tposition\tref_base\tallele_base\tquality\tdepth\tref_dp\tallele_dp\tgenotype\n')
    for line in vcf:
        if line.startswith('#'):
            pass
        else:
            line = line.strip().split('\t')
            if line[7].startswith('INDEL'):
                pass
            else:
                chrom = line[0]
                position = line[1]
                ref_base = line[3]
                allele_base = line[4]
                quality = line[5]
                INFO = line[7].split(';')
                depth = INFO[0].strip().split('=')[1]
                ref_dp = INFO[1].strip().split('=')[1].split(',')[0]
                allele_dp = INFO[1].strip().split('=')[1].split(',')[1]
                genotype = line[-1].strip().split(':')[0]
                out.write(f'{chrom}\t{position}\t{ref_base}\t{allele_base}\t{quality}\t{depth}\t{ref_dp}\t{allele_dp}\t{genotype}\n')
if __name__ == '__main__':
    main()

