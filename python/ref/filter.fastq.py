# -*- coding: utf-8 -*-
"""
Created on Sun Aug  5 14:11:40 2018
@author: DaiXL
程序的功能是过滤三代nanopore下机的fastq数据
"""

import click

'''
delimited()函数的作用是取消换行符的限制
可以实现每次循环读取四行的操作
'''
def delimited(file, delimiter = '\n', bufsize = 4096):
    buf = ''
    while True:
        newbuf = file.read(bufsize)
        if not newbuf:
            yield buf
            return
        buf += newbuf
        lines = buf.split(delimiter)
        for line in lines[:-1]:
            yield line
        buf = lines[-1]
##### example
#with open('data', 'rt') as f:
#    lines = delimited(f, '>', bufsize = 1)
#    for line in lines:
#        print line,
#        print '######'


def Dict(fastq):
    Dict = {}
    with open(fastq,'r') as f1:
        lines = delimited(f1,'@', bufsize = 1)
        for line in lines:
            if line:
                line0 = line.split('\n')
                seq = line0[1]
                qual = line0[3]
                name = line0[0]
                tmp = name.strip().split()
                key = tmp[0]
                Dict[key] = [seq,qual]
    return Dict
'''
输入的filtertxt文件格式如下，包含需要过滤的reads的信息
filename        read_id run_id  channel start_time      duration        num_events      template_start  num_events_template     template_duration       sequence_length_template        mean_qscore_template    strand_score_template   median_template mad_template
PCT0020_20180816_0004A30B0023A9E6_2_A7_D7_sequencing_run_20180816_NPL0224_P2_A7_D7_39391_read_5929_ch_2511_strand.fast5 bd1da454-64f9-4e7f-9eb3-7c539cb40832    29429e0d9be478f9d7c2d2d74524228bf4e78d42        2511    76937.429688    87.552002       70041   76937.476562    70003   87.504501       26817   8.882744        -0.001464       76.758705       10.088287
PCT0020_20180816_0004A30B0023A9E6_2_A7_D7_sequencing_run_20180816_NPL0224_P2_A7_D7_39391_read_22217_ch_235_strand.fast5 5719384a-4303-4c66-8212-ee33d9c4b555    29429e0d9be478f9d7c2d2d74524228bf4e78d42        235     76976.710938    50.803249       40642   76977.085938    40344   50.430752       17795   9.926783        -0.001574       75.442848       10.088287
'''

@click.command()
@click.option('--fastq')
@click.option('--filtertxt')
@click.option('--outfastq')
def main(fastq,filtertxt,outfastq):
    dict1 = Dict(fastq)
    with open(outfastq,'w') as f:
        with open(filtertxt,'r') as f2:
            for line in f2:
                line = line.strip().split()
                if line[1] in dict1:
                    f.write('@' + line[1] + '\n' + dict1[line[1]][0] + '\n' + '+' + '\n' + dict1[line[1]][1] + '\n')

if __name__ == '__main__':
    main()                
    
 
            
            
           
                
                    
                    
            
            