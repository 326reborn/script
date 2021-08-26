# -*- coding: utf-8 -*-
#!/usr/bin/env python3
'''
Created on Thu Nov 14 10:43:03 CST 2019
@Mail: minnglee@163.com
@Author: Ming Li
'''

import sys,os,logging,click

logging.basicConfig(filename=os.path.basename(__file__).replace('.py','.log'),
                    format='%(asctime)s: %(name)s: %(levelname)s: %(message)s',level=logging.DEBUG,filemode='w')
logging.info(f"The command line is:\n\tpython3 {' '.join(sys.argv)}")

@click.command()
@click.option('-i','--input',type=click.File('r'),help='The input file',required=True)
@click.option('-o','--output',type=click.File('w'),help='The output file',required=True)
def main(input,output):
    '''
    Houdan_3-MSTRG.8.1_mRNA	ABC42045.1	99.476	1185	191	1	0	605	33	57	247	247	190	8.89e-134	392	48	Metazoa|Chordata|Craniata|Aves|Galliformes|Phasianidae|Gallus|Gallus gallus
    Houdan_3-MSTRG.8.1_mRNA	OPJ79369.1	67.873	1185	221	69	1	695	39	32	252	258	150	2.06e-100	308	55	Metazoa|Chordata|Craniata|Aves|Columbiformes|Columbidae|Patagioenas|Patagioenas fasciata
    '''
    output.write('TransID\tPhasianidae\tOdontophoridae\tNumididae\tCracidae\tMegapodiidae\n')
    Dict = {}
    for line in input:
        line = line.strip().split('\t')
#        if float(line[2]) < 70 or float(line[13]) > 0.0000000001: continue
        if line[0] not in Dict: Dict[line[0]] = ['0','0','0','0','0']
        Tax = line[-1].split('|')
        if Tax[1] != 'Chordata': continue
        if Tax[5] == 'Phasianidae' : Dict[line[0]][0] = '1'
        elif Tax[5] == 'Odontophoridae': Dict[line[0]][1] = '1'
        elif Tax[5] == 'Numididae': Dict[line[0]][2] = '1'
        elif Tax[5] == 'Cracidae': Dict[line[0]][3] = '1'
        elif Tax[5] == 'Megapodiidae': Dict[line[0]][4] = '1'
    for key,value in Dict.items():
        value = '\t'.join(value)
        output.write(f'{key}\t{value}\n')
if __name__ == '__main__':
    main()
