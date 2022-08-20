#!/bin/sh
#SBATCH -J  Si
#SBATCH -p  i8cpu
#SBATCH -N  1
#SBATCH -n  4

module load intel_compiler/2020.2.254
module load intel_mpi/2020.2.254
module load intel_mkl/2020.2.254

ln -fs ${HOME}/STATE/src/state/src/STATE

ln -fs ../gncpp/pot.Si_pbe1

ulimit -s unlimited

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
VERBOSITY LOW
&ATOMIC_SPECIES
 Si 28.0900 pot.Si_pbe1
&END
&ATOMIC_COORDINATES CRYSTAL
      0.000000000000      0.000000000000      0.000000000000    1    1    1
      0.250000000000      0.250000000000      0.250000000000    1    1    1
&END
EOF

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done
