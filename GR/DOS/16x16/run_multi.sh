#!/bin/sh

#SBATCH --job-name=GR
#SBATCH --partition=small
#SBATCH --ntasks=8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err

module load mpi mkl

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ../gncpp/pot.C_pbe3

# Set the list of the tasks

JOB_LIST='scf band'

# Run!

for JOB in ${JOB_LIST}
do

INPUT_FILE=nfinp_${JOB}
OUTPUT_FILE=nfout_${JOB}

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done

