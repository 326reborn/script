#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   Telomere_end_cut.py
@Time    :   2020/07/17 17:55:01
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click

@click.command()
@click.option('-i','--infasta',type=click.File('r'),help='input the file',required=True)
#@click.option('-n','--number',help='input the total number of samples',required=True)
@click.option('-o','--outfasta',type=click.File('w'),help='the seq near the telomere',required=True)

def main(infasta,outfasta):
    seq={}
    p='C'*70
    for line in infasta:
        if line.startswith('>'):
            name = line.strip()
            seq[name] = ''
        else:
            seq[name] += line.replace('\n','')
    for k,v in seq.items():
        n=0
        if 'AATCCCCAAT' in v[0:100] or 'CCCCAATCCCC' in v[0:100]:
            n=0
            while v[0+n:7+n]!='CCCCAAT':
                n=n+1
            f=3
            t=0
            while f != 0:
                while v[0+n:7+n]=='CCCCAAT':
                    n=n+7
                N=n
                t=0
                for l in range(1,22):#读到端粒单位序列结束后再向后读两个端粒单位
                    if v[N+l:N+l+7] == 'CCCCAAT':
                        t=t+1
                        n=n+l
                if t==0:
                    f=0
            if 'ATTGGGGATT' in v[-100:] or 'GGGGATTGGGG' in v[-100:]:
                m=0
                v=v+'X'
                while v[-7+m:0+m]!='GGGGATT':
                    m=m-1
                f=3
                t=0
                while f != 0:
                    while v[-7+m:0+m]=='GGGGATT':
                        m=m-7
                    M=m
                    t=0
                    for l in range(1,22):
                        if v[-7+M-l:M-l] == 'GGGGATT':
                            t=t+1
                            m=m-l
                    if t==0:
                        f=0
                outfasta.write(f'{k}\n{v[n+21:n+91]}\n{v[m-91:m-21]}\n') #双端取均值               
            outfasta.write(f'{k}\n{v[n+21:n+91]}\n')#首端
        elif 'ATTGGGGATT' in v[-100:] or 'GGGGATTGGGG' in v[-100:]:
            n=0
            v=v+'X'
            while v[-7+n:0+n]!='GGGGATT':#这里的n刚开始是0，然后是-1，这样的话取不到[-7:]，所以加个字符，让[-8:-1]替代[-7:]，n的定位不受影响
                n=n-1
            f=3
            t=0
            while f != 0:
                while v[-7+n:0+n]=='GGGGATT':
                    n=n-7
                N=n
                t=0
                for l in range(1,22):
                    if v[-7+N-l:N-l] == 'GGGGATT':
                        t=t+1
                        n=n-l
                if t==0:
                    f=0            
            outfasta.write(f'{k}\n{v[n-91:n-21]}\n')
        elif 'CCCCAATCCCCAAT' in v and 'GGGGATTGGGGATT' in v:#中间的端粒之前按2.5个筛的
            m=0
            n=0
            v=v
            while v[n:n+14]!='GGGGATTGGGGATT':
                n=n+1
            n1=n
            f=3
            t=0
            while f!=0:
                while v[n:n+7]=='GGGGATT':
                    n=n+7
                N=n
                t=0
                for l in range(1,22):
                    if v[N+l:N+l+7] == 'GGGGATT':
                        t=t+1
                        n=n+l
                if t==0:
                    f=0                
            while v[0+m:14+m]!='CCCCAATCCCCAAT':
                m=m+1
            m1=m
            f=3
            t=0
            while f != 0:
                while v[0+m:7+m]=='CCCCAAT':
                    m=m+7
                M=m
                t=0
                for l in range(1,22):
                    if v[M+l:M+l+7] == 'CCCCAAT':
                        t=t+1
                        m=m+l
                if t==0:
                    f=0
            if len(v[n1-84:n1-14])==0 and len(v[m+21:m+91])==0:
                outfasta.write(f'{k}\n{p}\n')
            else:
                if len(v[m:]) < 100 and len(v[n1-84:n1-14])!=0:
                    outfasta.write(f'{k}\n{v[n1-84:n1-14]}\n')
                elif len(v[:n]) < 100 and len(v[m+21:m+91]) !=0:
                    outfasta.write(f'{k}\n{v[m+21:m+91]}\n')
                elif len(v[m:]) < 100 and len(v[n1-84:n1-14])==0:
                    outfasta.write(f'{k}\n{p}\n')
                elif len(v[:n]) < 100 and len(v[m+21:m+91]) ==0:
                    outfasta.write(f'{k}\n{p}\n')
                else:
                    outfasta.write(f'{k}\n{v[n1-84:n1-14]}\n{v[m+21:m+91]}\n')             
if __name__ == '__main__':
    main()