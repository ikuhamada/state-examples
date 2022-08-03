#!/bin/sh

# Disable OpenMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.H_pbe1_sp_new
 
# Set the input/output file

INPUT_FILE=nfinp_qmd
OUTPUT_FILE=nfout_qmd

# Run!

sbatch ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

