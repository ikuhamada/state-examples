#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N Si

#disable OPENMP parallelism
setenv OMP_NUM_THREADS 1

# execuable of the STATE code
ln -fs ${HOME}/STATE/src/state/src/STATE .

# pseudopotential data
ln -fs ../gncpp/pot.Si_pbe1

ALAT_LIST='10.10 10.15 10.20 10.25 10.30 10.35 10.40 10.45 10.50'
 
for ALAT in ${ALAT_LIST}
do
NFINP=nfinp_scf_${ALAT}
NFOUT=nfout_scf_${ALAT}
# launch STATE
mpirun -np $NSLOTS ./STATE < ${NFINP} > ${NFOUT}
done
