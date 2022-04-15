# C6H6

This directory contains an example of the SCF calculation of a benzene (C6H6) molecule in a box.

## Files and directories

- ``README.md`` : This file
- ``nfinp_scf`` : Input file for a single point calculation
- ``nfinp_opt`` : Input file for a structural optimization
- ``nfinp_opt_relaxed`` : Input file created using the optimized geometry
- ``nfinp_relaxed`` : Input file created using the optimized geometry
- ``nfinp_prtwfc`` : Input file for wave function plot
- ``run.sh`` : Job script
- ``C6H6.xsf`` : XSF file for the C6H6 molecule
- ``References/`` : Directory containing reference output file(s)
- ``Scripts/`` : Directory containing job scripts for different platforms.

## Execution

To submit a job, execute the following:

```bash
submitjob -a STATE -i run.sh -n 1 -p 8 -w 1
```

To change the task, modify the following lines in the job script and set the input and output files

INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf

