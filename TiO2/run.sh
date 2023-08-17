#!/bin/sh
#SBATCH -J  TiO2
#SBATCH -p  cmdinteractive
#SBATCH -N  1
#SBATCH -n  24

# Load modules

module purge
module load oneapi_compiler/2023.0.0
module load oneapi_mkl/2023.0.0
module load oneapi_mpi/2023.0.0

# Set this variable to use with OpenAPI and IntelMPI

export FI_PROVIDER=psm3

# Set the STATE executable

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential files

ln -fs ../gncpp/pot.Ti_pbe3
ln -fs ../gncpp/pot.O_pbe3

# Set the input/output file

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

# Run!

ulimit -s unlimited

if [ -e gdiis.data ];
then
  rm -f gdiis.data
fi

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

