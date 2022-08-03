#!/bin/sh

# Disable OpenMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Al_pbe1
ln -fs ../gncpp/pot.Cl_pbe1

# Set the input/output file 

INPUT_FILE=nfinp_gdiis_pbc
OUTPUT_FILE=nfout_gdiis_pbc
 
if [ -e gdiis.data ];
then
  rm -f gdiis.data
fi

# Run!

mpiexec ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
