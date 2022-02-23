#$ -S /bin/sh
#$ -cwd
#$ -q rl.q
#$ -pe smp 6
#$ -N H2+H
 
# Disable the openMP parallelism
 
export OMP_NUM_THREADS=1
 
# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .
 
# Set the pseudopotential data

ln -fs ../../gncpp/pot.H_pbe1_sp_new

# Set the input/output file

INPUT_FILE=nfinp_fin
OUTPUT_FILE=nfout_fin

# Run!

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
