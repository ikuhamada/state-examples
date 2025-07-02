#set terminal postscript enhanced 20 eps color
#set output 'etot_calc.eps'

set terminal qt 20

xmin=3.3
xmax=3.9
ymin=-59.766
ymax=-59.746
set xrange [xmin:xmax]
set yrange [ymin:ymax]

set xlabel 'a (Angstrom)'
set ylabel 'E_{tot} (Hartree)'

set format y '%7.3f'

set key left top

plot 'etot_a.dat' title 'Calc.' with points pt 5

pause -1

f(x)=f0+a*(x-x0)+b*(x-x0)**2
f0=-59.7700
x0=3.65

fit f(x) 'etot_a.dat' via f0, x0, a, b

plot 'etot_a.dat' title 'Calc.' with points pt 5, [3.2:3.8] f(x) title 'Quadratic fit' with lines lt 1

pause -1
