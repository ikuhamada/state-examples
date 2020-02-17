#!/bin/sh

#QSUB -queue i18cpu
#QSUB -node 1
#QSUB -mpi  4
#QSUB -omp  1
#QSUB -place pack
#QSUB -over false
#PBS -l walltime=00:30:00
#PBS -N CO
 
cd $PBS_O_WORKDIR

. /etc/profile.d/modules.sh

module load intel/18.0.5.274
module load intel-mpi/2018.4.274

ln -fs $HOME/STATE/src/state/src/STATE

ln -fs $HOME/STATE/gncpp/pot.C_pbe1 fort.37
ln -fs $HOME/STATE/gncpp/pot.O_pbe1 fort.38

mpijob ./STATE < nfinp_1 > nfout_1

