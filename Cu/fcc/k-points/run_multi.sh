#!/bin/bash
#PBS -q xs2
#PBS -l select=1:ncpus=16:ompthreads=1:mpiprocs=16
#PBS -N Cu_fcc

module load intel/2020.2.254
module load intelmpi/2020.2.254

cd $PBS_O_WORKDIR

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.17/src/STATE .

# Set the pseudopotential data

ln -fs ../../../gncpp/pot.Cu_pbe1

# Set a set of k-point meshes

M_LIST='02 03 04 05 06 07 08 09 10 11 12 13 14'

for M in ${M_LIST}
do

INPUT_FILE=nfinp_scf_${M}'x'${M}'x'${M}
OUTPUT_FILE=nfout_scf_${M}'x'${M}'x'${M}

cat > ${INPUT_FILE} << EOF
#
# Cu in the face-centered cubic structure
#
NTYP   1
NATM   1
TYPE   2
NSPG   225
GMAX    6.00
GMAXP  20.00
KPOINT_MESH  ${M}  ${M}  ${M}
MIX_ALPHA 0.3
SMEARING  MP
WIDTH  0.0020
EDELTA 1.0D-10
NEG    16
CELL    6.8786  6.8786  6.8786  90.00  90.00  90.00
&ATOMIC_SPECIES
 Cu  63.5460  pot.Cu_pbe1
&END
&ATOMIC_COORDINATES CRYSTAL
      0.000000000000      0.000000000000      0.000000000000    1    1    1
&END
EOF

# launch STATE

mpirun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done


