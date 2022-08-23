#!/bin/sh

ndt=0

for f in $@
do

a=`grep 'PRIM. LAT.' ${f} | head -1 | awk '{print $5}'`

etot=`grep 'TOTAL ENERGY' ${f} | grep A.U. | awk '{print $4}'`

ndt=`expr $ndt + 1`

if [ $ndt == 1 ];
then
echo '#a [Bohr] Etot [Hartree]'
fi
echo $a $etot

done
