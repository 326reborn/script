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
@click.option('-o1','--out1',type=click.File('w'),help='output a table with 2 allele information',required=True)
@click.option('-o2','--out2',type=click.File('w'),help='output a table with 3 allele information',required=True)
@click.option('-q','--qual',help='the limit of snp quality',required=True)
def main(vcf,out1,out2,qual):
    #Vcf = zipfile.ZipFile(vcf,mode='r')
    out1.write(f'chrom\tposition\tref_base\tallele_base\tquality\tdepth\tref_dp\tallele_dp\tgenotype\n')
    out2.write(f'chrom\tposition\tref_base\tallele_base\tquality\tdepth\tref_dp\tallele1_dp\tallele2_dp\tgenotype\n')
    for line in vcf:
        if line.startswith('#'):
            pass
        else:
            line = line.strip().split('\t')                        
            if line[7].startswith('INDEL'):
                pass
            else:
                INFO = line[7].split(';')
                AD = INFO[1].strip().split('=')[1].split(',')
                if eval(line[5]) < eval(qual):
                    pass
                else:
                    if len(AD) > 2:
                        chrom = line[0]
                        position = line[1]
                        ref_base = line[3]
                        allele_base = line[4]
                        quality = line[5]
                        depth = INFO[0].strip().split('=')[1]
                        ref_dp = INFO[1].strip().split('=')[1].split(',')[0]
                        allele1_dp = INFO[1].strip().split('=')[1].split(',')[1]
                        allele2_dp = INFO[1].strip().split('=')[1].split(',')[2]
                        genotype = line[-1].strip().split(':')[0]
                        out2.write(f'{chrom}\t{position}\t{ref_base}\t{allele_base}\t{quality}\t{depth}\t{ref_dp}\t{allele1_dp}\t{allele2_dp}\t{genotype}\n')                    
                    else:
                        chrom = line[0]
                        position = line[1]
                        ref_base = line[3]
                        allele_base = line[4]
                        quality = line[5]
                        depth = INFO[0].strip().split('=')[1]
                        ref_dp = INFO[1].strip().split('=')[1].split(',')[0]
                        allele_dp = INFO[1].strip().split('=')[1].split(',')[1]
                        genotype = line[-1].strip().split(':')[0]
                        out1.write(f'{chrom}\t{position}\t{ref_base}\t{allele_base}\t{quality}\t{depth}\t{ref_dp}\t{allele_dp}\t{genotype}\n')
if __name__ == '__main__':
    main()

