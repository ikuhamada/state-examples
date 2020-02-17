#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N CO

#disable OPENMP parallelism
setenv OMP_NUM_THREADS 1

# execuable of the STATE code
ln -fs ${HOME}/STATE/src/state-5.6.6_beta/src/STATE .

# pseudopotential data
ln -fs ${HOME}/STATE/gncpp/pot.C_pbe1 fort.37
ln -fs ${HOME}/STATE/gncpp/pot.O_pbe1 fort.38
 
# launch STATE
mpirun -np $NSLOTS ./STATE < nfinp_1 > nfout_1
