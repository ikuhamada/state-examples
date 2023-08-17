#!/bin/sh
#SBATCH -J  Ar2
#SBATCH -p  cmdinteractive
#SBATCH -N  1
#SBATCH -n  16

# Load modules
module purge
module load oneapi_compiler/2023.0.0
module load oneapi_mkl/2023.0.0
module load oneapi_mpi/2023.0.0

# Set this variable to use with OpenAPI and IntelMPI

export FI_PROVIDER=psm3

# Set the STATE executable

ln -fs ${HOME}/STATE/src/state/src/STATE

# Set the pseudopotentials

ln -fs ../gncpp/pot.Ar_pbe1TM

# Set the van der Waals kernel

ln -fs ../gncpp/vdwdphi.dat_d0.1 vdwdphi.dat

# Run

## Set the interatomic distances to calculate

DIST_LIST='4.0 5.0 5.5 6.0 6.5 7.0 7.5 8.0 9.0 10.0 11.0 12.0'

### Dimer calculations

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

### Monomer calculation

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


