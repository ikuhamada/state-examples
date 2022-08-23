#$ -S /bin/sh
#$ -cwd
#$ -q all.q
#$ -pe smp 4
#$ -N GR

# Disable OpenMP parallelism

export OMP_NUM_THREADS=1

# Set the execuable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../../../STATE/gncpp/pot.C_pbe3
 
# Set the list of the tasks
JOB_LIST='scf pdos scf+pdos' 

# Run!

for JOB in ${JOB_LIST}
do

INPUT_FILE=nfinp_${JOB}
OUTPUT_FILE=nfout_${JOB}

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done
