#!/bin/bash

curdir=`pwd`
echo $curdir

#paste $curdir user.list > trans.list
#sed -n 's/KsponSpeech/$curdir'KsponSpeech'/ user.list > trans.list
cd $curdir
numfile=$(ls -l | grep .txt$ | wc -l)
rm trans.list
rm trans1.list
rm trans.txt
echo $numfile
(ls -l | grep .txt$) | awk '{print $9}' | sed '/decoded/d' | sed '/trans/d' > trans.list

#SET=$(seq 0, $numfile-1)
#for i in $SET


for line in `cat trans.list`
do
#    echo $line
    line=$curdir'/'$line
#    line=$line'curdir'
    echo $line

done > trans1.list   
for line in `cat trans.list`
do
    echo $line' '`cat $line`
#    echo " "
#    echo `cat $line`
done > trans.txt   

cat trans.txt | sed s/.txt// > trans1.txt
cp trans1.txt trans.txt
rm trans1.txt
#for line in `cat trans1.list`
#do
#    echo $line
##    line=`cat line`
#done > trans.txt   
