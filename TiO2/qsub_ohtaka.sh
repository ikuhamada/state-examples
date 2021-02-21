#!/bin/sh
#SBATCH -J  TiO2
#SBATCH -p  i8cpu
#SBATCH -N  1
#SBATCH -n  24

# Load modules

module load intel_compiler/2020.2.254
module load intel_mpi/2020.2.254
module load intel_mkl/2020.2.254

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ../gncpp/pot.Ti_pbe3
ln -fs ../gncpp/pot.O_pbe3

# Set the input/output files

# Run!

ulimit -s unlimited

if [ -e gdiis.data ];
then
  rm -f gdiis.data
fi

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

