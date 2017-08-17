#!/usr/bin/gnuplot
#
# FIGURE 4.4: Difference between the direction of the auditory event and the
# sound event for loudspeakers and the binaural simulation of the loudspeakers.
# Average over all listeners together with the 95% confidence interval is
# shown.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'border.cfg'
load 'grid.cfg'
set grid mytics ytics xtics
load 'paired.pal'

set terminal epslatex size 10cm,5.5cm color colortext @small
set output 'fig4_04.tex'

unset key

set yrange [-7.4:7.4]
set xtics 15 offset 0,0.3
set ytics 6 offset 0.5,0
set mytics 3
set arrow 1 from -45,0 to 45,0 nohead ls 101
set ylabel ' ' offset 1,0

set datafile separator ','

set bmargin 2.9
set tmargin 0
set multiplot
set size 1,0.553
set origin 0,0.406
load 'yborder.cfg'
set format y '$%g\degree$'
set label 1 '\ft loudspeaker' at 43,4.1 right front
plot 'mean_signed.csv' u 1:6:7 w yerrorbars ls 2 lw 1 pt 7 ps 1.3
set origin 0,0
unset title
load 'xyborder.cfg'
set format '$%g\degree$'
set xlabel '$\phi_\text{sound event}$' offset 0,0.7
set ylabel '$\phi_\text{auditory event}-\phi_\text{sound event}$' offset 1,2.6
set label 1 '\ft binaural synthesis'
plot 'mean_signed.csv' u 1:4:5 w yerrorbars ls 2 lw 1 pt 9 ps 1.5
unset multiplot

call 'plot.plt' 'fig4_04'
