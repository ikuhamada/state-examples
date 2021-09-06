#!/bin/sh
#SBATCH -J  Ni
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

ln -fs ../gncpp/pot.Ni_pbe4

# Set the input/output file

INPUT_FILE=nfinp_scf+pdos
OUTPUT_FILE=nfout_scf+pdos

# Run!

ulimit -s unlimited

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

