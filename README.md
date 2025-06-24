# STATE examples

Input examples for STATE, a plane-wave pseudopotential implementation of the electronic structure method based on density functional theory.

To run STATE, make symbolic links to the STATE executable and pseudopotentials in the working directory and execute, for instance: 

```bash
mpirun -np 6 ./STATE < [input_file] > [output_file]
```

or with a queueing system, one may use a job script (say, ``run.sh``) like

```
#!/bin/bash
#PBS -q xs2
#PBS -l select=1:ncpus=8:ompthreads=1:mpiprocs=8
#PBS -N CO

module load intel/2020.2.254
module load intelmpi/2020.2.254

cd $PBS_O_WORKDIR
 
# Set the executable of the STATE code
 
ln -fs ${HOME}/STATE/src/state-5.6.17/src/STATE .
 
# Set the Pseudopotential data
 
ln -fs ${HOME}/STATE/gncpp/pot.C_pbe1
ln -fs ${HOME}/STATE/gncpp/pot.O_pbe1
  
# Run!
 
mpirun ./STATE < nfinp_1 > nfout_1
```

and submit

```bash
    qsub run.sh
```

## Examples

### CO
This example shows how to get started with STATE.

### Si
This example explains how to perform a self-consistent field (SCF) calculation and cell optimization of a crystalline solid.

### Al
This example explains how to perform an SCF calculation of a metallic system using the smearing technique.

### Ni
This example explains how to perform an SCF calculation of a spin polarized system.

### Fe
This is yet another example explaining how to perform an SCF calculation of a spin polarized system.

### H2
This example explains how to perform structural optimization and vibrational mode analysis by using a molecular system.

### H2O
This example explains how to perform structural optimization and vibrational mode analysis by using a molecular system.

### HCOOH
Yet another example of a molecular system.

### C2H4
This example explains how to perform structural optimization and vibrational mode analysis by using a molecular system.
A finite molecular dynamics simulation is also performed.

### ClonAl100
This example explains how to model an adsorbate on a surface by using a Cl atom on Al(100).

### GR
This example explains how to optimize the lattice constant, calculate the band structure, and (projected) density of states of a free-standing graphene.

### C6H6
This example explains how to perform an SCF calculation of molecular system and plot the wave functions (molecular orbitals) in real space. This also show that the atomic coordinate can be given in the XYZ format.

### TiO2
This example shows how to perform a DFT+U calculation by using rutile (TiO2).
