# Si

This directory contains examples of the SCF calculation and cell optimization of silicon (Si) in the diamond structure.

## Files and directories

- ``README.md`` : This file
- ``References/`` : Directory containing reference output files
- ``Scripts/`` : Directory containing job scripts for different platforms
- ``Si2.xsf`` : XSF file for Si
- ``dos.gp`` : gnuplot script to plot the density of states
- ``nfinp_scf`` : Input file for an SCF calculation
- ``nfinp_scf_10.20`` : Input file for an SCF calculation at the lattice constant of 10.20 Bohr
- ``nfinp_scf_10.25`` : Input file for an SCF calculation at the lattice constant of 10.25 Bohr
- ``nfinp_scf_10.30`` : Input file for an SCF calculation at the lattice constant of 10.30 Bohr
- ``nfinp_scf_10.35`` : Input file for an SCF calculation at the lattice constant of 10.35 Bohr
- ``nfinp_scf_10.40`` : Input file for an SCF calculation at the lattice constant of 10.40 Bohr
- ``nfinp_scf_10.45`` : Input file for an SCF calculation at the lattice constant of 10.45 Bohr
- ``nfinp_scf_10.50`` : Input file for an SCF calculation at the lattice constant of 10.50 Bohr
- ``run.sh`` : Job script for a single point calculation
- ``run_multi1.sh`` : Job script for a set of single point calculations
- ``run_multi2.sh`` : Another job script for a set of single point calculations

## Execution

To submit a single point calculation, execute the following:

```bash
submitjob -a STATE -i run.sh -n 1 -p 8 -w 1
```

To submit a set of single point calculations, execute the following:

```bash
submitjob -a STATE -i run_multi1.sh -n 1 -p 8 -w 1
```

or 

```bash
submitjob -a STATE -i run_multi2.sh -n 1 -p 8 -w 1
```
