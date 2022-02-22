# H<sub>2</sub> + H

This example shows how to perform a nudged elastic band (NEB) calculation for a reaction path search.

We consider a reaction: H<sub>2</sub> + H &rarr; H + H<sub>2</sub>, inspired by an example contained in Quantum-ESPRESSO.

In the following, how to prepare and run a NEB calculation  with STATE is described. How to analyze the result will be given in the STATE documantation.

## Calculation of the initial and final states

In a NEB calculation, initial and final state structures should be determined first.
To save time, these structures and corresponding input files are stored in ``Initial`` and ``Final`` directories.

In the ``Initial`` and ``Final`` directories, run SCF calculations using the input files ``nfinp_ini`` and ``nfinp_fin`` and confirm that the forces acting on the atoms are small enough.


## Preparing the NEB calculation

To run a NEB calculation, we need a set of intermediate structures (images), which we create by linear interpolation of initial and final structures. For this purpose, a utility program ``prepneb`` can be used as follows.

Go to the ``NEB`` directory and type

```bash
prepneb -ndiv 6 -ini ../Initial/nfinp_ini -fin ../Final/nfinp_fin
```

This creates input files (named nfinp.data) correspodning to the total 7 (6+1) images including initial and final structures, contained in the subdirectories (01, 02, ..., 07). This utlity also creates files called ``nudged_2``, which are actually used to write and read the structure during the NEB calculation, and also used for the calculations of the neighboring images. Next to the initial (final) image, we also need the file called ``nudged_terminal_s`` (``nudged_terminal_e``), which should be placed in the directory ``02`` (``06``) in this case.

## Running the NEB calculation

In a recent version of the STATE code, we mostly do what we call replica-parallel (or image-parallel) NEB, in which the calculatios are parallelized over the image. In the replica parallel NEB calculation, the number of images should be divisable by the number of cores to be used.
In addition, we need the ``replica.cmd`` file as:

   ASYNC
   02
   03
   04
   05
   06

in the ``replica.cmd`` file, first line specify if the images are syncronized or not (use ``ASYNC`` or ``NEB`` for the NEB calculation).
In the following lines, the names of the subdirectories for the intermediate images are given (usually we do not include initial and final images).

In addition to the input file (``nfinp.data``) and geometry files (``nudged_2``, ``nudged_terminal_s``, and ``nudged_terminal_e``), pseudopotetials used should be placed in each subdirectory.

Having prepared all the necessary files, we execute

```bash
mpirun -np 6 ./STATE > neb.log
```

without explicitly specifying the input file. Output files are generated in the each subdirectory.
