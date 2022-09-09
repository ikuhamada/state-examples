#!/bin/sh

#SBATCH -J Zn
#SBATCH -p i8cpu
#SBATCH -N 2
#SBATCH -n 128
#SBATCH -c 2
#SBATCH -t 00:30:00

module purge
module load intel_mpi/2020.4.304
module load intel_compiler/2020.4.304
module load intel_mkl/2020.4.304

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ../gncpp/pot.Mo_pbe1
ln -fs ../gncpp/pot.S_pbe1

A_LIST='4.80 4.85 4.90 4.95 5.00 5.05 5.10'
C_LIST='9.50 9.55 9.60 9.65 9.70 9.75 9.80 9.85 9.90 9.95 10.00'

EXEC=./STATE

for A in ${A_LIST}
do
for C in ${C_LIST}
do
INPUT_FILE=nfinp_a${A}_c${C}
OUTPUT_FILE=nfout_a${A}_c${C}
cat > ${INPUT_FILE} << EOF
#
# Zinc in the hcp structure
#
NTYP     1
NATM     2
TYPE     0
NSPG     194
GMAX    6.00
GMAXP  20.00
KPOINT_MESH   12 12  8
KPOINT_SHIFT    F  F  F
BZINT TETRA
MIX_ALPHA  0.50
EDELTA  1.D-10
NEG    24
CELL ${A} ${A} ${C}  90.00000000  90.00000000 120.00000000
&ATOMIC_SPECIES
 Zn  65.3800 pot.Zn_pbe1
&END
&ATOMIC_COORDINATES CRYSTAL
      0.333333333333      0.666666666667      0.250000000000    1    0    1
      0.666666666667      0.333333333333      0.750000000000    1    0    1
&END
EOF
ulimit -s unlimited
#
# Run!
#
srun ${EXEC}  < ${INPUT_FILE} > ${OUTPUT_FILE}
done
done

