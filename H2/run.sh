#!/bin/bash
#PBS -q xs2
#PBS -l select=1:ncpus=8:ompthreads=1:mpiprocs=8
#PBS -N H2

module load intel/2021.2.0
module load intelmpi/2021.2.0

unset I_MPI_TCP_NETMASK

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.14/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.H_pbe1_sp_new
 
# Set the input/output file

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

# Run!

mpirun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

