set terminal postscript 'Helvetica' eps color 20
set output 'chgpro3-bc2-ef.eps'

zmin=-23.8811
zmax=23.5825

vmin=-0.4
vmax=0.1

set xrange [zmin:zmax]
set yrange [vmin:vmax]

set xlabel 'z (Bohr)'
set ylabel 'Hartree potential (Hartree)'

set xzeroaxis

plot 'chgpro3.dat_esm_bc2_ef+0.001' using 1:4 title '0.001 Hartree/Bohr' w l lw 2,\
     'chgpro3.dat_esm_bc2_ef-0.001' using 1:4 title '-0.001 Hartree/Bohr' w l lw 2,\

#pause -1
