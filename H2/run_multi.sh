#$ -S /bin/sh
#$ -cwd
#$ -q all.q
#$ -pe smp 4
#$ -N H2
 
# Disable the openMP parallelism
 
export OMP_NUM_THREADS=1
 
# Set the executable of the STATE code

ln -fs ${HOME}/STATE/src/state/src/STATE .
 
# Set the pseudopotential data

ln -fs ../gncpp/pot.H_pbe1_sp_new
 
for d in $(seq 1.40 0.01 1.50)
do

# Set the input/output file

INPUT_FILE=nfinp_scf_${d}
OUTPUT_FILE=nfout_scf_${d}

cat > ${INPUT_FILE} << EOF
#
# H2 molecule
#
WF_OPT  DAV
NTYP 1
NATM 2
GMAX    6.00
GMAXP  20.00
MIX_ALPHA 0.7
WIDTH   0.0010
EDELTA  0.1000D-09
NEG     2
CELL   10.00000000  10.00000000  10.00000000  90.00000000  90.00000000  90.00000000
&ATOMIC_SPECIES
 H    2.000000 pot.H_pbe1_sp_new
&END
&INITIAL_ZETA
  0.0000
&END
&ATOMIC_COORDINATES CARTESIAN
      0.000000000000      0.000000000000      0.000000000000    1    1    1
      ${d}                0.000000000000      0.000000000000    1    1    1
&END
EOF

# Run!

mpirun -np $NSLOTS ./STATE < ${INPUT_FILE} > ${OUTPUT_FILE}

done

