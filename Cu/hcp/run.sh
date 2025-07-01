#!/bin/bash
#PBS -q xs2
#PBS -l select=1:ncpus=16:ompthreads=1:mpiprocs=16
#PBS -N Cu_hcp

module load intel/2020.2.254
module load intelmpi/2020.2.254

cd $PBS_O_WORKDIR

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.17/src/STATE .

# Set the pseudopotential data

ln -fs ../../gncpp/pot.Cu_pbe1

# Set the list of the lattice constants

# Run!

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

# launch STATE

mpirun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

