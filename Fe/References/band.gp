set terminal postscript eps 'Helvetica' 22
set output 'band.eps'
G=0.0
H=1.16255844
N=1.98461140
P=2.56589063
G2=3.57269577
N2=4.39474873
emin=-10.0
emax=10.0
xmin=0.0
xmax=N2
offset=0.75
set xrange [xmin:xmax]
set yrange [emin:emax]
set key top right
unset xtics
unset xlabel
set ytics -10, 5, 10
set mytics 2
set ylabel 'E-E_F (eV)'
set xzeroaxis
set arrow from H,emin to H,emax nohead 
set arrow from N,emin to N,emax nohead 
set arrow from P,emin to P,emax nohead 
set arrow from G2,emin to G2,emax nohead 
set arrow from N2,emin to N2,emax nohead 
set label '{/Symbol G}' at G,emin-offset center
set label 'H' at H,emin-offset center
set label 'N' at N,emin-offset center
set label 'P' at P,emin-offset center
set label '{/Symbol G}' at G2,emin-offset center
set label 'N' at N2,emin-offset center
plot 'band_up.data' using 1:2  with lines title 'Spin-up' lt 1 lw 3,\
     'band_dw.data' using 1:2  with lines title 'Spin-down' lt 2 lw 3
