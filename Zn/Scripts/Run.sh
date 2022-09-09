#!/bin/sh

#SBATCH -J Zn
#SBATCH -p i8cpu
#SBATCH -N 2
#SBATCH -n 128
#SBATCH -c 2
#SBATCH -t 00:30:00

module purge
module load intel_mpi/2020.4.304
module load intel_compiler/2020.4.304
module load intel_mkl/2020.4.304

JOB_LIST='scf'

EXEC=./STATE

ulimit -s unlimited

for SUFFIX in ${JOB_LIST}
do
INPUT_FILE=nfinp_${SUFFIX}
OUTPUT_FILE=nfout_${SUFFIX}
srun ${EXEC}  < ${INPUT_FILE} > ${OUTPUT_FILE}
done
