#!/bin/sh

# Disable OpenMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Si_pbe1
 
# Set the input/output file

INPUT_FILE=nfinp_scf_10.20
OUTPUT_FILE=nfout_scf_10.20
mpiexec ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

INPUT_FILE=nfinp_scf_10.25
OUTPUT_FILE=nfout_scf_10.25
mpiexec ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

INPUT_FILE=nfinp_scf_10.30
OUTPUT_FILE=nfout_scf_10.30
mpiexec ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

INPUT_FILE=nfinp_scf_10.35
OUTPUT_FILE=nfout_scf_10.35
mpiexec ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

INPUT_FILE=nfinp_scf_10.40
OUTPUT_FILE=nfout_scf_10.40
mpiexec ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

INPUT_FILE=nfinp_scf_10.45
OUTPUT_FILE=nfout_scf_10.45
mpiexec ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

INPUT_FILE=nfinp_scf_10.50
OUTPUT_FILE=nfout_scf_10.50
mpiexec ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
