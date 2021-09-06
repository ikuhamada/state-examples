#!/bin/sh
#SBATCH -J  HCOOH
#SBATCH -p  i8cpu
#SBATCH -N  1
#SBATCH -n  16

# Load the modules

module load intel_compiler/2020.4.304
module load intel_mpi/2020.4.304
module load intel_mkl/2020.4.304

# Set the executable of the STATE code

ln -fs ${HOME}/state/src/STATE

# Set the pseudopotential data

ln -fs ../gncpp/pot.C_pbe1
ln -fs ../gncpp/pot.O_pbe1
ln -fs ../gncpp/pot.H_lda1

# Set the input/output file

INPUT_FILE=nfinp_qmd
OUTPUT_FILE=nfout_qmd

ulimit -s unlimited

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

