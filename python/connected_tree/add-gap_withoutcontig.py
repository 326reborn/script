#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   add-gap_withoutcontig.py
@Time    :   2019/09/20 10:25:52
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click
#contigname ='contig_protein'
@click.command()
@click.option('--namelist')
@click.option('--rawlist') #原始的单拷贝基因中contig的list
@click.option('--rawdata')#原始的rawlist对应的序列文件
@click.option('--outlists')#新的单拷贝基因的contig的list
@click.option('--outdata')#新的list对应的序列文件（即加gap之后的）

def main(namelist,rawlist,rawdata,outlists,outdata):
    b = {}
    m = []
    seq = {}
    counter = 0
    name = open(namelist,'r')
    lists = open(rawlist,'r')
    raw = open(rawdata,'r')
    outseq = open(outdata,'w')
    outlist = open(outlists,'w')
    for line in lists:
        key = line.strip().split('_')[0]
        b[key] = line.strip()
        m.append(line.split('_')[0])
        protein = line.strip().split('&')[-1]
    for line1 in raw:
        if line1.startswith('>'):
            contig = line1.strip()
            seq[contig] = ''
        else:
            seq[contig] += line1.replace('\n','')
    length = len(seq[contig])
    for n in name:
        n = n.strip() 
        if n in m:
            x = b.get(n)
            y = seq.get('>'+x)
            outseq.write('>'+str(x)+'\n'+str(y)+'\n')
            outlist.write(str(x)+'\n')
        else:
            counter = counter + 1
            l = length*'-'
            outseq.write('>'+n+'_'+str(counter)+'&'+protein+'\n'+l+'\n')
            outlist.write(n+'_'+str(counter)+'&'+protein+'\n')
    outseq.close()
    outlist.close()
if __name__ == "__main__":
    main()





