#!/usr/bin/gnuplot
#
# FIGURE 5.12: Impulse response and amplitude spectrum of a point source
# synthesized by WFS (2.64). Beside the impulse response its time reversed
# version is shown. Both impulse responses were convolved with a speech signal
# which can be downloaded via the listen links. Parameters: x_s = (0, 1, 0) m,
# x_ref = (4, -4, 0) m, linear secondary source distribution with a length of 20
# m and 34 sources.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'border.cfg'
load 'grid.cfg'
set grid xtics ytics mxtics
load 'paired.pal'

set terminal epslatex size 16cm,8cm color colortext @small
set output 'fig5_12.tex'

unset key 

#set xrange [100:20000]
#set yrange [-10:15]

set multiplot
set size 0.469,0.5
# 1
set origin 0.308,0.5
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
set origin 0.073,0
set arrow 1 from 35,1.2 to 50,2 ls 101 lw 3
set label 1 '\href{\GITHUB/fig5_12/data/wfs_point_source.wav}{\color{link}\ft listen}' at 2,0.75 left front
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
set origin 0.543,0
set arrow 1 from 55,1.2 to 40,2 ls 101 lw 3
set label 1 '\href{\GITHUB/fig5_12/data/wfs_point_source_time_reversed.wav}{\color{link}\ft listen}' at 88,0.75 right front 
set label 2 '\ft WFS point source' at 25,0.88 center front
set label 3 '\ft time reversed' at 25,0.62 center front
load 'xborder.cfg'
plot 'wfs_point_source_time_reversed.txt' u ($0/44.1):1 w l ls 2 lw 3
unset multiplot

call 'plot.plt' 'fig5_12'
