#!/bin/bash
wd=`pwd`
cd $wd
source ~/../2018055219/.bashrc
cactus --maxCores 24 --workDir /tmp --binariesMode local  jobStore cactus.cfg Hu_Oar_ARS.hal
