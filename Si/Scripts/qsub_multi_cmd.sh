#$ -S /bin/sh
#$ -cwd
#$ -q all.q
#$ -pe smp 4
#$ -N Si

# Disable OPENMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code
ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Si_pbe1

# Set the list of the lattice constants

ALAT_LIST='10.10 10.15 10.20 10.25 10.30 10.35 10.40 10.45 10.50'
 
# Run!

for ALAT in ${ALAT_LIST}
do
INPUT_FILE=nfinp_scf_${ALAT}
OUTPUT_FILE=nfout_scf_${ALAT}
# launch STATE
mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
done
