#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   seq.extract.py
@Time    :   2019/09/11 18:08:01
@Author  :   Yu Zhang
@Contact :   zhangyu400cc@163.com
'''

# here put the import lib
import click
@click.command()
@click.option('--rawdata')
@click.option('--lists')
@click.option('--filterdata')
def main(rawdata,lists,filterdata):
    seq = {}
    res = open(filterdata,'w')
    protein = open(lists,'r')
    with open(rawdata,'r') as raw:
        for line in raw:
            if line.startswith('>'):
                name = line.strip()
                seq[name] = ''
            else:
                seq[name] += line.replace('\n','')
    for n in protein: #将文件放在外层循环，保证输出结果按照的是list中排好的顺序
        #protein.seek(0)
        for k,v in seq.items(): #在字典中取值时，不是按照输入顺序进行的
            n = n.strip()
            k = k.strip()
            if k.startswith('>'+n):
                res.write(k+'\n'+v+'\n') 
            else:
                pass
    res.close()
if __name__ == "__main__":
     main()               