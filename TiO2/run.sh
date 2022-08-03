#!/bin/sh

# Disable OpenMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Ti_pbe3
ln -fs ../gncpp/pot.O_pbe3

# Set the input/output files

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf
 
# Run!

sbatch ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
