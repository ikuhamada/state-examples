#!/bin/sh

for f in nfout_*
do
a=${f##nfout_}
etot=`grep 'TOTAL ENERGY' ${f} | grep = | grep -v PS | tail -1 | awk '{print $4}'`
echo $a $etot
done
