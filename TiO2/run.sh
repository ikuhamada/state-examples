#!/bin/bash
#PBS -q xs2
#PBS -l select=1:ncpus=8:ompthreads=1:mpiprocs=8
#PBS -N TiO2

module load intel/2020.2.254
module load intelmpi/2020.2.254

cd $PBS_O_WORKDIR

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Ti_pbe3
ln -fs ../gncpp/pot.O_pbe3

# Set the input/output files

INPUT_FILE=nfinp_scf_ldapw91
OUTPUT_FILE=nfout_scf_ldapw91
 
# Run!

mpirun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
