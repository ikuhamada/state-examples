#!/bin/sh

#SBATCH --job-name=Ar2
#SBATCH --partition=small
#SBATCH --ntasks=16
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --output=%x.%j.out 
#SBATCH --error=%x.%j.err

module load mpi mkl

export OMP_NUM_THREADS=1

ln -fs ${HOME}/STATE/src/state/src/STATE

ln -fs ${HOME}/STATE/gncpp/pot.Ar_pbe1TM
#ln -fs ../gncpp/pot.Ar_pbe1TM

ln -fs ${HOME}/STATE/gncpp/vdwdphi.dat_d0.1 vdwdphi.dat
ln -fs ../gncpp/vdwdphi.dat_d0.1 vdwdphi.dat

DIST_LIST='4.0 5.0 5.5 6.0 6.5 7.0 7.5 8.0 9.0 10.0 11.0 12.0'

for DIST in ${DIST_LIST}
do

INPUT_FILE=nfinp_ar2_scf_${DIST}
OUTPUT_FILE=nfout_ar2_scf_${DIST}
cat > ${INPUT_FILE} <<EOF
#
# Ar dimer in a rectangular box
#
WF_OPT    DAV
NTYP      1
NATM      2
GMAX      6.00
GMAXP     12.00
NSCF      200
WIDTH     0.0010
EDELTA    1.D-10
NEG       24
XCTYPE    rev-vdW-DF2
CELL      20.0000  20.0000  30.0000  90.0000  90.0000  90.0000
&ATOMIC_SPECIES
 Ar  39.9480  pot.Ar_pbe1TM
&END
&ATOMIC_COORDINATES CARTESIAN
  0.0000  0.0000  0.0000    1    1    1
  0.0000  0.0000  ${DIST}   1    1    1
&END
EOF

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done

INPUT_FILE=nfinp_ar1_scf
OUTPUT_FILE=nfout_ar1_scf
cat > ${INPUT_FILE} <<EOF
#
# Ar atom in a rectangular box
#
WF_OPT    DAV
NTYP      1
NATM      1
GMAX      6.00
GMAXP     12.00
NSCF      200
WIDTH     0.0010
EDELTA    1.D-10
NEG       24
XCTYPE    rev-vdW-DF2
CELL      20.0000  20.0000  30.0000  90.0000  90.0000  90.0000
&ATOMIC_SPECIES
 Ar  39.9480  pot.Ar_pbe1TM
&END
&ATOMIC_COORDINATES CARTESIAN
  0.0000  0.0000  0.0000    1    1    1
&END
EOF

srun ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}


