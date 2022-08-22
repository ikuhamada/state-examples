#!/bin/sh
#
# A script to generate a band structure
#
# Output file for SCF
NFOUT_SCF=nfout_scf
NFOUT_BAND=nfout_band
#
# "energy.data" file from the band structure calculation
ENEFILE=energy.data
#
# "band.data" file from the energy2band utility program
BANDFILE=band.data
#
# "energy2band" executable
E2B=${HOME}/STATE/src/state/util/bin/energy2band
#
# Number of bands considered in the calculation
#nbnd=8
nbnd=`grep 'NUMBER OF BANDS CONSIDERED' ${NFOUT_BAND} | awk '{print $6}'`
#
# Number of k-points considered in the band structure calculation
nkpt=`grep 'NUMBER OF K-POINTS' ${NFOUT_BAND} | grep -v 'TOTAL' | awk '{print $5}'`
#
# index of the valence band maximum (VBM)
nocc=4
#
# index of the k-points at which VBM is located.
ikpt=1
#
# k-point mesh
n1=20
n2=20
n3=20
#
# Min. and Max. energy relative to the reference (VBM)
emin=-20
emax=10
#
# K-point labels
s0='{/Symbol G}'
s1='K'
s2='M'
s3='{/Symbol G}'
#
# Offset
offset=0.3
#
# ii=`expr $ikpt "*" 2`
# ene=(`grep -A1 'EIGEN VALUE' ${NFOUT_SCF} | head -${ii} | tail -1`) 
# ibnd=`expr $nocc - 1`
# evbm=${ene[$ibnd]}
efermi=`grep FERMI ${NFOUT_SCF} | awk '{print $4}'`
#
# Execute "energy2band"
${E2B} << EOF
${nbnd}
${nbnd}
${nkpt}
${efermi}
EOF
#
m1=`expr $n1 + 1`
m2=`expr $n1 + $n2 + 1`
m3=`expr $n1 + $n2 + $n3 + 1`
#
x0=`grep -v '#' ${BANDFILE} | head -1 | awk '{print $1}'`
x1=`grep -v '#' ${BANDFILE} | head -${m1} | tail -1 | awk '{print $1}'`
x2=`grep -v '#' ${BANDFILE} | head -${m2} | tail -1 | awk '{print $1}'`
x3=`grep -v '#' ${BANDFILE} | head -${m3} | tail -1 | awk '{print $1}'`
#
#
cat > band.gp <<EOF
set xrange [${x0}:${x4}]
set yrange [${emin}:${emax}]
set ylabel 'E - E_F (eV)'
set arrow from ${x1},${emin} to ${x1},${emax} nohead lt 0
set arrow from ${x2},${emin} to ${x2},${emax} nohead lt 0
set arrow from ${x3},${emin} to ${x3},${emax} nohead lt 0
y0=${emin}-${offset}
set label "${s0}" at ${x0},${emin}-${offset} center
set label "${s1}" at ${x1},${emin}-${offset} center
set label "${s2}" at ${x2},${emin}-${offset} center
set label "${s3}" at ${x3},${emin}-${offset} center
unset key
unset xtics
plot 'band.data' w l
pause -1
EOF
gnuplot 'band.gp'
