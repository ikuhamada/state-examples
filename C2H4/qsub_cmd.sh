#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N C2H4

#disable OPENMP parallelism
setenv OMP_NUM_THREADS 1

# execuable of the STATE code
ln -fs ${HOME}/STATE/src/state-5.6.6_beta/src/STATE .

# pseudopotential data
ln -fs ${HOME}/STATE/gncpp/pot.C_pbe3
ln -fs ${HOME}/STATE/gncpp/pot.H_lda3
 
# launch STATE
mpirun -np $NSLOTS ./STATE < nfinp_gdiis > nfout_gdiis
