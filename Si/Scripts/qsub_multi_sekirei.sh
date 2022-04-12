#!/bin/sh

#QSUB -queue i18cpu
#QSUB -node 1
#QSUB -mpi  12
#QSUB -omp  1
#QSUB -place pack
#QSUB -over false
#PBS -l walltime=00:30:00
#PBS -N Si
 
cd $PBS_O_WORKDIR

. /etc/profile.d/modules.sh

module load intel/18.0.5.274
module load intel-mpi/2018.4.274

A_LIST='10.20 10.25 10.30 10.35 10.40 10.45 10.50'

ln -fs $HOME/STATE/src/state/src/STATE

ln -fs $HOME/STATE/gncpp/pot.Si_pbe1

for A in ${A_LIST}
do
INPUT_FILE=nfinp_scf_${A}
OUTPUT_FILE=nfout_scf_${A}
cat > ${INPUT_FILE} << EOF
#
# Crystalline silicon in the diamond structure
#
WF_OPT    DAV
NTYP      1
NATM      2
TYPE      2
NSPG      227
GMAX      4.00
GMAXP     8.00
KPOINT_MESH    8   8   8
KPOINT_SHIFT   OFF OFF OFF
WIDTH     0.0002
EDELTA    0.5000D-09
NEG    8
CELL   ${A} ${A} ${A}  90.00  90.00  90.00
&ATOMIC_SPECIES
 Si 28.0900 pot.Si_pbe1
&END
&ATOMIC_COORDINATES CRYSTAL
      0.000000000000      0.000000000000      0.000000000000    1    1    1
      0.250000000000      0.250000000000      0.250000000000    1    1    1
&END
EOF
mpijob ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
done

