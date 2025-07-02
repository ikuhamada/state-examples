#set terminal postscript enhanced 20 eps color
#set output 'etot_calc.eps'

set terminal qt 20

xmin=2.1
xmax=3.0
ymin=-59.75
ymax=-59.70
set xrange [xmin:xmax]
set yrange [ymin:ymax]

set xlabel 'a (Angstrom)'
set ylabel 'E_{tot} (Hartree)'

set format y '%7.3f'

set key left top

plot 'etot_a.dat' title 'Calc.' with points pt 5

pause -1

f(x)=f0+a*(x-x0)+b*(x-x0)**2
f0=-59.7486
x0=2.40

fit f(x) 'etot_a.dat' via f0, x0, a, b

plot 'etot_a.dat' title 'Calc.' with points pt 5, [2.2:2.9] f(x) title 'Quadratic fit' with lines lt 1

pause -1

f(x)=f0+a*(x-x0)+b*(x-x0)**2+c*(x-x0)**3
f0=-59.7486
x0=2.40

fit f(x) 'etot_a.dat' via f0, x0, a, b, c

plot 'etot_a.dat' title 'Calc.' with points pt 5, [2.2:2.9] f(x) title 'Cubic fit' with lines lt 1

pause -1
