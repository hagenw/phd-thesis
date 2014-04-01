#!/usr/bin/gnuplot
#
# Results of a localization test for real and simulated loudspeakers
#
# AUTHOR: Hagen Wierstorf

reset
set macros
set loadpath '../../gnuplot'

set terminal epslatex size 10cm,6cm color colortext
set output 'binaural_synthesis_localization.tex'

load 'border.cfg'
load 'grid.cfg'
set grid mytics ytics xtics
load 'paired.pal'

unset key

#set xrange [-0.125:1.825]
set yrange [-7.4:7.4]
set xtics 15 offset 0,0.3
set ytics 6 offset 0.5,0
set mytics 3
set arrow 1 from -45,0 to 45,0 nohead ls 101
set ylabel ' ' offset 1,0

set datafile separator ','

set multiplot
set size 1,0.45
load 'yborder.cfg'
set format y '$%g\degree$'
set tmargin 2
set bmargin 0
set label 1 '\ft loudspeaker' at 43,4.1 right front
set origin 0,0.5
plot 'mean_signed.csv' u 1:6:7 w yerrorbars ls 2 lw 1 pt 7 ps 1.3
unset title
load 'xyborder.cfg'
set bmargin 2
set tmargin 0
set format '$%g\degree$'
set xlabel '$\phi_\text{sound event}$' offset 0,0.7
set ylabel '$\phi_\text{auditory event}-\phi_\text{sound event}$' offset 1,2.6
set label 1 '\ft binaural synthesis'
set origin 0,0
plot 'mean_signed.csv' u 1:4:5 w yerrorbars ls 2 lw 1 pt 9 ps 1.5
unset multiplot
