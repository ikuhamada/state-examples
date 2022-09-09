#!/bin/sh

# Preparing the STATE run

## STATE

state_src_dir=~/STATE/src/state/src
STATE=STATE

## Pseudopotential(s)

ppdir=~/STATE/gncpp
pps1='Zn_pbe1'		# for 1st-3rd pseudopotentials
pps2=''			# for 4th-6th pseudopotentials

## Directories for the NEB run

#subdir_list='02 03 04 05 06'

if [ -z ${subdir_list} ];
then

ln -fs ${state_src_dir}/${STATE} STATE

### Make symbolic links to pseudos

iopp=36

for pp in $pps1
do
  if [ ! -d ${ppdir}/${pp} ];then
    echo ${ppdir}/${pp} not found.
    exit
  else
    echo ${ppdir}/${pp}
  fi
  iopp=`expr $iopp + 1`
  echo ${pp} '->' fort.${iopp}
  ln -fs ${ppdir}/${pp}/#vnew.data pot.${pp}
  # ln -fs ${ppdir}/${pp}/#vnew.data fort.${iopp}
done

### Make a symbolic link to vdW kernel

ln -fs ${ppdir}/vdwdphi.dat_d0.1 vdwdphi.dat

else

ln -fs ${state_src_dir}/${STATE} STATE

for subdir in ${subdir_list}
do

if [ -d ${subdir} ];
then

cd ${subdir}

### Make a symbolic link to STATE

# ln -fs ${state_src_dir}/${STATE} STATE

### Make symbolic links to pseudos

iopp=36

for pp in $pps1
do
  if [ ! -d ${ppdir}/${pp} ];then
    echo ${ppdir}/${pp} not found.
    exit
  else
    echo ${ppdir}/${pp}
  fi
  iopp=`expr $iopp + 1`
  echo ${pp} '->' fort.${iopp}
  ln -fs ${ppdir}/${pp}/#vnew.data pot.${pp}
done

### Make a symbolic link to vdW kernel

ln -fs ${ppdir}/vdwdphi.dat_d0.1 vdwdphi.dat

cd ..

fi

done

fi
