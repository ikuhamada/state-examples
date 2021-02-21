#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N TiO2

# Disable OPENMP parallelism

setenv OMP_NUM_THREADS 1

# Set the execuable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Ti_pbe3
ln -fs ../gncpp/pot.O_pbe3

# Set the input/output files

INPUT_FILE=nfinp_scf_ldapw91
OUTPUT_FILE=nfout_scf_ldapw91
 
# Run!

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
