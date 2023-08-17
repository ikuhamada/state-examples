#!/bin/sh
#SBATCH -J  Ar2
#SBATCH -p  cmdinteractive
#SBATCH -N  1
#SBATCH -n  16

# Load modules

module purge
module load oneapi_compiler/2023.0.0
module load oneapi_mkl/2023.0.0
module load oneapi_mpi/2023.0.0

# Set this variable to use with OpenAPI and IntelMPI

export FI_PROVIDER=psm3

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ../gncpp/pot.Ar_pbe1TM

# Set the van der Waals kernel 

ln -fs ../gncpp/vdwdphi.dat_d0.1 vdwdphi.dat

INPUT_FILE=nfinp_ar2_scf_6.5
OUTPUT_FILE=nfout_ar2_scf_6.5

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

