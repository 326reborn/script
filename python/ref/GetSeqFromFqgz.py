# -*- coding: utf-8 -*-
"""
Created on Fri Mar  8 09:41:30 2019
@Mail: daixuelei2014@163.com
@author:daixuelei
"""

import sys,os,logging,click,gzip

logging.basicConfig(filename='{0}.log'.format(os.path.basename(__file__).replace('.py','')),
                    format='%(asctime)s: %(name)s: %(levelname)s: %(message)s',level=logging.DEBUG,filemode='w')
logging.info(f"The command line is:\n\tpython3 {' '.join(sys.argv)}")

def ReadID(File):
    List = []
    for line in File:
        List.append(line.strip())
    return List

@click.command()
@click.option('-i','--gzfq',type=str,help='input the gzip fastq file',required=True)
@click.option('-l','--list',type=click.File('r'),help='intput the reads in list file',required=True)
@click.option('-o','--outfa',type=click.File('w'),help='output the fasta file',required=True)
def main(gzfq,list,outfa):
    seq = ''
    i = 0
    NameList = ReadID(list)
    f = gzip.open(gzfq,'rb')
    for line in f:
        line = line.decode().strip()
        if line.startswith('@'):
            line = line.split()
            if line[0][1:] in NameList:
                name = line[0][1:]
                i = 1
            else:
                pass                
        else:
            if i == 1:
                seq = line
                outfa.write(f'>{name}\n{seq}\n')
                i = 0
            else:
                pass
if __name__ == '__main__':
    main()
                
        
        