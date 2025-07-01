#!/bin/bash
#PBS -q x17
#PBS -l select=1:ncpus=32:ompthreads=2:mpiprocs=16
#PBS -N Cu_fcc

module load intel/2020.2.254
module load intelmpi/2020.2.254

cd $PBS_O_WORKDIR

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.17/src/STATE .

# Set the pseudopotential data

ln -fs ../../gncpp/pot.Cu_pbe1

# Set the list of the lattice constants

ALAT_LIST='3.40 3.45 3.50 3.55 3.60 3.65 3.70 3.75 3.80'
 
bohr=0.529177210544

# Run!

for ALAT in ${ALAT_LIST}
do
INPUT_FILE=nfinp_scf_${ALAT}'_ang'
OUTPUT_FILE=nfout_scf_${ALAT}'_ang'
#
A_BOHR=`echo "scale=8; $ALAT / $bohr" | bc`
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
KPOINT_MESH   12  12  12
MIX_ALPHA 0.3
SMEARING  MP
WIDTH  0.0020
EDELTA 1.0D-10
NEG    16
CELL   ${A_BOHR} ${A_BOHR} ${A_BOHR} 90.00  90.00  90.00
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

