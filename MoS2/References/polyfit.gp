#set terminal x11
set xrange [  6.0000:  6.1000]
plot "etot.dat" using 1:2 title "sampling points","polyfit.dat" using 1:2 title "fit" with lines
pause -1
