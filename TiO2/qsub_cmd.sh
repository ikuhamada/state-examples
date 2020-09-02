#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N TiO2

#disable OPENMP parallelism
setenv OMP_NUM_THREADS 1

# execuable of the STATE code
ln -fs ${HOME}/STATE/src/state/src/STATE .

# pseudopotential data
ln -fs ${HOME}/STATE/gncpp/pot.Ti_pbe3
ln -fs ${HOME}/STATE/gncpp/pot.O_pbe3
 
# launch STATE
mpirun -np $NSLOTS ./STATE < nfinp_scf_ldapw91 > nfout_scf_ldapw91
