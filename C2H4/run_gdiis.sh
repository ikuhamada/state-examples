#$ -S /bin/sh
#$ -cwd
#$ -q sb.q
#$ -pe x6 6
#$ -N C2H4_GDIIS

module load intel/2021.2.0
module load intelmpi/2021.2.0

# Disable OPENMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.14/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.C_pbe3
ln -fs ../gncpp/pot.H_lda3

# Set the input/output file

INPUT_FILE=nfinp_gdiis
OUTPUT_FILE=nfout_gdiis
 
# Run!

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

