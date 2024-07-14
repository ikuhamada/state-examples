#!/bin/sh
#SBATCH -J state_test
#SBATCH -p i8cpu
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -c 4
#SBATCH -t 00:30:00
#SBATCH -e ERR
#SBATCH -o OUT

module purge
module load oneapi_compiler/2023.0.0
module load oneapi_mkl/2023.0.0
module load oneapi_mpi/2023.0.0

export FI_PROVIDER=psm3
ulimit -s unlimited

JOB_LIST='esm_bc1'

EXEC=./STATE

for JOB in ${JOB_LIST}
do
INPUT_FILE=nfinp_${JOB}
OUTPUT_FILE=nfout_${JOB}
srun ${EXEC}  < ${INPUT_FILE} > ${OUTPUT_FILE}
done
