#!/bin/sh
#SBATCH -J state_test
#SBATCH -p i8cpu
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -c 4
#SBATCH -t 00:30:00
#SBATCH -e ERR
#SBATCH -o OUT

module purge
module load oneapi_compiler/2023.0.0
module load oneapi_mkl/2023.0.0
module load oneapi_mpi/2023.0.0

export FI_PROVIDER=psm3
ulimit -s unlimited

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotential data

ln -fs ../gncpp/pot.Si_pbe1
ln -fs ../gncpp/pot.Al_pbe1

# Set a list of jobs

JOB_LIST='esm_bc3_chg-0.010 esm_bc3_chg-0.005 esm_bc3_chg+0.000 esm_bc3_chg+0.005 esm_bc3_chg+0.010 esm_bc2_chg-0.010 esm_bc2_chg+0.010 esm_bc2_ef-0.001 esm_bc2_ef+0.001'

for JOB in ${JOB_LIST}
do

# Set the input/output file
INPUT_FILE=nfinp_${JOB}
OUTPUT_FILE=nfout_${JOB}

# Run!

ulimit -s unlimited
srun ./STATE  < ${INPUT_FILE} > ${OUTPUT_FILE}
done

