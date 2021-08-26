#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   Btelomere_cutoff.py
@Time    :   2020/07/28 21:12:19
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click
@click.command()
@click.option('-i','--infasta',type=click.File('r'),help='input the file',required=True)
@click.option('-o','--outfasta',type=click.File('w'),help='output the seq with Btelomere cut',required=True)

def main(infasta,outfasta):
    seq={}
    for line in infasta:
        if line.startswith('>'):
            name = line.strip()
            seq[name] = ''
        else:
            seq[name] += line.replace('\n','')
    for k,v in seq.items():
        pointlist=[]#重置切割点
        if 'CCCCAATCCCCAAT' in v and 'GGGGATTGGGGATT' in v:
            m=0
            n=0
            while 'CCCCAATCCCCAAT' in v[n:] and 'GGGGATTGGGGATT' in v[n:]:
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
                    x=0
                    for l in range(1,22):#首次识别不到GGGGATT时向后探一探头
                        if v[N+l:N+l+7] == 'GGGGATT':
                            t=t+1
                            x=l
                    if t==0:
                        f=0
                    else:
                        n=n+x
                if 'CCCCAAT' in v[n:n+42]:#此时n所处位置为首个不是GGGGATT的地方
                    pointlist.append(n)
            I=0
            count=0
            if len(pointlist)>0:
                k=k.split(' ')
                for i in pointlist:
                    count+=1
                    mark='_'+str(count)+' '
                    name=k[0]+mark+' '.join(k[1:])
                    outfasta.write(f'{name}\n{v[I:i]}\n')#断点前端
                    I=i
                mark='_'+str(count+1)+' '
                name=k[0]+mark+' '.join(k[1:])
                outfasta.write(f'{name}\n{v[i:]}\n')#断点后端
            else:
                outfasta.write(f'{k}\n{v}\n')
        else:
            outfasta.write(f'{k}\n{v}\n')
if __name__ == "__main__":
    main()                         