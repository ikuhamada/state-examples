#!/bin/sh
#SBATCH -J  Al
#SBATCH -p  i8cpu
#SBATCH -N  1
#SBATCH -n  4

module load intel_compiler/2020.2.254
module load intel_mpi/2020.2.254
module load intel_mkl/2020.2.254

ln -fs ${HOME}/STATE/src/state/src/STATE

ln -fs ../gncpp/pot.Al_pbe1

ulimit -s unlimited

srun ./STATE < nfinp_scf > nfout_scf

