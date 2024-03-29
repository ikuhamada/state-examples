#!/bin/sh
#SBATCH -J  GR
#SBATCH -p  cmdinteractive
#SBATCH -N  1
#SBATCH -n  4

# Load the modules

module load intel_compiler/2020.4.304
module load intel_mpi/2020.4.304
module load intel_mkl/2020.4.304

# Set the executable of the STATE code

ln -fs ${HOME}/state/src/STATE

# Set the pseudopotential data

ln -fs ../../gncpp/pot.C_pbe3

# Set the input/output files

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

# Run!

ulimit -s unlimited

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

