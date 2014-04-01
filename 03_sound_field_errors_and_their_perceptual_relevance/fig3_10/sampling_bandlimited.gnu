#!/usr/bin/gnuplot
# AUTHOR: Hagen Wierstorf
# gnuplot 4.6 patchlevel 0
reset
set macros
set loadpath '../../gnuplot'

set t epslatex size 10cm,2.75cm color colortext
set output 'sampling_bandlimited.tex'

load 'border.cfg'
load 'paired.pal'

unset key
set format '$%g$'

# tics
unset ytics
set xtics ('$-\frac{2\pi}{\Delta x_0}$' -2,\
    '$-\frac{\pi}{\Delta x_0}$' -1,\
    '$\frac{\pi}{\Delta x_0}$' 1,\
    '$\frac{2\pi}{\Delta x_0}$' 2) scale 0
set arrow from -2,-0.1 to -2,0.1 back nohead ls 101
set arrow from -1,-0.1 to -1,0.1 back nohead ls 101
set arrow from  1,-0.1 to  1,0.1 back nohead ls 101
set arrow from  2,-0.1 to  2,0.1 back nohead ls 101
# border
set border 0
set arrow from -4,0 to 4.1,0 back size 0.1,20,60 filled ls 101
set arrow from 0,-0.1 to 0,1.3 back size 0.1,20,60 filled ls 101
# axes label
set label 1 '$|D_\text{ band-limited}|$' at 0,1.6 front center
set label 2 '$m$' at 4.3,0 front center
set style line 5 lt 2 lw 4 lc rgb '#FB9A99'
set arrow from -1.4,1 to  1.4,1 nohead back ls 5
# exponential declining of G
e1(x) = x<=-1.4 ? exp(-(abs(x)-1.4)) : 1/0
e2(x) = x>=1.4 ? exp(-(x-1.4)) : 1/0
set label 3 '$G$' at 1.6,1.2 front center tc ls 5
set xrange [-4:4]
set yrange [0:1.2]

set lmargin 1
set rmargin 1
set tmargin 2
set bmargin 2
plot 'spectrum_bandlimited.txt' i 0 w l ls 2 lw 5, \
     ''             i 1 w l ls 1 lw 5,\
     e1(x) w l ls 5,\
     e2(x) w l ls 5
