STATE examples
==============

Input examples for STATE, a plane-wave pseudopotential implementation of
the electronic structure method based on density functional theory.

To run STATE, make symbolic links to the STATE executable and pseudopotentials in the working directory, and execute

    mpirun -np 4 ./STATE < input_file > output_file

Example 0. CO
-------------
This example shows how to get started with STATE.

1. Si
-----
This example explains how to perform the self-consistent field (SCF) calculation and cell optimization of a crystalline solid.

2. Al
-----
This example explains how to perform the SCF calculation of a metallic system using the smearing technique.

3. Ni
-----
This example explains how to perform the SCF calculation of a spin polarized system.

4. C2H4
-------
This example explains how to perform the structural optimization and vibrational mode analysis by using a molecular system.

5. ClonAl100
------------
This example explains how to model an adsorbate on a surface by using Cl atom on Al(100).
