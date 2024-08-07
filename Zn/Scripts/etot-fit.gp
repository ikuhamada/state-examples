e(x,y)=e0+c1*(x-x0)+c2*(y-y0)+c11*(x-x0)**2+c22*(y-y0)**2+c12*(x-x0)*(y-y0)

e0=-144.11196143
x0=5.00
y0=9.70
c1=0.001
c2=0.001
c11=0.07
c22=0.003
c12=0.010

# Use this one to estimate the initial values for coefficients
#fit e(x,y) 'etot.dat' using 1:2:3 via e0, c1, c2, c11, c22, c12

fit e(x,y) 'etot.dat' using 1:2:3 via e0, x0, y0, c1, c2, c11, c22, c12

set xrange [4.8:5.1]
set yrange [9.5:10.0]
set zrange [-144.112:-144.110]

set xlabel 'a (Bohr)'
set ylabel 'c (Bohr)'
set zlabel 'Total energy (Hartree)'

set format x '%4.2f'
set format y '%4.2f'
set format z '%8.4f'

set pm3d at b
splot e(x,y), 'etot.dat'

pause -1

