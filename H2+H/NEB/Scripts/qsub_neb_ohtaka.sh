#!/bin/sh
#SBATCH -J  H2+H
#SBATCH -p  i8cpu
#SBATCH -N  1
#SBATCH -n  20
#SBATCH -c  2

# Load modules

module purge
module load oneapi_compiler/2023.0.0
module load oneapi_mkl/2023.0.0
module load oneapi_mpi/2023.0.0

ulimit -s unlimited
export FI_PROVIDER=psm3

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

CMDFILE=replica.cmd

if [ -e ${CMDFILE} ];
then
subdir_list=`cat replica.cmd`
for subdir in $subdir_list
do
  if [ -d ${subdir} ];
  then
    cd $subdir
    ln -fs ${HOME}/STATE/gncpp/pot.H_pbe1_sp_new
    cd ..
  fi
done
else
  echo ${CMDFILE} not found.
  exit
fi

# Set the input/output file

OUTPUT_FILE=neb.out

# Run!

ulimit -s unlimited

srun ./STATE > ${OUTPUT_FILE}

