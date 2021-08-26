#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   dataframe2pan_core.py
@Time    :   2021/07/25 12:15:21
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import sys,os,logging,click
import random
import pandas as pd
from pandas.core.frame import DataFrame
import re
logging.basicConfig(filename=os.path.basename(__file__).replace('.py','.log'),
                    format='%(asctime)s: %(name)s: %(levelname)s: %(message)s',level=logging.DEBUG,filemode='w')
logging.info(f"The command line is:\n\tpython3 {' '.join(sys.argv)}")
def LoadOrthogroupsDict(File1):
    Dict1 = {}
    SpeciesDict = {}
    for line in File1:
        lineList = line.strip().split()
        ClusterName = lineList[0].replace(':','')
        for i in range(len(lineList)):
            if i != 0:
                Species_Gene = re.search('(.*)\|(.*)',lineList[i])
                SpeciesDict.setdefault(Species_Gene.group(1),[]).append(Species_Gene.group(0))
        Dict1[ClusterName] = SpeciesDict
        SpeciesDict = {}
    return Dict1

def Count_Number(x):
    if isinstance(x,list):
        return len(x)
    else:
        return 0

@click.command()
@click.option('-i','--orthogroups',type=click.File('r'),help='The input the Orthogroups.txt file',required=True)
@click.option('-s','--speciesnum',type=int,help='The input species number',required=True)
@click.option('-p','--outpan',help='the result of random combinations data for pangene',required=True)
@click.option('-c','--outcore',help='the list of coregene',required=True)

def main(orthogroups,speciesnum,outpan,outcore):
    of1=open(outpan,'w')
    of2=open(outcore,'w')
    OrthogroupsDict = LoadOrthogroupsDict(orthogroups)
    Orthogroups_Frame = (pd.DataFrame(OrthogroupsDict)).T
    for col in Orthogroups_Frame.columns:
        Orthogroups_Frame[col] = Orthogroups_Frame[col].map(Count_Number)
    Orthogroups_Frame.to_csv(f'Orthogroups_total.stat',sep='\t')
    #构建Orthogroups相同规格的种名矩阵
    col_name=DataFrame(Orthogroups_Frame.columns.values.tolist()).T #list转dataframe后为1列，需转为1行
    specie_Frame=pd.DataFrame()
    specie_Frame=specie_Frame.append([col_name]*len(Orthogroups_Frame))#矩阵复制
    #让种名矩阵和Orthogroups矩阵行列索引相同
    specie_Frame.columns=Orthogroups_Frame.columns.values.tolist()
    specie_Frame.index=Orthogroups_Frame._stat_axis.values.tolist()
    #Orthogroups_Frame.columns=range(0,Orthogroups_Frame.columns.size)
    #Orthogroups_Frame.index=range(0,len(Orthogroups_Frame))
    Orthogroups_tq=specie_Frame[Orthogroups_Frame>0]
    Orthogroups_dic=Orthogroups_tq.T.to_dict('list')
    for k,v in Orthogroups_dic.items():
        v2=[x for x in v if pd.isnull(x) == False]#去除空值nan
        v2=list(filter(None,v2))#去除空值
        if len(v2) == speciesnum:
            of2.write(f'{k}\n')
    Orthogroups_Frame2=Orthogroups_Frame.T
    index_name=DataFrame(Orthogroups_Frame2.columns.values.tolist()).T
    cluster_Frame=pd.DataFrame()
    cluster_Frame=cluster_Frame.append([index_name]*len(Orthogroups_Frame2))
    cluster_Frame.columns=Orthogroups_Frame2.columns.values.tolist()
    cluster_Frame.index=Orthogroups_Frame2._stat_axis.values.tolist()
    cluster_tq=cluster_Frame[Orthogroups_Frame2>0]
    cluster_dict=cluster_tq.T.to_dict('list')
    for i in range(0,100):#100次抽样
        pan_count=[]
        for m in range(1,speciesnum+1):#随机抽样组合C1-Cn
            samples=random.sample(cluster_dict.keys(),m)
            pan_list=[]
            for x in samples:
                pan_list=pan_list + cluster_dict.get(x)
            uniq=list(set(pan_list))#对基因进行去重
            uniq=list(filter(None,uniq))
            uniq2=[x for x in uniq if pd.isnull(x) == False]
            pan_genes=len(uniq2)
            pan_count.append(str(pan_genes))
        p='\t'.join(pan_count)
        of1.write(f'{p}\n')

if __name__ == '__main__':
    main()

