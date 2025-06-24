#!/bin/bash
#PBS -q xs2
#PBS -l select=1:ncpus=8:ompthreads=1:mpiprocs=8
#PBS -N Si

module load intel/2021.2.0
module load intelmpi/2021.2.0

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.17/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Si_pbe1

# Set the list of the lattice constants

ALAT_LIST='10.20 10.25 10.30 10.35 10.40 10.45 10.50'
 
# Run!

for ALAT in ${ALAT_LIST}
do
INPUT_FILE=nfinp_scf_${ALAT}
OUTPUT_FILE=nfout_scf_${ALAT}
# launch STATE
mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
done
