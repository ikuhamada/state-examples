#!/bin/bash
#PBS -q x21
#PBS -l select=1:ncpus=64:ompthreads=1:mpiprocs=64
#PBS -N Cu_hcp

module load intel/2020.2.254
module load intelmpi/2020.2.254

cd $PBS_O_WORKDIR

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.17/src/STATE .

# Set the pseudopotential data

ln -fs ../../gncpp/pot.Cu_pbe1

# Set the list of the lattice constants

ALAT_LIST='2.40 2.45 2.50 2.55 2.60 2.65 2.70'
CBYA_LIST='1.60 1.633 1.66 1.70 1.74'
 
bohr=0.529177210544

# Run!

for CBYA in ${CBYA_LIST}
do

for ALAT in ${ALAT_LIST}
do

INPUT_FILE=nfinp_scf_'cbya_'${CBYA}'_'${ALAT}'_ang'
OUTPUT_FILE=nfout_scf_'cbya_'${CBYA}'_'${ALAT}'_ang'
 
A_BOHR=`echo "scale=8; $ALAT / $bohr" | bc`
C_BOHR=`echo "scale=8; $ALAT * $CBYA / $bohr" | bc`

cat > ${INPUT_FILE} << EOF
#
# Cu in the hexagonal closed pack structure
#
NTYP   1
NATM   2
TYPE   0
NSPG   194
GMAX    6.00
GMAXP  20.00
KPOINT_MESH  12  12  08
MIX_ALPHA 0.3
SMEARING  MP
WIDTH  0.0020
EDELTA 1.0D-10
NEG    16
CELL   ${A_BOHR} ${A_BOHR} ${C_BOHR}  90.00  90.00 120.00
&ATOMIC_SPECIES
 Cu  63.5460  pot.Cu_pbe1
&END
&ATOMIC_COORDINATES CRYSTAL
      0.333333333333      0.666666666667      0.250000000000    1    1    1
      0.666666666667      0.333333333333      0.750000000000    1    1    1
&END
EOF
 
# launch STATE
mpirun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done

done


