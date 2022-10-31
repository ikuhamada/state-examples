#!/bin/sh

#SBATCH --job-name=Al
#SBATCH --partition=small
#SBATCH --ntasks=8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --output=%x.%j.out 
#SBATCH --error=%x.%j.err

module load mpi

export OMP_NUM_THREADS=1

ln -fs ${HOME}/STATE/src/state/src/STATE .

ln -fs ../gncpp/pot.Al_pbe1

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

ulimit -s unlimited

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

