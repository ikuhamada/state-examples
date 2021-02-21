# STATE examples

Input examples for STATE, a plane-wave pseudopotential implementation of
the electronic structure method based on density functional theory.

To run STATE, make symbolic links to the STATE executable and pseudopotentials in the working directory and execute, for instance: 

    $ mpirun -np 4 ./STATE < input_file > output_file

or with a queueing system, one may use a job script (say, qsub.sh) like

    #$ -S /bin/sh
    #$ -cwd
    #$ -pe fillup 6
    #$ -N CO
    #
    setenv OMP_NUM_THREADS 1
    #
    # Set the execuable of the STATE code
    #
    ln -fs ${HOME}/STATE/src/state/src/STATE .
    #
    # Set the Pseudopotential data
    #
    ln -fs ${HOME}/STATE/gncpp/pot.C_pbe1
    ln -fs ${HOME}/STATE/gncpp/pot.O_pbe1
    # 
    # Run!
    #
    mpirun -np $NSLOTS ./STATE < nfinp_1 > nfout_1

and submit

    $ qsub qsub.sh

## Examples

### CO
This example shows how to get started with STATE.

### Si
This example explains how to perform the self-consistent field (SCF) calculation and cell optimization of a crystalline solid.

### Al
This example explains how to perform the SCF calculation of a metallic system using the smearing technique.

### Ni
This example explains how to perform the SCF calculation of a spin polarized system.

### C2H4
This example explains how to perform the structural optimization and vibrational mode analysis by using a molecular system.
A finite molecular dynamics simulation is also performed.

### ClonAl100
This example explains how to model an adsorbate on a surface by using a Cl atom on Al(100).

### GR
This example explains how to optimize the lattice constant, calculate the band structure, and (projected) density of states of a free-standing graphene.

### C6H6
This example explains how to perform the SCF calculation of molecular system and plot the wave functions (molecular orbitals) in real space. This also show that the atomic coordinate can be given in the XYZ format.

### TiO2
This example shows how to perform a DFT+U calculation by using rutile (TiO2).
