#!/bin/bash


# Copyright 2014  Vassil Panayotov
#           2014  Johns Hopkins University (author: Daniel Povey)
# Apache 2.0

# Modified by Lucas Jo 2017 (Altas Guide)

src=`pwd`
#src="/home/beomgon/data/test/"
echo $src

cd $src
numfile=$(ls -l | grep .pcm$ | wc -l)
echo $numfile

#(ls -l | grep .pcm$ )> pcm.txt
#awk '{print $9}' pcm.txt
#make the pcm.list
rm -f user.list
(ls -l | grep .pcm$) | awk '{print $9}'>pcm.list
cat pcm.list | sed s/.pcm// >>user.list

SET=$(seq 1 $numfile)
#echo $SET

#sed -n 's/.pcm//' pcm.list >pcm1.list

#for fileline in $SET; do
#sed -n 's/KsponSpeech/\/home\/beomgon\/data\/test\/KsponSpeech/p' pcm.list > addr.list
for line in `cat pcm.list`
do 
    line=`pwd`'/'$line
    echo $line
done > addr1.list

sed -n 's/.pcm/.pcm |/' pcm.list >pcm3.list
#cat pcm.list pcm2.list
#done

#for using join, sort should be done first, but its already done.
#join pcm.list pcm2.list -1 1 -2 1 > wav.spc 
paste user.list addr1.list > wav.scp



