# GR

This directory contains examples of structural optimization, density of states, and band structure calculations of graphene. 

## Files and directories

- ``README.md`` : This file
- ``Band/`` : Band structure calculatio
- ``DOS/`` : Density of states calculation
- ``Opt/`` : Structural optimization

## Execution

To submit a job, check the input and output files and execute the following in the subdirectories:

```bash
submitjob -a STATE -i run.sh -n 1 -p 8 -w 1
```
