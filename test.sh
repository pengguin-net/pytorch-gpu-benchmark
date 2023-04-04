#! /bin/bash
if command -v nvidia-smi > /dev/null 2>&1; then
  count=`nvidia-smi --query-gpu=name --format=csv,noheader | wc -l`
else
  count=$(rocminfo | grep 'Device Type:' |grep -c 'GPU')
fi
echo 'start'
for (( c=$count; c>=1; c-- ))
do
      python3 benchmark_models.py -g $c&& &>/dev/null 
done
echo 'end'
