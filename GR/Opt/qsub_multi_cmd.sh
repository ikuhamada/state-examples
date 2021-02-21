#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N GR

# Disable OPENMP parallelism
setenv OMP_NUM_THREADS 1

# Set the execuable of the STATE code
ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../../gncpp/pot.C_pbe3
 
# Set the list of the tasks
JOB_LIST='scf'

# Run!
for JOB in ${JOB_LIST}
do

INPUT_FILE=nfinp_${JOB}
OUTPUT_FILE=nfout_${JOB}

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done
