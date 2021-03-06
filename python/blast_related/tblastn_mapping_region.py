#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   tblastn_mapping.py
@Time    :   2019/09/06 14:47:35
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''
# here put the import lib
#infile:
'''
TBLASTN 2.6.0+


Reference: Stephen F. Altschul, Thomas L. Madden, Alejandro A.
Schaffer, Jinghui Zhang, Zheng Zhang, Webb Miller, and David J.
Lipman (1997), "Gapped BLAST and PSI-BLAST: a new generation of
protein database search programs", Nucleic Acids Res. 25:3389-3402.



Database: User specified sequence set (Input: 18.singlegene.fa).
           90 sequences; 342,255 total letters



Query= EPrGT00050000000021

Length=264
                                                                      Score     E
Sequences producing significant alignments:                          (Bits)  Value

  Protozoa_NBJL02008442.1 Entodinium caudatum strain MZG-1 scaffo...  23.1    2.7  
  Entodinium.05.GT05_524087 flag=3 multi=278.0000 len=92519           21.9    6.0  


> Protozoa_NBJL02008442.1 Entodinium caudatum strain MZG-1 scaffold8451_size10184, 
whole genome shotgun sequence
Length=10184

 Score = 23.1 bits (48),  Expect = 2.7, Method: Compositional matrix adjust.
 Identities = 14/44 (32%), Positives = 22/44 (50%), Gaps = 6/44 (14%)
 Frame = -3

Query  153   ILKCRACYEVSKETRKFCSKCGNATLERVPISVDKDTGEVDKRK  196
             I+KC+       E  KF SKC    LE++  +  ++   +DK K
Sbjct  7077  IIKCKV------EYPKFISKCAKNLLEKILTANPENRITIDKIK  6964
'''
#lists:
'''
...skipping...
EPrGT00050000000764     Isotrichitina.09.MDA06_128592
EPrGT00050000003122     Isotrichitina.09.MDA06_149506
EPrGT00050000003964     Isotrichitina.09.MDA06_187560
EPrGT00050000005144     Isotrichitina.09.MDA06_949
EPrGT00050000005163     Isotrichitina.09.MDA06_146905
EPrGT00050000005182     Isotrichitina.09.MDA06_165964
EPrGT00050000005459     Isotrichitina.09.MDA06_91407
EPrGT00050000005498     Isotrichitina.09.MDA06_231916
EPrGT00050000005579     Isotrichitina.09.MDA06_178143
EPrGT00050000005623     Isotrichitina.09.MDA06_248447
EPrGT00050000005755     Isotrichitina.09.MDA06_883
EPrGT00050000005858     Isotrichitina.09.MDA06_151353
EPrGT00050000005940     Isotrichitina.09.MDA06_251174
EPrGT00050000005944     Isotrichitina.09.MDA06_38797
EPrGT00050000006007     Isotrichitina.09.MDA06_17196
EPrGT00050000006015     Isotrichitina.09.MDA06_16499
EPrGT00050000006089     Isotrichitina.09.MDA06_120143
EPrGT00300000062307     Isotrichitina.09.MDA06_186343
'''
#??????tblastn????????????????????????????????????
import click
@click.command()
#@click.option('--clists')
#@click.option('--plists')
@click.option('--lists')
@click.option('--infile')
@click.option('--out')
#@click.option('--number') #??????????????????????????????????????????????????????????????????contig????????????????????????
def main(lists,infile,out):
    seq = {}
    pro = {}
    df1 = open(out,'w')
    singleprotein = 'null-pro'
    pro[singleprotein] = 'value-pro'#?????????????????????????????????   
    #cname = open(clists,'r') #contig???lists
    protozoalist = open(lists,'r')#??????????????????????????????contig?????????????????????
    plist = []
    clist = []
    listcounter = 0
    raw = open(infile,'r')
    #pname = open(plists,'r') #protein???lists
    for Line in raw : #???????????????????????????
        if Line.startswith('Query= '):
            Line = Line.strip()
            singleprotein = Line.split('=')[1].strip()
            pro[singleprotein] = ''
        else:
            pro[singleprotein] += Line
    for Line2 in protozoalist:
        Line2 = Line2.split('\t')
        plist.append(Line2[0].strip())
        clist.append(Line2[-1].strip())
        listcounter = listcounter +1
    for x in range(listcounter):
        p = plist[x].strip()
        #countnumber = 0
        proteinlines = pro.get(p).split('\n')
        seq.clear()
        contig = 'null-con'
        seq[contig] = 'value-con'
        for Line1 in proteinlines: #????????????????????????contig????????????
            #if countnumber <= eval(number): 
                if Line1.startswith('>'):
                    #countnumber = countnumber +1
                    #global contig #??????????????????
                    contig = Line1.strip()
                    seq[contig] = ''
                else:
                    seq[contig] += Line1+'\n'#?????????????????????????????????\n????????????
        for a in seq.keys():
            #cname.seek(0) #?????????????????????????????????
            #for n in clist:
                n = clist[x].strip() #??????$?????????
                if a.startswith('> '+n): #??????contig
                    score = 0
                    result = seq.get(a).split('\n')    #????????????contig????????????list?????????????????????contig??????
                    for line in result:
                        line = line.strip()
                        if score < 2: #??????contig????????????????????????                    
                            if line.startswith('Score ='):
                                score = score + 1
                            elif line.startswith('Query '):  #Query ????????????????????????Query=???
                                query = line.split()
                                qstart = query[1]
                                qend = query[3]
                                protein = '.'.join(query[2])
                                Protein = protein.split('.')
                            elif line.startswith('Sbjct '):
                                subject = line.split()
                                sstart = subject[1]
                                send = subject[3]
                                nucleotide = '.'.join(subject[2])
                                Nucleotide = nucleotide.split('.')
                                counter = 0  #????????????????????????????????????????????????
                                counter2 = 0
                                start = eval(sstart)
                                stop = start #q???s???????????????????????????stop??????????????????????????????????????????-????????????stop????????????
                                for q in range(len(query[2])):
                                    #counter = counter +1 
                                    if Protein[q] != '-' and Nucleotide[q] != '-':
                                        counter = counter +1
                                        if eval(sstart) < eval(send):
                                            stop = start + 3*counter
                                        elif eval(sstart) > eval(send):
                                            stop = start - 3*counter
                                    elif Protein[q] != '-' and Nucleotide[q] == '-':
                                        pass #do nothing
                                    elif Protein[q].strip() == '-':
                                        counter2 = counter2 + 1 #???gap????????????start
                                        if counter != 0:
                                            counter = 0
                                            if eval(sstart) < eval(send):
                                                df1.write(n+'\t'+str(start)+'\t'+str(stop-1)+'\t'+p+"\n")
                                            elif eval(sstart) > eval(send):
                                                df1.write(n+'\t'+str(start)+'\t'+str(stop+1)+'\t'+p+"\n")
                                            if q + 1 < len(query[2]) and Protein[q+1].strip() != '-': #??????????????????gap?????????
                                                if eval(sstart) < eval(send):
                                                    start = stop + 3*(counter2)
                                                elif eval(sstart) > eval(send):
                                                    start = stop - 3*(counter2)
                                                counter2 = 0                               
                                        elif q + 1 < len(query[2]): #??????q+1????????????
                                            if  Protein[q+1].strip() == '-':
                                                pass
                                            else:                                
                                                if eval(sstart) < eval(send):
                                                    start = stop + 3*counter2
                                                elif eval(sstart) > eval(send):
                                                    start = stop - 3*counter2
                                                counter2 = 0
                                if counter != 0:
                                    if eval(sstart) < eval(send):
                                        df1.write(n+'\t'+str(start)+'\t'+str(stop-1)+'\t'+p+"\n")#????????????????????????????????????
                                    if eval(sstart) > eval(send):
                                        df1.write(n+'\t'+str(start)+'\t'+str(stop+1)+'\t'+p+"\n")
                        else:
                            break                    
    df1.close()
if __name__ == "__main__":
    main()