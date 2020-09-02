#$ -S /bin/sh
#$ -cwd
#$ -pe fillup 6
#$ -N GR

#disable OPENMP parallelism
setenv OMP_NUM_THREADS 1

# execuable of the STATE code
ln -fs ${HOME}/STATE/src/state/src/STATE .

# pseudopotential data
ln -fs ${HOME}/STATE/gncpp/pot.C_pbe3
 
# List of the lattice constant a
A_LIST='4.54 4.56 4.58 4.60 4.62 4.64 4.66 4.68 4.70 4.72 4.74'

# Lattice constant c (10 Angstrom)
C='18.89726878'

# launch STATE
for A in ${A_LIST}
do

INPUT_FILE=nfinp_scf_a${A}
OUTPUT_FILE=nfout_scf_a${A}

cat > ${INPUT_FILE} << EOF
#
# Graphene
#
WF_OPT    DAV
NTYP      1
NATM      2
TYPE      0
NSPG     1017
GMAX      5.00
GMAXP    15.00
KPOINT_MESH   12  12  1
KPOINT_SHIFT  F   F   F
NSCF      400
WAY_MIX   3
MIX_WHAT  1
KBXMIX    20
MIX_ALPHA 0.4
SMEARING  MP
WIDTH     0.0010
EDELTA    0.1000D-11
NEG       24
CELL      ${A} ${A} ${C}  90.00  90.00 120.00
&ATOMIC_SPECIES
 C  12.0107 pot.C_pbe3
&END
&ATOMIC_COORDINATES CRYSTAL
      0.00000000000      0.00000000000      0.00000000000    1    1    1
      0.33333333333      0.66666666667      0.00000000000    1    1    1
&END
EOF

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done
