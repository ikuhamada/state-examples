#$ -S /bin/sh
#$ -cwd
#$ -q rl.q
#$ -pe smp 6
#$ -N ClonAl100

# Disable OPENMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Al_pbe1
ln -fs ../gncpp/pot.Cl_pbe1

# Set the input/output file 

INPUT_FILE=nfinp_gdiis_pbc
OUTPUT_FILE=nfout_gdiis_pbc
 
# Run!

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
