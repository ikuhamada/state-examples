#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N CO
#
setenv OMP_NUM_THREADS 1
#
# Execuable of the STATE code
ln -fs ${HOME}/STATE/src/state/src/STATE .
#
# Pseudopotential data
ln -fs ${HOME}/STATE/gncpp/pot.C_pbe1 fort.37
ln -fs ${HOME}/STATE/gncpp/pot.O_pbe1 fort.38
#
# Run!
mpirun -np $NSLOTS ./STATE < nfinp_scf > nfout_scf
