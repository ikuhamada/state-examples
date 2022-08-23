#!/bin/sh
#SBATCH -J  GR
#SBATCH -p  cmdinteractive
#SBATCH -N  1
#SBATCH -n  4

# Load the modules

module load intel_compiler/2020.4.304
module load intel_mpi/2020.4.304
module load intel_mkl/2020.4.304

# Set the executable of the STATE code

ln -fs ${HOME}/state/src/STATE

# Set the pseudopotential data

ln -fs ../../gncpp/pot.C_pbe3

# Set the list of the tasks

JOB_LIST='scf'


# Set the List of the lattice constant a

A_LIST='4.54 4.56 4.58 4.60 4.62 4.64 4.66 4.68 4.70 4.72 4.74'

# Set the lattice constant c (10 Angstrom)

C='18.89726878'

# Run!

for A in ${A_LIST}
do

INPUT_FILE=nfinp_scf_a${A}
OUTPUT_FILE=nfout_scf_a${A}

cat > ${INPUT_FILE} << EOF
#
# Graphene
#
WF_OPT    DAV
NTYP      1
NATM      2
TYPE      0
NSPG     1017
GMAX      5.00
GMAXP    15.00
KPOINT_MESH   12  12  1
KPOINT_SHIFT  F   F   F
NSCF      400
WAY_MIX   3
MIX_WHAT  1
KBXMIX    20
MIX_ALPHA 0.4
SMEARING  MP
WIDTH     0.0010
EDELTA    0.1000D-11
NEG       24
CELL      ${A} ${A} ${C}  90.00  90.00 120.00
&ATOMIC_SPECIES
 C  12.0107 pot.C_pbe3
&END
&ATOMIC_COORDINATES CRYSTAL
      0.00000000000      0.00000000000      0.00000000000    1    1    1
      0.33333333333      0.66666666667      0.00000000000    1    1    1
&END
EOF

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done

