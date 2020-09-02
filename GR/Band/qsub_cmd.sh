#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N GR

#disable OPENMP parallelism
setenv OMP_NUM_THREADS 1

# execuable of the STATE code
ln -fs ${HOME}/STATE/src/state/src/STATE .

# pseudopotential data
ln -fs ${HOME}/STATE/gncpp/pot.C_pbe3
 
# launch STATE
mpirun -np $NSLOTS ./STATE < nfinp_scf > nfout_scf
