#$ -S /bin/sh
#$ -cwd
#$ -q sb.q
#$ -pe x6 6
#$ -N GR

# Disable OpenMP parallelism

export OMP_NUM_THREADS=1

# Set the execuable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.14/src/STATE .

# Set the pseudopotential data

ln -fs ../../../gncpp/pot.C_pbe3
 
# Set the input/output file

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

# Run!

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
