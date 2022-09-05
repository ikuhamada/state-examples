#!/bin/sh
#SBATCH -J  ClonAl100
#SBATCH -p  cmdinteractive
#SBATCH -N  1
#SBATCH -n  16

module load intel_compiler/2020.4.304
module load intel_mpi/2020.4.304
module load intel_mkl/2020.4.304

ln -fs ${HOME}/STATE/src/state/src/STATE .

ln -fs ../gncpp/pot.Al_pbe1 
ln -fs ../gncpp/pot.Cl_pbe1

ulimit -s unlimited

if [ -e gdiis.data ];
then
  rm -f gdiis.data
fi

srun ./STATE < nfinp_gdiis_pbc > nfout_gdiis_pbc
mv gdiis.data gdiis.data_pbc

srun ./STATE < nfinp_gdiis_esm > nfout_gdiis_esm
mv gdiis.data gdiis.data_esm

