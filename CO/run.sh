#!/bin/sh

#SBATCH --job-name=CO
#SBATCH --partition=small
#SBATCH --ntasks=4
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --output=%x.%j.out 
#SBATCH --error=%x.%j.err

cd $SLURM_SUMBIT_DIR

module load mpi

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.C_pbe1
ln -fs ../gncpp/pot.O_pbe1

# Set the input/output files

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

# Run!

ulimit -s unlimited

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

