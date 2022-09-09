set terminal postscript 'Helvetica' eps color 20
set output 'chgpro3.eps'

zmin=-23.8811
zmax=23.5825

vmin=-0.4
vmax=0.2

set xrange [zmin:zmax]
set yrange [vmin:vmax]

set xlabel 'z (Bohr)'
set ylabel 'Electrostatic potential (Hartree)'

set format y '%3.1f'

set xzeroaxis

plot 'chgpro3.dat_esm_bc3_chg-0.010' using 1:4 title '+0.010 {/Helvetica-Oblique e} / unit cell' w l lw 2,\
     'chgpro3.dat_esm_bc3_chg-0.005' using 1:4 title '+0.005 {/Helvetica-Oblique e} / unit cell' w l lw 2,\
     'chgpro3.dat_esm_bc3_chg+0.000' using 1:4 title 'Neutral' w l lw 2,\
     'chgpro3.dat_esm_bc3_chg+0.005' using 1:4 title '-0.005 {/Helvetica-Oblique e} /unit cell' w l lw 2,\
     'chgpro3.dat_esm_bc3_chg+0.010' using 1:4 title '-0.001 {/Helvetica-Oblique e} /unit cell' w l lw 2

#pause -1
