#!/bin/sh
#SBATCH -J  H2+H
#SBATCH -p  cmdinteractive
#SBATCH -N  1
#SBATCH -n  4

# Load modules

module load intel_compiler/2020.2.254
module load intel_mpi/2020.2.254
module load intel_mkl/2020.2.254

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ${HOME}/STATE/gncpp/pot.H_pbe1_sp_new

# Set the input/output file

INPUT_FILE=nfinp_ini
OUTPUT_FILE=nfout_ini

# Run!

ulimit -s unlimited

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

