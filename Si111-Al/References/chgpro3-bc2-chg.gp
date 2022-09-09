
zmin=-23.8811
zmax=23.5825

vmin=-0.4
vmax=0.1

set xrange [zmin:zmax]
set yrange [vmin:vmax]

set xlabel 'z (Bohr)'
set ylabel 'Hartree potential (Hartree)'

set xzeroaxis

plot 'chgpro3.dat_esm_bc2_chg+0.010' using 1:4 title '+0.01 e / unit cell' w l lw 2,\
     'chgpro3.dat_esm_bc2_chg-0.010' using 1:4 title '-0.01 e / unit cell' w l lw 2,\

pause -1
