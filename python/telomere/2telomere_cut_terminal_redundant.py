#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   2telomere_cut_ternimal_redundant.py
@Time    :   2020/07/28 21:12:19
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click
@click.command()
@click.option('-i','--infasta',type=click.File('r'),help='input the file',required=True)
@click.option('-o','--outfasta',type=click.File('w'),help='output the seq with Ternimal cut',required=True)

def main(infasta,outfasta):
    seq={}
    cterminal_database=['CCCCAAT','CCCAATC','CCAATCC','CAATCCC','AATCCCC','ATCCCCA','TCCCCAA']
    gterminal_database=['GGGGATT','GGGATTG','GGATTGG','GATTGGG','ATTGGGG','TTGGGGA','TGGGGAT']    
    for line in infasta:
        if line.startswith('>'):
            name = line.strip()
            seq[name] = ''
        else:
            seq[name] += line.replace('\n','')
    for k,v in seq.items():
        pointlist=[]#重置切割点
        n=0
        if 'AATCCCCAATC' in v[0:200] or 'CCCCAATCCCC' in v[0:200]:
            n=0
            m=0
            while v[0+n:7+n]not in cterminal_database:
                n=n+1
            pointlist.append(n)
            if 'GATTGGGGATT' in v[-200:] or 'GGGGATTGGGG' in v[-200:]:
                m=0
                v=v+'X'
                while v[-7+m:0+m]not in gterminal_database:
                    m=m-1
                pointlist.append(m)
                outfasta.write(f'{k}\n{v[n:m]}\n') #双端都截
            if m==0:               
                outfasta.write(f'{k}\n{v[n:]}\n')#首端截
        elif 'GATTGGGGATT' in v[-200:] or 'GGGGATTGGGG' in v[-200:]:
            n=0
            v=v+'X'
            while v[-7+n:0+n]not in gterminal_database:#这里的n刚开始是0，然后是-1，这样的话取不到[-7:]，所以加个字符，让[-8:-1]替代[-7:]，n的定位不受影响
                n=n-1            
            outfasta.write(f'{k}\n{v[:n]}\n')
        else:
            outfasta.write(f'{k}\n{v}\n')
if __name__ == "__main__":
    main()                         