#!/bin/sh

for d in *
do

if [ -d ${d} ];
then

cd ${d}

rm -f zaj.data potential.data restart.data nfstop.data nfconstranint.data gdiis.data

rm -f STATE fort.* pot.*

cd ..

fi

done
