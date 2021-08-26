#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   Btelomere_cutoff_1.5.py
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
        if 'CCCCAATCCCC' in v and 'GGGGATTGGGG' in v:
            m=0
            n=0
            while 'CCCCAATCCCC' in v[n:] and 'GGGGATTGGGG' in v[n:]:
                while v[n:n+11]!='GGGGATTGGGG':
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
                while v[n-7:n] in gterminal_database:
                    n=n+1
                if 'CCCCAAT' in v[n:n+70]:#此时n所处位置为首个不是GGGGATT的地方
                    n=n-1
                    pointlist.append(n)
                    test=0
                    while v[n:n+7] not in cterminal_database:
                        n=n+1
                        test=test+1
                    if test>0:
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
        elif 'CCCCAATCCCC' in v and 'GATTGGGGATT' in v:
            m=0
            n=0
            while 'CCCCAATCCCC' in v[n:] and 'GATTGGGGATT' in v[n:]:
                while v[n:n+11]!='GATTGGGGATT':
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
                while v[n-7:n] in gterminal_database:
                    n=n+1
                if 'CCCCAAT' in v[n:n+70]:#此时n所处位置为首个不是GGGGATT的地方
                    n=n-1
                    pointlist.append(n)
                    test=0
                    while v[n:n+7] not in cterminal_database:
                        n=n+1
                        test=test+1
                    if test>0:
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
        elif 'AATCCCCAATC' in v and 'GGGGATTGGGG' in v:
            m=0
            n=0
            while 'AATCCCCAATC' in v[n:] and 'GGGGATTGGGG' in v[n:]:
                while v[n:n+11]!='GGGGATTGGGG':
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
                while v[n-7:n] in gterminal_database:
                    n=n+1
                if 'CCCCAAT' in v[n:n+70]:#此时n所处位置为首个不是GGGGATT的地方
                    n=n-1
                    pointlist.append(n)
                    test=0
                    while v[n:n+7] not in cterminal_database:
                        n=n+1
                        test=test+1
                    if test>0:
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
        elif 'AATCCCCAATC' in v and 'GATTGGGGATT' in v:
            m=0
            n=0
            while 'AATCCCCAATC' in v[n:] and 'GATTGGGGATT' in v[n:]:
                while v[n:n+11]!='GATTGGGGATT':
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
                while v[n-7:n] in gterminal_database:
                    n=n+1
                if 'CCCCAAT' in v[n:n+70]:#此时n所处位置为首个不是GGGGATT的地方
                    n=n-1
                    pointlist.append(n)
                    test=0
                    while v[n:n+7] not in cterminal_database:
                        n=n+1
                        test=test+1
                    if test>0:
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