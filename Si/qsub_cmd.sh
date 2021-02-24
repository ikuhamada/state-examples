#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N Si

# Disable OPENMP parallelism

export OMP_NUM_THREADS=1

# Set the execuable of the STATE code
ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Si_pbe1
 
# Set the input/output file

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

# Run!

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

