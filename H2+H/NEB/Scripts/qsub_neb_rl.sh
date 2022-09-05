#$ -S /bin/sh
#$ -cwd
#$ -q rl.q
#$ -pe x6 30
#$ -N H2+H_NEB

# Disable OPENMP parallelism

export OMP_NUM_THREADS=1

# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .

# Set the pseudopotential data

CMDFILE=replica.cmd

if [ -e ${CMDFILE} ];
then
subdir_list=`cat replica.cmd`
for subdir in $subdir_list
do
  if [ -d ${subdir} ];
  then
    cd $subdir
    ln -fs ${HOME}/STATE/gncpp/pot.H_pbe1_sp_new
    cd ..
  fi
done
else
  echo ${CMDFILE} not found.
  exit
fi

# Set the log file

OUTPUT_FILE=neb.out

# Run!

mpirun -np $NSLOTS ./STATE > ${OUTPUT_FILE}

