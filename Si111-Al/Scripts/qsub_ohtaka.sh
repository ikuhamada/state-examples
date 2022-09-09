#!/bin/sh
#SBATCH -J Si111-Al
#SBATCH -p i8cpu
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -c 4
#SBATCH -t 00:30:00

module load intel_mpi/2020.4.304
module load intel_compiler/2020.4.304
module load intel_mkl/2020.4.304

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ../gncpp/pot.Si_pbe1
ln -fs ../gncpp/pot.Al_pbe1

# Set the input/output file

INPUT_FILE=nfinp_esm_bc1
OUTPUT_FILE=nfout_esm_bc1

# Run!

ulimit -s unlimited

srun ./STATE  < ${INPUT_FILE} > ${OUTPUT_FILE}
