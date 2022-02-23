#$ -S /bin/sh
#$ -cwd
#$ -q rl.q
#$ -pe x6 6
#$ -N GR

# Disable OPENMP parallelism

export OMP_NUM_THREADS=1

# Set the execuable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../../../gncpp/pot.C_pbe3

# Set the input/output file

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf
 
# Run!

mpirun -np $NSLOTS ./STATE < nfinp_scf > nfout_scf
