#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N C2H4

# Disable OPENMP parallelism

setenv OMP_NUM_THREADS 1

# Set the execuable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.C_pbe3
ln -fs ../gncpp/pot.H_lda3

# Set the input/output file

INPUT_FILE=nfinp_gdiis
OUTPUT_FILE=nfout_gdiis
 
# Run!

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

