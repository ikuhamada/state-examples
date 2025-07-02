#set terminal postscript enhanced 20 eps color
#set output 'etot_calc.eps'

set terminal qt 20

xmin=2.3
xmax=2.8
ymin=-119.5325
ymax=-119.5025
set xrange [xmin:xmax]
set yrange [ymin:ymax]

set xlabel 'a (Angstrom)'
set ylabel 'E_{tot} (Hartree)'

set format y '%7.3f'

set key left top

plot 'etot_cbya_1.600.dat' title 'c/a=1.600' with points pt 5, \
     'etot_cbya_1.633.dat' title 'c/a=1.633' with points pt 6, \
     'etot_cbya_1.660.dat' title 'c/a=1.660' with points pt 7, \
     'etot_cbya_1.700.dat' title 'c/a=1.700' with points pt 8, \
     'etot_cbya_1.740.dat' title 'c/a=1.740' with points pt 9


pause -1


