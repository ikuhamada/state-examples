# CO

This directory contains an example of the SCF calculation of a carbon monoxide (CO) molecule in a box.

## Files and directories

- ``README.md`` : This file
- ``nfinp_scf`` : Input file for the single point (SCF) calculation
- ``run.sh`` : Job script
- ``CO.xsf`` : XSF file for the CO molecule
- ``References/`` : Directory containing reference output file(s)
- ``Scripts/`` : Directory containing job scripts for different platforms.

## Execution

To submit a job, execute the following:

```bash
submitjob -a STATE -i run.sh -n 1 -p 8 -w 1
```
