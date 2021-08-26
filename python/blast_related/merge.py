import pandas as pd
import os
import sys
args=sys.argv
#f1=args[1]

csv_name_list=[]
#Folder_Path =f
#os.chdir(f)
#csv_name_list = os.listdir()
# a=Folder_Path +'\'+ file_list[i]
f1=open(args[1],"r")###文件名字，all.list 放第一个
df= pd.read_csv("ancestral.len",header=0,sep="\t",names=["db","ref-len"])
for i in f1:
	csv_name_list.append(i.strip())
#	print(csv_name_list)
for i in range(len(csv_name_list)):
	csv_name_list[i]= pd.read_csv(csv_name_list[i],sep="\t",names=["db","id","identity","alignment-len","mismatches","gap","q-start","q-end","s-start","s-end","e-value","soce"])
a=pd.merge(df,csv_name_list[0], how='left', left_on="db",right_on='db')

for i in range(1,len(csv_name_list)): # for i in range(1,len(file_list)):
	a=pd.merge(a,csv_name_list[i], how='left', left_on="db",right_on='db')
a.to_csv(args[2],sep=" ")

