# Al

This directory contains an example of the SCF calculation of aluminum in the face centered cubic (fcc) structure

## Files and directories

- ``README.md`` : This file
- ``nfinp_scf`` : Input file
- ``run.sh`` : Job script
- ``Al.xsf`` : XSF file for Al
- ``References/`` : Directory containing reference output file(s)
- ``Scripts/`` : Directory containing job scripts for different platforms.

## Execution

To submit a job, execute the following:

```bash
submitjob -a STATE -i run.sh -n 1 -p 8 -w 1
```
