#!/bin/sh

#SBATCH --job-name=Ar2
#SBATCH --partition=small
#SBATCH --ntasks=16
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --output=%x.%j.out 
#SBATCH --error=%x.%j.err

module load mpi mkl

export OMP_NUM_THREADS=1

ln -fs ${HOME}/STATE/src/state/src/STATE

ln -fs ${HOME}/STATE/gncpp/pot.Ar_pbe1TM
#ln -fs ../gncpp/pot.Ar_pbe1TM

ln -fs ${HOME}/STATE/gncpp/vdwdphi.dat_d0.1 vdwdphi.dat
ln -fs ../gncpp/vdwdphi.dat_d0.1 vdwdphi.dat

INPUT_FILE=nfinp_ar2_scf_6.5
OUTPUT_FILE=nfout_ar2_scf_6.5

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

