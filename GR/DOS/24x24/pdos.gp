set xrange [-20.0:10.0]
set yrange [0.00:0.25]
set xlabel 'E-E_F (eV)'
set ylabel 'DOS (states/eV)'
plot 'pdos_0001.dat' using ($1):($2)    w l title 's',\
     'pdos_0001.dat' using ($1):($3+$4) w l title 'p_x + p_y',\
     'pdos_0001.dat' using ($1):($5)    w l title 'p_z'
pause -1
