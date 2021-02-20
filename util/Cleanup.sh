#!/bin/sh

rm -f zaj.data potential.data restart.data nfstop.data nfconstranint.data gdiis.data

rm -f nfinp_tmp.data

rm -f STATE fort.* 

for p in pot.*
do
if [ -L ${p} ];
then
  rm -f ${p}
fi
done

