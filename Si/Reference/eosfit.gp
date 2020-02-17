#
# set terminal and output
#
#set terminal x11
#set terminal postscript enhanced 16
#set output "eosfit.ps"
#
# set initial values
v0=0.277179E+03
e0=-7.87364725
ec=-7.87364725
b0=0.1
b0p=4.0
#
# fit the data to the Murnaghan equation of state
#
#e(x)=b0*x/b0p*(1.0/(b0p-1.0)*(v0/x)**b0p-b0p/(b0p-1.0)*(v0/x)+1.0)+e0
e(x)=b0*x/b0p*(1.0/(b0p-1.0)*(v0/x)**b0p+1)+ec
fit e(x) "etot.dat" using 1:2 via b0,b0p,v0,ec
e0=e(v0)
B0=b0*29421.033
B0P=b0p
V0=v0
E0=e0
#
# print summary
#
print ""
print "              ************************************* "
print "              *** summary for Murnaghan EOS fit *** "
print "              ************************************* "
print ""
print "b0  = ",b0," (hartree/bohr^3) = ",B0," (GPa)"
print "b0' = ",B0P
print "v0  = ",V0," (bohr^3)  =",v0*0.148184534," (angstrom^3)"
print "e0  = ",E0," (hartree) =",e0*2.0," (Ry)"
#
# plot
#
set xlabel "Volume (Bohr^{3})"
set ylabel "Total energy (Hartree)"
plot e(x) title 'Murnaghan fit', "etot.dat" using 1:2 title 'calc.' pt 7
pause -1
#save "eosfit.gp"
#
