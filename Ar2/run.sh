#$ -S /bin/sh
#PBS -q xs2
#PBS -l select=1:ncpus=8:ompthreads=1:mpiprocs=8
#PBS -N Ar2

module load intel/2020.2.254
module load intelmpi/2020.2.254

cd $PBS_O_WORKDIR

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state-5.6.17/src/STATE .

# Set the pseudopotential data

ln -fs ../gncpp/pot.Ar_pbe1TM

ln -fs ../gncpp/vdwdphi.dat_d0.1 vdwdphi.dat
 
# Set the input/output file

INPUT_FILE=nfinp_ar2_scf_6.5
OUTPUT_FILE=nfout_ar2_scf_6.5

# Run!

mpirun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

