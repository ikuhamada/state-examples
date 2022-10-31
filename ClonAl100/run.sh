#!/bin/sh

#SBATCH --job-name=ClonAl100
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
ln -fs ../gncpp/pot.Cl_pbe1

ulimit -s unlimited

if [ -e gdiis.data ];
then
  rm -f gdiis.data
fi

INPUT_FILE=nfinp_gdiis_pbc
OUTPUT_FILE=nfout_gdiis_pbc
srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

mv gdiis.data gdiis.data_pbc

INPUT_FILE=nfinp_gdiis_esm
OUTPUT_FILE=nfout_gdiis_esm
srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

mv gdiis.data gdiis.data_esm

