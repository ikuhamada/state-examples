#!/bin/sh

#SBATCH -J state_test
#SBATCH -p i8cpu
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -c 1
#SBATCH -t 00:30:00

module purge
module load intel_mpi/2020.4.304
module load intel_compiler/2020.4.304
module load intel_mkl/2020.4.304

JOB_LIST='scf band'

EXEC=./STATE

ln -fs ../gncpp/pot.Fe_pbe3

ulimit -s unlimited

for JOB in ${JOB_LIST}
do
INPUT_FILE=nfinp_${JOB}
OUTPUT_FILE=nfout_${JOB}
srun ${EXEC}  < ${INPUT_FILE} > ${OUTPUT_FILE}
if [ -e dos.data ];
then
  mv dos.data dos.data_${JOB}
fi
done
