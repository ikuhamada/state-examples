#!/bin/sh
#SBATCH -J  C2H4
#SBATCH -p  i8cpu
#SBATCH -N  1
#SBATCH -n  4

# Load the modules

module purge
module load oneapi_compiler/2023.0.0
module load oneapi_mkl/2023.0.0
module load oneapi_mpi/2023.0.0

# Set this variable to use with OpenAPI and IntelMPI

export FI_PROVIDER=psm3

# Set the STATE executable 

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential files

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

