#!/bin/sh
#SBATCH -J  Ni
#SBATCH -p  cmdinteractive
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

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential file

ln -fs ../gncpp/pot.Ni_pbe4

# Set the input/output file

INPUT_FILE=nfinp_scf+pdos
OUTPUT_FILE=nfout_scf+pdos

# Run!

ulimit -s unlimited

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

