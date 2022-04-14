#$ -S /bin/sh
#$ -cwd
#$ -q rl.q
#$ -pe x6 6
#$ -N C2H4

# Disable OPENMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.C_pbe3
ln -fs ../gncpp/pot.H_lda3

# Set the input/output file

INPUT_FILE=nfinp_gdiis
OUTPUT_FILE=nfout_gdiis
 
# Run!

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

