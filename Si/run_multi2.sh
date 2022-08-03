#!/bin/sh

# Disable OpenMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Si_pbe1
 
# Run a set of jobs

a_list='10.20 10.25 10.30 10.35 10.40 10.45 10.50'

for a in ${a_list}
do
INPUT_FILE=nfinp_scf_${a}
OUTPUT_FILE=nfout_scf_${a}
sbatch ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
done
