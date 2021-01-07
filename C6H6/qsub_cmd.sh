#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N C6H6

#disable OPENMP parallelism
setenv OMP_NUM_THREADS 1

# execuable of the STATE code
ln -fs ${HOME}/STATE/src/state/src/STATE .

# pseudopotential data
ln -fs ../gncpp/pot.C_pbe3
ln -fs ../gncpp/pot.H_lda3
 
# launch STATE
mpirun -np $NSLOTS ./STATE < nfinp_scf > nfout_scf
