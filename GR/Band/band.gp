set xrange [0.00000000:]
set yrange [-20:10]
set ylabel 'E - E_F (eV)'
set arrow from 0.89905566,-20 to 0.89905566,10 nohead lt 0
set arrow from 1.34858348,-20 to 1.34858348,10 nohead lt 0
set arrow from 2.12718852,-20 to 2.12718852,10 nohead lt 0
y0=-20-0.3
set label "{/Symbol G}" at 0.00000000,-20-0.3 center
set label "K" at 0.89905566,-20-0.3 center
set label "M" at 1.34858348,-20-0.3 center
set label "{/Symbol G}" at 2.12718852,-20-0.3 center
unset key
unset xtics
plot 'band.data' w l
pause -1
