#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N ClonAl100

#disable OPENMP parallelism

export OMP_NUM_THREADS=1

# execuable of the STATE code
ln -fs ${HOME}/STATE/src/state/src/STATE .

# pseudopotential data
ln -fs ../gncpp/pot.Al_pbe1
ln -fs ../gncpp/pot.Cl_pbe1
 
# launch STATE
mpirun -np $NSLOTS ./STATE < nfinp_gdiis_pbc > nfout_gdiis_pbc
