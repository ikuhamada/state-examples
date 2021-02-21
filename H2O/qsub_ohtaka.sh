#!/bin/sh
#SBATCH -J  H2O
#SBATCH -p  i8cpu
#SBATCH -N  1
#SBATCH -n  16

# Load modules

module load intel_compiler/2020.2.254
module load intel_mpi/2020.2.254
module load intel_mkl/2020.2.254

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ../gncpp/pot.H_pbe1
ln -fs ../gncpp/pot.O_pbe1

# Set the input/output file

INPUT_FILE=nfinp_opt
OUTPUT_FILE=nfout_opt

# Run!

ulimit -s unlimited

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

