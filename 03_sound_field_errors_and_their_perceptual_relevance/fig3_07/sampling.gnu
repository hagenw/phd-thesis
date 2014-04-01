#!/usr/bin/gnuplot
# AUTHOR: Hagen Wierstorf
# gnuplot 4.6 patchlevel 0
reset
set macros
set loadpath '../../gnuplot'

set t epslatex size 10cm,5.5cm color colortext
set output 'sampling.tex'

load 'border.cfg'
load 'paired.pal'

unset key
set format '$%g$'

# tics
unset ytics
set xtics ('$-f_\text{s}$' -2,\
    '$-f_\text{s}/2$' -1,\
    '$f_\text{s}/2$' 1,\
    '$f_\text{s}$' 2) scale 0
set arrow from -2,-0.1 to -2,0.1 back nohead ls 101
set arrow from -1,-0.1 to -1,0.1 back nohead ls 101
set arrow from  1,-0.1 to  1,0.1 back nohead ls 101
set arrow from  2,-0.1 to  2,0.1 back nohead ls 101
# border
set border 0
set arrow from -4,0 to 4.1,0 back size 0.1,20,60 filled ls 101
set arrow from 0,-0.1 to 0,1.3 back size 0.1,20,60 filled ls 101
# axes label
set label 1 '$|P|$' at 0,1.6 front center
set label 2 '$f$' at 4.3,0 front center
set xrange [-4:4]
set yrange [0:1.2]

set lmargin 1
set rmargin 1
set multiplot layout 2,1
set tmargin 2
set bmargin 2
plot 'spectrum.txt' i 0 w l ls 2 lw 5
set tmargin 2
set bmargin 2
set label 1 '$|P_\text{sampled}|$'
set style line 5 lt 2 lw 4 lc rgb '#FB9A99'
set arrow from -1,0 to -1,1 nohead back ls 5
set arrow from -1,1 to  1,1 nohead back ls 5
set arrow from  1,1 to  1,0 nohead back ls 5
set label 3 '$F_\text{r}$' at 1.2,1.2 front center tc ls 5
plot 'spectrum.txt' i 0 w l ls 2 lw 5, \
     ''             i 1 w l ls 1 lw 5
unset multiplot
