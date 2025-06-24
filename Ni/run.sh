#!/bin/bash
#PBS -q xs2
#PBS -l select=1:ncpus=8:ompthreads=1:mpiprocs=8
#PBS -N Ni

module load intel/2020.2.254
module load intelmpi/2020.2.254

cd $PBS_O_WORKDIR

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.17/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Ni_pbe4

# Set the input/output file

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf
 
# Run!

mpirun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

