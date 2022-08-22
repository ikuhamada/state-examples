#!/bin/sh
 
#QSUB2 queue qD
#QSUB2 core  24
#QSUB2 mpi   24
#QSUB2 smp    1
#QSUB2 wtime 01:00:00
#PBS -N GR
 
cd $PBS_O_WORKDIR

. /etc/profile.d/modules.sh

module load comp1
module load fftw/3.3.8_comp1
 
NNODE=24
NCORE=1

JOB_LIST='scf band'

if [ -z ${JOB_LIST} ];
then
if [ -e job_list ];
then
JOB_LIST=`cat job_list`
else
echo 'No job specified.'
exit
fi
fi

MPIRUN="mpijob -mpi ${NNODE} -smp ${NCORE}"
STATE="./STATE"

for JOB in ${JOB_LIST}
do

INPUT_FILE=nfinp_${JOB}
OUTPUT_FILE=nfout_${JOB}

if [ -e gdiis.data ];
then
mv gdiis.data gdiis.data_${JOB}
fi
 
${MPIRUN} ${STATE} < $INPUT_FILE > $OUTPUT_FILE

if [ -e GEOMETRY ];
then
cp GEOMETRY GEOMETRY_${JOB}
fi

done

rm -f GEOMETRY

###################
# End of the file #
###################
