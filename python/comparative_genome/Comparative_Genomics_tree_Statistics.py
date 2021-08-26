# -*- coding: utf-8 -*-
"""
Created on Mon Aug 31 10:13:46 2020
Changed by Zhang Yu on 2021.5.17 
@Mail: daixuelei2014@163.com
@author:daixuelei
"""

import sys,os,logging,click
import re
import numpy as np
import pandas as pd
from pandas import Series,DataFrame

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
@click.option('-p','--prefix',type=str,help='The output stat result prefix',default=True)
def main(orthogroups,speciesnum,prefix):
    OrthogroupsDict = LoadOrthogroupsDict(orthogroups)
    Orthogroups_Frame = (pd.DataFrame(OrthogroupsDict)).T
    
    #stat Orthogroups Gene and Gene Family Count
    for col in Orthogroups_Frame.columns:
        Orthogroups_Frame[col] = Orthogroups_Frame[col].map(Count_Number)
    Orthogroups_Frame['Total_GeneFamilyNum'] = Orthogroups_Frame.sum(axis=1)#每一行的所有列的和
    SpeciesIndexList = Orthogroups_Frame.columns[:-1]
    Orthogroups_Frame['Species_Num'] = Orthogroups_Frame[SpeciesIndexList].apply(lambda x: sum(x>0),axis=1)#进行条件判断后，True在运算中等价于1，False等价于0。得到了个基因家族的物种数
    Isolist = ['Isotricha.paraprostoma.SAG1','Isotricha.prostoma.SAG3','Isotricha.jalaludinii.SAG3','Isotricha.intestinalis.SAG3']
    Orthogroups_Frame['Iso_Num'] = Orthogroups_Frame[Isolist].apply(lambda x: sum(x>0),axis=1)
    Isocladelist = ['Isotricha.paraprostoma.SAG1','Isotricha.prostoma.SAG3','Isotricha.jalaludinii.SAG3','Isotricha.intestinalis.SAG3','Dasytricha.ruminantium.SAG3']
    Orthogroups_Frame['Iso_clade_Num'] = Orthogroups_Frame[Isocladelist].apply(lambda x: sum(x>0),axis=1)
    Entcladelist =['Entodinium.longinucleatum.SAG4','Entodinium.caudatum.SAG4','Entodinium.bursa.SAGT1','Diplodinium.dentatum.SAGT1','Diplodinium.flabellum.SAG1','Enoploplastron.triloricatum.SAGT1','Metadinium.minomm.SAG1','Eremoplastron.rostratum.SAG2','Ostracodinium.gracile.SAG1','Ostracodinium.dentatum.SAG1','Polyplastron.multivesiculatum.SAG8','Epidinium.caudatum.SAG1','Epidinium.cattanei.SAG3','Ophryoscolex.caudatus.SAGT3']
    Orthogroups_Frame['Ent_clade_Num'] = Orthogroups_Frame[Entcladelist].apply(lambda x: sum(x>0),axis=1)
    Ophcladelist =['Diplodinium.dentatum.SAGT1','Diplodinium.flabellum.SAG1','Enoploplastron.triloricatum.SAGT1','Metadinium.minomm.SAG1','Eremoplastron.rostratum.SAG2','Ostracodinium.gracile.SAG1','Ostracodinium.dentatum.SAG1','Polyplastron.multivesiculatum.SAG8','Epidinium.caudatum.SAG1','Epidinium.cattanei.SAG3','Ophryoscolex.caudatus.SAGT3']
    Orthogroups_Frame['Oph_clade_Num'] = Orthogroups_Frame[Ophcladelist].apply(lambda x: sum(x>0),axis=1)
    Orthogroups_Frame.to_csv(f'Orthogroups_total.stat',sep='\t')
    
    #stat "1:1" indicates single-copy genes
    mask = (Orthogroups_Frame['Total_GeneFamilyNum'] == speciesnum) & (Orthogroups_Frame['Species_Num'] == speciesnum)
    df1 = Orthogroups_Frame.loc[mask].copy()
    df1.loc['Raw_sum'] = df1.apply(lambda x: x.sum(),axis=0)
    (df1.iloc[-1:]).to_csv(f'One2One.Orthogroups.stat',sep='\t')
    
    #stat "X:X" indicates orthologousgenes present in multiple copies in all the species, where X means 1 or more orthologs per species
    mask1 = (Orthogroups_Frame['Total_GeneFamilyNum'] > speciesnum) & (Orthogroups_Frame['Species_Num']  == speciesnum) 
    df2 = Orthogroups_Frame.loc[mask1].copy()  ##在保证原始的表格数据Orthogroups_Frame不变的情况下，需要将新筛选后的结果赋值给df2。假如后面需要对df2再次进行更改，后面需要加.copy()
    df2.loc['Raw_sum'] = df2.apply(lambda x: x.sum(),axis=0)
    (df2.iloc[-1:]).to_csv(f'X2X.Orthogroups.stat',sep='\t')
    
    #stat Species_specific
    df3 = Orthogroups_Frame.loc[Orthogroups_Frame['Species_Num'] == 1].copy()
    df3.loc['Raw_sum'] = df3.apply(lambda x: x.sum(),axis=0)
    (df3.iloc[-1:]).to_csv(f'Species-specific.Orthogroups.stat',sep='\t')
    
    #stat Isotrichidae_species   4 species
    #Isotrichidae_specific = (Orthogroups_Frame['Entodinium.longinucleatum.SAG4'] == 0) & (Orthogroups_Frame['Entodinium.caudatum.SAG4'] == 0) & (Orthogroups_Frame['Entodinium.bursa.SAGT1'] == 0) & (Orthogroups_Frame['Epidinium.caudatum.SAG1'] == 0) & (Orthogroups_Frame['Ophryoscolex.caudatus.SAGT3'] == 0) & (Orthogroups_Frame['Epidinium.cattanei.SAG3'] == 0) & (Orthogroups_Frame['Ostracodinium.gracile.SAG1'] == 0) & (Orthogroups_Frame['Polyplastron.multivesiculatum.SAG8'] == 0) & (Orthogroups_Frame['Ostracodinium.dentatum.SAG1'] == 0) &(Orthogroups_Frame['Metadinium.minomm.SAG1'] == 0) & (Orthogroups_Frame['Eremoplastron.rostratum.SAG2'] == 0) & (Orthogroups_Frame['Enoploplastron.triloricatum.SAGT1'] == 0) & (Orthogroups_Frame['Diplodinium.dentatum.SAGT1'] == 0) & (Orthogroups_Frame['Diplodinium.flabellum.SAG1'] == 0) & (Orthogroups_Frame['Dasytricha.ruminantium.SAG3'] == 0)
    Isotrichidae_specific = (Orthogroups_Frame['Iso_Num'] == 4) & (Orthogroups_Frame['Ent_clade_Num'] == 0)#在这里忽略了对Dasytricha.ruminantium.SAG3的判断
    df4 = Orthogroups_Frame.loc[Isotrichidae_specific].copy()
    df4.loc['Raw_sum'] = df4.apply(lambda x: x.sum(),axis=0)
    (df4.iloc[-1:]).to_csv(f'Isotrichidae_specific.Orthogroups.stat',sep='\t')
    
    #stat Ent_clade_specific   14 species
    Ent_clade_specific = (Orthogroups_Frame['Ent_clade_Num'] == Orthogroups_Frame['Species_Num'])
    df5 = Orthogroups_Frame.loc[Ent_clade_specific].copy()
    df5.loc['Raw_sum'] = df5.apply(lambda x: x.sum(),axis=0)
    (df5.iloc[-1:]).to_csv(f'Ent_clade_specific.Orthogroups.stat',sep='\t')
    
    #stat Oph_clade_specific    11 species
    Oph_clade_specific = (Orthogroups_Frame['Oph_clade_Num'] == Orthogroups_Frame['Species_Num'])
    df6 = Orthogroups_Frame.loc[Oph_clade_specific].copy()
    df6.loc['Raw_sum'] = df6.apply(lambda x: x.sum(),axis=0)
    (df6.iloc[-1:]).to_csv(f'Ophryoscolecidae_specific.Orthogroups.stat',sep='\t')

    #stat patchy
    patchy= (Orthogroups_Frame['Species_Num'] >= 2) & (Orthogroups_Frame['Oph_clade_Num'] != Orthogroups_Frame['Species_Num']) & (Orthogroups_Frame['Ent_clade_Num'] != Orthogroups_Frame['Species_Num']) & (Orthogroups_Frame['Iso_clade_Num'] != Orthogroups_Frame['Species_Num']) & (Orthogroups_Frame['Iso_Num'] != Orthogroups_Frame['Species_Num'])
    df9 =  Orthogroups_Frame.loc[patchy].copy()
    df9.loc['Raw_sum'] = df9.apply(lambda x: x.sum(),axis=0)
    (df9.iloc[-1:]).to_csv(f'patchy.Orthogroups.stat',sep='\t')
    '''
    #Diplodiniinae_specific    8 species
    Diplodiniinae_specific = (Orthogroups_Frame['Isotricha.prostoma.SAG3'] == 0) & (Orthogroups_Frame['Isotricha.jalaludinii.SAG3'] == 0) & (Orthogroups_Frame['Isotricha.intestinalis.SAG3'] == 0) & (Orthogroups_Frame['Isotricha.paraprostoma.SAG1'] == 0) & \
    (Orthogroups_Frame['Entodinium.longinucleatum.SAG4'] == 0) & (Orthogroups_Frame['Entodinium.caudatum.SAG4'] == 0) & (Orthogroups_Frame['Entodinium.bursa.SAGT1'] == 0) & \
    (Orthogroups_Frame['Epidinium.caudatum.SAG1'] == 0) & (Orthogroups_Frame['Ophryoscolex.caudatus.SAGT3'] == 0) & (Orthogroups_Frame['Epidinium.cattanei.SAG3'] == 0) & \
    (Orthogroups_Frame['Dasytricha.ruminantium.SAG3'] == 0)
    df7 = Orthogroups_Frame.loc[Diplodiniinae_specific].copy()
    df7.loc['Raw_sum'] = df7.apply(lambda x: x.sum(),axis=0)
    (df7.iloc[-1:]).to_csv(f'Diplodiniinae_specific.Orthogroups.stat',sep='\t')    
    
    #stat Dasytricha_specific    1 species
    Dasytricha_specific = (Orthogroups_Frame['Entodinium.longinucleatum.SAG4'] == 0) & (Orthogroups_Frame['Entodinium.caudatum.SAG4'] == 0) & (Orthogroups_Frame['Entodinium.bursa.SAGT1'] == 0) & \
    (Orthogroups_Frame['Epidinium.caudatum.SAG1'] == 0) & (Orthogroups_Frame['Ophryoscolex.caudatus.SAGT3'] == 0) & (Orthogroups_Frame['Epidinium.cattanei.SAG3'] == 0) & \
    (Orthogroups_Frame['Ostracodinium.gracile.SAG1'] == 0) & (Orthogroups_Frame['Polyplastron.multivesiculatum.SAG8'] == 0) & (Orthogroups_Frame['Ostracodinium.dentatum.SAG1'] == 0) &(Orthogroups_Frame['Metadinium.minomm.SAG1'] == 0) & (Orthogroups_Frame['Eremoplastron.rostratum.SAG2'] == 0) & (Orthogroups_Frame['Enoploplastron.triloricatum.SAGT1'] == 0) & (Orthogroups_Frame['Diplodinium.dentatum.SAGT1'] == 0) & (Orthogroups_Frame['Diplodinium.flabellum.SAG1'] == 0) & \
    (Orthogroups_Frame['Isotricha.prostoma.SAG3'] == 0) & (Orthogroups_Frame['Isotricha.jalaludinii.SAG3'] == 0) & (Orthogroups_Frame['Isotricha.intestinalis.SAG3'] == 0) & (Orthogroups_Frame['Isotricha.paraprostoma.SAG1'] == 0)
    df8 = Orthogroups_Frame.loc[Dasytricha_specific].copy()
    df8.loc['Raw_sum'] = df8.apply(lambda x: x.sum(),axis=0)
    (df8.iloc[-1:]).to_csv(f'Dasytricha_specific.Orthogroups.stat',sep='\t')
    '''
if __name__ == '__main__':
    main()
