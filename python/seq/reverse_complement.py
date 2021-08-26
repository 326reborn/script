#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   reverse_complement.py
@Time    :   2019/10/03 10:45:50
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import sys
def DNA_complement(sequence):
	sequence=sequence.upper()
	sequence=sequence.replace('A','t')
	sequence=sequence.replace('G','c')
	sequence=sequence.replace('T','a')
	sequence=sequence.replace('C','g')
	return sequence.upper()
def DNA_reverse(sequence):
	sequence=sequence.upper()
	return sequence[::-1]
if __name__== '__main__':
	import argparse
	parser = argparse.ArgumentParser(description='get DNA_complement/reverse sequence')
	parser.add_argument("-i","--inputfile",metavar='FILE',dest='DNA_fa',help="a DNA squence file",type=str,required=True)
	parser.add_argument("-c","--conplement",metavar='FILE',dest='conplement_output',help="a stat contig file",type=str,required=False)
	parser.add_argument("-r","--reverse",metavar='FILE',dest='reverse_output',help="a stat contig file",type=str,required=False)
	parser.add_argument("-cr","--complement&reverse",metavar='FILE',dest='complement_reverse_output',help="a stat contig file",type=str,required=False)
	args=parser.parse_args()
	DNA_fa=open(args.DNA_fa,"r")
	conplement_output=None
	reverse_output=None
	if args.conplement_output:
		conplement_output=open(args.conplement_output,"w")
	if args.reverse_output:
		reverse_output=open(args.reverse_output,"w")
	if args.complement_reverse_output:
		complement_reverse_output=open(args.complement_reverse_output,"w")
##############
	value=[]
	key=[]
	for i in DNA_fa:
		if i.startswith(">"):
			Id=i.strip()
			key.append(Id)
		else:
			value.append(i.strip()) #将ID与序列一一对输入进来
	seq_com=''
	seq_rev=''
	for i in range(0,len(key)):
		if args.conplement_output:
			conplement_output.write(f'{key[i]}\n{DNA_complement(value[i])}\n')
		if args.reverse_output:
			reverse_output.write(f'{key[i]}\n{DNA_reverse(value[i])}\n')	
		if args.complement_reverse_output:	
			seq_com=DNA_complement(value[i])
			seq_rev=DNA_reverse(seq_com)
			complement_reverse_output.write(f'{key[i]}\n{seq_rev}\n')		
