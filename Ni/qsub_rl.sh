#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N Ni

#disable OPENMP parallelism
setenv OMP_NUM_THREADS 1

# execuable of the STATE code
ln -fs ${HOME}/STATE/src/state-5.6.6_beta/src/STATE .

# pseudopotential data
ln -fs ${HOME}/STATE/gncpp/pot.Ni_pbe4
 
# launch STATE
mpirun -np $NSLOTS ./STATE < nfinp_scf > nfout_scf
