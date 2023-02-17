#$ -S /bin/sh
#$ -cwd
#$ -q all.q
#$ -pe smp 4
#$ -N Ar2

# Disable OPENMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Ar_pbe1TM

ln -fs ../gncpp/vdwdphi.dat_d01.1 vdwdphi.dat
 
# Set the input/output file

INPUT_FILE=nfinp_ar2_scf_6.5
OUTPUT_FILE=nfout_ar2_scf_6.5

# Run!

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

