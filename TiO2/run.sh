#!/bin/sh

#SBATCH --job-name=TiO2
#SBATCH --partition=small
#SBATCH --ntasks=8
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --output=%x.%j.out 
#SBATCH --error=%x.%j.err

module load mpi

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Ti_pbe3
ln -fs ../gncpp/pot.O_pbe3

# Set the input/output files

INPUT_FILE=nfinp_scf_ggapbe
OUTPUT_FILE=nfout_scf_ggapbe

# Run!

ulimit -s unlimited

if [ -e gdiis.data ];
then
  rm -f gdiis.data
fi

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

