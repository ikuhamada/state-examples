#!/bin/sh

#SBATCH -J MoS2
#SBATCH -p i8cpu
#SBATCH -N 2
#SBATCH -n 128
#SBATCH -c 2

module load intel_mpi/2020.4.304
module load intel_compiler/2020.4.304

# Set a list of the lattice constants

A_LIST='6.08 6.09 6.10'
#A_LIST='6.00 6.01 6.02 6.03 6.04 6.05 6.06 6.07 6.08 6.09 6.10'

# Set the STATE executable

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ../gncpp/pot.Mo_pbe1
ln -fs ../gncpp/pot.S_pbe1

for A in ${A_LIST}
do
INPUT_FILE=nfinp_${A}
OUTPUT_FILE=nfout_${A}
cat > ${INPUT_FILE} << EOF
#
# Monolayer MoS2
#
TASK      GEO_OPT
WF_OPT    DAV
NTYP      2
NATM      3
TYPE      0
GMAX      6.0
GMAXP     20.0
MIX_ALPHA 0.3
SMEARING  MP
WIDTH     0.0010
NEG       28
GEO_OPT   QMD
DTIO      200.0
KPOINT_MESH    12 12  1
KPOINT_SHIFT    F  F  F
CELL  ${A} ${A} 18.8972612463  90.00000000  90.00000000 120.00000000
&ATOMIC_SPECIES
 Mo  95.95 pot.Mo_pbe1
 S   32.06 pot.S_pbe1
&END
&ATOMIC_COORDINATES CRYSTAL
      0.333333333333      0.666666666667      0.000000000000    1    1    1
      0.666666666667      0.333333333333      0.160000000000    1    1    2
      0.666666666667      0.333333333333     -0.160000000000    1    1    2
&END
EOF
ulimit -s unlimited
srun ./STATE  < ${INPUT_FILE} > ${OUTPUT_FILE}
done
