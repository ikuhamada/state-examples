#!/bin/sh
#SBATCH -J state_test
#SBATCH -p i8cpu
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -c 4
#SBATCH -t 00:30:00
#SBATCH -e ERR
#SBATCH -o OUT

module load intel_mpi/2020.4.304
module load intel_compiler/2020.4.304
module load intel_mkl/2020.4.304

JOB_LIST='esm_bc3_chg-0.010 esm_bc3_chg-0.005 esm_bc3_chg+0.000 esm_bc3_chg+0.005 esm_bc3_chg+0.010 esm_bc2_chg-0.010 esm_bc2_chg+0.010 esm_bc2_ef-0.001 esm_bc2_ef+0.001'

EXEC=./STATE

ulimit -s unlimited

for JOB in ${JOB_LIST}
do
INPUT_FILE=nfinp_${JOB}
OUTPUT_FILE=nfout_${JOB}
srun ${EXEC}  < ${INPUT_FILE} > ${OUTPUT_FILE}
done
