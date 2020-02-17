bohr2nm=0.0529177
ha2ev=13.6058*2.0
#set terminal x11
set xrange [  0.0000*bohr2nm: 30.3075*bohr2nm]
set xlabel 'z / nm'
set ylabel 'Charge density / e*nm**(-3)'
plot 'chgpro.dat_pbc' using ($1*bohr2nm):($2/bohr2nm/bohr2nm/bohr2nm) title '' with lines lw 4
pause -1
reset
#set terminal x11
set xrange [  0.0000*bohr2nm: 30.3075*bohr2nm]
set arrow from   0.0000*bohr2nm, -0.0537*ha2ev to  30.3075*bohr2nm,  -0.0537*ha2ev nohead lt 0 lw 2
set xlabel 'z / nm'
set ylabel 'Potential / eV'
plot 'chgpro.dat_pbc' using ($1*bohr2nm):($3*ha2ev) title 'Kohn-Sham' with lines lw 4,\
     'chgpro.dat_pbc' using ($1*bohr2nm):($4*ha2ev) title 'Electrostatic' with lines lw 4
pause -1
