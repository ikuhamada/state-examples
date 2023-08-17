#!/bin/sh
#SBATCH -J  ClonAl100
#SBATCH -p  cmdinteractive
#SBATCH -N  1
#SBATCH -n  16

# Load the modules

module purge
module load oneapi_compiler/2023.0.0
module load oneapi_mkl/2023.0.0
module load oneapi_mpi/2023.0.0

# Set this variable to use with OpenAPI and IntelMPI

export FI_PROVIDER=psm3

# Set the STATE executable

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential files

ln -fs ../gncpp/pot.Al_pbe1 
ln -fs ../gncpp/pot.Cl_pbe1

# Run!

job_list='gdiis_pbc gdiis_esm'

for job in ${job_list}
do

ulimit -s unlimited

INPUT_FILE=nfinp_${job}
OUTPUT_FILE=nfout_${job}
GDIIS_FILE=gdiis.data_${job}

if [ -e gdiis.data ];
then
  rm -f gdiis.data
fi

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

if [ - e gdiis.data ];
then
 mv gdiis.data ${GDIIS_FILE}
fi

done


