# Ni

This directory contains an example of the SCF calculation of ferromagnetic nickel (Ni) in the face centered cubic (fcc) structure

## Files and directories

- ``README.md`` : This file
- ``nfinp_scf`` : Input file for a single point calculation
- ``nfinp_scf+pdos`` : Input file for a single point plus partial density of states (PDOS) calculation
- ``nfinp_scf_tetra`` : Input file for a single point calculation with the tetrahedron method
- ``run.sh`` : Job script
- ``Ni.xsf`` : XSF file for Ni
- ``References/`` : Directory containing reference output file(s)
- ``Scripts/`` : Directory containing job scripts for different platforms.

## Execution

To submit a job, execute the following:

```bash
submitjob -a STATE -i run.sh -n 1 -p 8 -w 1
```

To change the input/output file for a different task, change the following lines in the job script

```
INPUT_FILE=nfinp_scf
OUTPUT_FILE=nfout_scf
```

