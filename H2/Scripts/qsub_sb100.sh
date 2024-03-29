#$ -S /bin/sh
#$ -cwd
#$ -q sb.q
#$ -pe x6 6
#$ -N H2

module load intel/2021.2.0
module load intelmpi/2021.2.0

# Disable OPENMP parallelism

export OMP_NUM_THREADS=1

unset I_MPI_TCP_NETMASK

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.9/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.H_pbe1_sp_new
 
# Set the input/output file

INPUT_FILE=nfinp_qmd
OUTPUT_FILE=nfout_qmd

# Run!

mpirun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

