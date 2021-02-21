#!/bin/sh

rm -f zaj.data potential.data restart.data nfstop.data nfconstranint.data gdiis.data

rm -f nfinp_tmp.data

rm -f STATE fort.* 

for f in pot.*
do
  if [ -L ${f} ];
  then
    rm ${f}
  fi
done

rm -f slurm*.out
