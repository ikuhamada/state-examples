#$ -S /bin/sh
#$ -cwd
#$ -q all.q
#$ -pe smp 4
#$ -N Si

# Disable OPENMP parallelism

export OMP_NUM_THREADS=1

# Define the pseudopotential(s)

pp1=pot.Si_pbesol1

A_LIST='10.15 10.20 10.25 10.30 10.35 10.40 10.45'

ln -fs $HOME/STATE/src/state/src/STATE

ln -fs ../../gncpp/${pp1}

for A in ${A_LIST}
do

INPUT_FILE=nfinp_scf_${A}
OUTPUT_FILE=nfout_scf_${A}

cat > ${INPUT_FILE} << EOF
#
# Crystalline silicon in the diamond structure
#
WF_OPT    DAV
NTYP      1
NATM      2
TYPE      2
NSPG      227
GMAX      4.00
GMAXP     8.00
KPOINT_MESH    8   8   8
WIDTH     0.0002
EDELTA    0.5000D-09
NEG       8
XCTYPE pbesol
CELL   ${A} ${A} ${A}  90.00  90.00  90.00
VERBOSITY LOW
&ATOMIC_SPECIES
 Si 28.0900 ${pp1}
&END
&ATOMIC_COORDINATES CRYSTAL
      0.000000000000      0.000000000000      0.000000000000    1    1    1
      0.250000000000      0.250000000000      0.250000000000    1    1    1
&END
EOF

ulimit -s unlimited
mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done

