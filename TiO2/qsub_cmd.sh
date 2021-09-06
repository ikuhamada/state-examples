#$ -S /bin/sh
#$ -cwd
#$ -pe x6 6
#$ -N TiO2

# Disable OPENMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Ti_pbe3
ln -fs ../gncpp/pot.O_pbe3

# Set the input/output files

INPUT_FILE=nfinp_scf_ldapw91
OUTPUT_FILE=nfout_scf_ldapw91
 
# Run!

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
