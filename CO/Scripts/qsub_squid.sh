#!/bin/bash
#PBS -q DBG
#PBS --group=G15577
#PBS -m b
#PBS -T intmpi
#PBS -l cpunum_job=4
#PBS -v OMP_NUM_THREADS=1
#PBS -l elapstim_req=00:10:00
#PBS -e ERR
#PBS -o OUT

module load BaseCPU/2023
module load BasePy/2023

cd $PBS_O_WORKDIR

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .
 
# Set the pseudopotential data

ln -fs ../gncpp/pot.C_pbe1
ln -fs ../gncpp/pot.O_pbe1
 
# Set the input/output file

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

# Run!

mpirun ${NQSV_MPIOPTS} ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

