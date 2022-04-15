# ClonAl100

This directory contains examples of the calculations of an adsorption system [ a Cl atom on al(100)] with periodic boundary condition (PBC) and effective screening medium (ESM) method

## Files and directories

- ``README.md`` : This file
- ``nfinp_gdiis_esm`` : Input file for the structural optimization with ESM
- ``nfinp_gdiis_pbc`` : Input file for the structural optimization with PBC
- ``run.sh`` : Job script
- ``Al6Cl.xsf`` : XSF file for Cl/Al(100)
- ``References/`` : Directory containing reference output file(s)
- ``Scripts/`` : Directory containing job scripts for different platforms.

## Execution

To submit a job, execute the following:

```bash
submitjob -a STATE -i run.sh -n 1 -p 8 -w 1
```

To change the task, modify the following lines in the job script to set the input and output files

```
INPUT_FILE=nfinp_gdiis_pbc
OUTPUT_FILE=nfout_gdiis_pbc
```
