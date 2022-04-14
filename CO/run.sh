#!/bin/sh
 
# Disable the openMP parallelism
 
export OMP_NUM_THREADS=1
 
# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .
 
# Set the pseudopotential data

ln -fs ../gncpp/pot.C_pbe1
ln -fs ../gncpp/pot.O_pbe1
 
# Set the input/output file

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

# Run!

mpiexec ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
