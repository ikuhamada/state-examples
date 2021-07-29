set xrange [-12.5:7.5]
set yrange [0:2.0]
set xlabel 'Energy (eV)'
set ylabel 'DOS (arb. unit)'
plot 'dos.data' using 1:2 w l
pause -1
