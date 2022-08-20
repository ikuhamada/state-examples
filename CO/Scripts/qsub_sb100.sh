#$ -S /bin/sh
#$ -cwd
#$ -q sb.q
#$ -pe x6 6
#$ -N CO

module load intel/2021.2.0
module load intelmpi/2021.2.0
 
# Disable the openMP parallelism
 
export OMP_NUM_THREADS=1

unset I_MPI_TCP_NETMASK
 
# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.9/src/STATE .
 
# Set the pseudopotential data

ln -fs ../gncpp/pot.C_pbe1
ln -fs ../gncpp/pot.O_pbe1
 
# Set the input/output file

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

# Run!

mpirun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}
