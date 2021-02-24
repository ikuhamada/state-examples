#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N C6H6

# Disable OPENMP parallelism

export OMP_NUM_THREADS=1

# Set the execuable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.C_pbe3
ln -fs ../gncpp/pot.H_lda3
 
# Set the input/output file

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

# Run!
mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILES}
