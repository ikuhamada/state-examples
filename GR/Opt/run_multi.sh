#$ -S /bin/sh
#$ -cwd
#$ -q sb.q
#$ -pe x6 6
#$ -N GR

# Disable OpenMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.14/src/STATE .

# Set the pseudopotential data

ln -fs ../../../gncpp/pot.C_pbe3
 
# Set the list of the tasks

JOB_LIST='scf'

# Run!

for JOB in ${JOB_LIST}
do

INPUT_FILE=nfinp_${JOB}
OUTPUT_FILE=nfout_${JOB}

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done
