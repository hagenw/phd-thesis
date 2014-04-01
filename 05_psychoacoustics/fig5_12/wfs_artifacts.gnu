#!/usr/bin/gnuplot
#
# <+DESCRIPTION+>
#
# AUTHOR: Hagen Wierstorf

reset

# wxt
set terminal epslatex size 15cm,8cm color colortext
set output 'wfs_artifacts.tex'
set format '$%g$'

unset key 

load 'border.cfg'
load 'grid.cfg'
set grid xtics ytics mxtics
load 'paired.pal'


#set xrange [100:20000]
#set yrange [-10:15]

set multiplot
set size 0.5,0.5
# 1
set origin 0.25,0.5
set lmargin 3
set rmargin 3
load 'xyborder.cfg'
set logscale x
set xrange [100:20000]
set ytics 20
set xlabel 'frequency / Hz'
set ylabel 'magnitude / dB'
plot 'wfs_point_source_spectrum.txt' u 1:2 w l ls 2 lw 3
# 2
set lmargin 2
set rmargin 3
set origin 0,0
set arrow 1 from 35,1.2 to 50,2 ls 101 lw 3
set label 1 '\href{}{\color{link}\ft listen}' at 2,0.75 left front
set label 2 '\ft WFS point source' at 65,0.75 center front
load 'xyborder.cfg'
unset logscale x
set xrange [0:90]
set ytics 0.5
set xlabel 'time / ms'
set ylabel 'magnitude'
set ylabel offset 1,0
plot 'wfs_point_source.txt' u ($0/44.1):1 w l ls 2 lw 3
# 3
set lmargin 3
set rmargin 2
set origin 0.5,0
set arrow 1 from 55,1.2 to 40,2 ls 101 lw 3
set label 1 '\href{}{\color{link}\ft listen}' at 88,0.75 right front 
set label 2 '\ft WFS point source' at 25,0.88 center front
set label 3 '\ft time reversed' at 25,0.62 center front
load 'xborder.cfg'
plot 'wfs_point_source_time_reversed.txt' u ($0/44.1):1 w l ls 2 lw 3
unset multiplot
