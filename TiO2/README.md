# TiO2

This directory contains an example of the SCF calculation of titanium dioxide (TiO2) in the rutile structure with LDA (PW91) and LDA+U.

## Files and directories

- ``README.md`` : This file
- ``nfinp_scf`` : Input file for a single point calculation with LDA+U
- ``nfinp_scf_ldapw91`` : Input file for a single point calculation with LDA
- ``run.sh`` : Job script
- ``Ti2O4.xsf`` : XSF file for the TiO2
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

