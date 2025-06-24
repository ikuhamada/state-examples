#!/bin/bash
#PBS -cwd
#PBS -q xs2
#PBS -l select=1:ncpus=8:ompthreads=1:mpiprocs=8
#PBS -N ClonAl100

module load intel/2021.2.0
module load intelmpi/2021.2.0

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.17/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Al_pbe1
ln -fs ../gncpp/pot.Cl_pbe1

# Set the input/output file 

INPUT_FILE=nfinp_gdiis_pbc
OUTPUT_FILE=nfout_gdiis_pbc

# Run!

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

if [ -e gdiis.data ];
then
  mv gdiis.data gdiis.data_save
fi
 
