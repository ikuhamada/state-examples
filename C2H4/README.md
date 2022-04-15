# C2H4

This example explains how to perform the structural optimization and vibrational mode analysis by using a molecular system.
A finite molecular dynamics simulation is also performed.

This directory contains examples of the structural optimization using the GDIIS method, vibrational mode analysis, and finite temperature molecular dynamics of ethylene (C2H4) in a box.

## Files and directories

- ``README.md`` : This file
- ``nfinp_gdiis`` : Input file for the structural optimization with the GDIIS method
- ``nfinp_nhc`` : Input file for the finite temperature molecular dynamics with the Nose-Hoover chain
- ``nfinp_vib`` : Input file for the vibrational mode analysis
- ``nfvibrate.data`` : A file defining the atomic displacement(s) for the vibrational mode analysis
- ``run_gdiis.sh`` : Job script for the structural optimization
- ``run_md.sh`` : Job script for the finite temperature molecular dynamics
- ``run_vib.sh`` : Job script for the vibrational mode analysis
- ``traj2xyz.pl`` : A perl script to convert a TRAJECTORY file to an animated XYZ file
- ``C2H4.xsf`` : XSF file for the ethylene  molecule
- ``References/`` : Directory containing reference output file(s)
- ``Scripts/`` : Directory containing job scripts for different platforms.

## Execution

To submit a job for the structural optimization, execute the following:

```bash
submitjob -a STATE -i run_gdiis.sh -n 1 -p 8 -w 1
```

To submit a job for the vibrational mode analysis, execute the following:

```bash
submitjob -a STATE -i run_vib.sh -n 1 -p 8 -w 1
```

Finite temperature molecular dynamics can be performed by executing 

```bash
submitjob -a STATE -i run_md.sh -n 1 -p 16 -w 1
```
(number of cores is doubled to accelerate the calculation)
