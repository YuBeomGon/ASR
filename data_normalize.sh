#!/bin/bash
#data_normalize.sh

cd ~/kaldi/egs/zeroth/s5/data/local/lm

exists(){
    command -v "$1" >/dev/null 2>&1
}

# check parallel installed
if ! exists parallel; then
    echo "Please, install parallel"
    echo "-  sudo apt-get install parallel"
    exit 1
fi

. ./cmd.sh
. ./path.sh

cmd=$normalize_cmd
srcdir=buildLM/_corpus
scriptdir=buildLM/_scripts_

. parse_options.sh || exit 1;

set -e
date=$(date +'%F-%H-%M')
echo start at $date

# Normalization
echo 'Text normalization starts ---------------------------------------------------'
nj=1
logdir=$srcdir/log
if [ ! -d $logdir ]; then
    mkdir -p $logdir
fi
rm $srcdir/normedCorpus.1

if [ ! -e $srcdir/normedCorpus.1 ] ; then
    echo " normedCorpus not exist"
    for n in $(seq $nj); do
        # the next command does nothing unless _corpus_/storage/ exists, see
        # utils/create_data_link.pl for more info.
        utils/create_data_link.pl $srcdir/normedCorpus.$n
    done
    $cmd JOB=1:$nj $logdir/rawCorpus.JOB.log \
        $scriptdir/normStep1.py $srcdir/rawCorpus.JOB \| \
        $scriptdir/normStep2.py \| \
        $scriptdir/normStep_tmp.py \| \
        $scriptdir/normStep4.py \| \
        $scriptdir/strip.py  \> $srcdir/normedCorpus.JOB || exit 1;
fi
