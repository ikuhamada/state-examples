#!/bin/sh

#SBATCH -J MoS2
#SBATCH -p cmdinteractive
#SBATCH -N 1
#SBATCH -n 128
#SBATCH -c 1
#SBATCH -t 00:30:00

module load intel_mpi/2020.4.304
module load intel_compiler/2020.4.304

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ../gncpp/pot.Mo_pbe1
ln -fs ../gncpp/pot.S_pbe1

JOB_LIST='scf'

ulimit -s unlimited

for JOB in ${JOB_LIST}
do
INPUT_FILE=nfinp_${JOB}
OUTPUT_FILE=nfout_${JOB}
srun ./STATE  < ${INPUT_FILE} > ${OUTPUT_FILE}
done
