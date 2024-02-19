#!/bin/sh
#SBATCH -J  Si
#SBATCH -p  i8cpu
#SBATCH -N  1
#SBATCH -n  4

# Load the modules

module load oneapi_compiler/2023.0.0
module load oneapi_mkl/2023.0.0
module load oneapi_mpi/2023.0.0

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ../../gncpp/pot.Si_lda1

# Set the input/output files

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

# Run!

ulimit -s unlimited

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

