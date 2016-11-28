set terminal png size 800,600
set output "plot.png"
set style fill solid border rgb 'black'
MU=`head -1 mu-sigma-max`
SIGMA=`tail -2 mu-sigma-max | head -1`
MAX=`tail -1 mu-sigma-max`
set arrow from (MU-SIGMA),0 to (MU-SIGMA),MAX nohead lc rgb 'red'
set arrow from (MU+SIGMA),0 to (MU+SIGMA),MAX nohead lc rgb 'red'
plot 'boxes' with boxes notitle, \
     'data' using 1:(0) lc rgb 'red', \
     exp(-((x-MU)/SIGMA)**2)*MAX
