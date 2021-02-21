#!/bin/sh
#SBATCH -J  GR
#SBATCH -p  i8cpu
#SBATCH -N  1
#SBATCH -n  16

# Load the modules

module load intel_compiler/2020.2.254
module load intel_mpi/2020.2.254
module load intel_mkl/2020.2.254

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ../../gncpp/pot.C_pbe3

# Set the list of the tasks

JOB_LIST='scf band'

# Run!

for JOB in ${JOB_LIST}
do

INPUT_FILE=nfinp_${JOB}
OUTPUT_FILE=nfout_${JOB}

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done

