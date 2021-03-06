#!/bin/sh
#SBATCH -J  C2H4
#SBATCH -p  i8cpu
#SBATCH -N  1
#SBATCH -n  4

# Load the modules

module load intel_compiler/2020.2.254
module load intel_mpi/2020.2.254
module load intel_mkl/2020.2.254

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ../gncpp/pot.C_pbe3
ln -fs ../gncpp/pot.H_lda3

# Set the input/output file

INPUT_FILE=nfinp_vib
OUTPUT_FILE=nfout_vib

ulimit -s unlimited

if [ -e nfforce.data ];
then
  mv nfforce.data nfforce.data.bak
fi

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

