set terminal postscript eps 'Helvetica' 22
#set output 'dos.eps'
set xrange [-10:5]
#set yrange [-4.0:4.0]
set xzeroaxis lt 1
set yzeroaxis
set key left top
set xlabel '{/Helvetica-Oblique E}-{/Helvetica-Oblique E}_F (eV)'
set ylabel 'Density of states (states/eV)'
set output 'dos_08x08x08.eps'
plot 'dos.data_scf' using ($1):($3) title 'Spin-up' with lines lt 1 lw 3,\
     ''         using ($1):(-$2) title 'Spin-down' with lines lt 2 lw 3
set output 'dos_16x16x16.eps'
plot 'dos.data_nscf' using ($1):($3) title 'Spin-up' with lines lt 1 lw 3,\
     ''              using ($1):(-$2) title 'Spin-down' with lines lt 2 lw 3
# pause -1
