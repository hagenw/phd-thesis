#!/usr/bin/gnuplot
#
# FIGURE 3.9: Sound pressure of a focused source synthesized by WFS (2.74) for
# different frequencies. Parameters: x_s = (0, 0.5, 0), x_ref = (0, 0, 0) m, 64
# secondary sources.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'border.cfg'
load 'moreland.pal'
load 'array.cfg'

set terminal epslatex size 15cm,4.6cm color colortext @small
set output 'fig3_09.tex';

unset key
set size ratio -1

set xrange [-1.75:1.75]
set yrange [-1.75:1.75]
set cbrange [-1:1]
set tics scale 0.75 out nomirror
set xtics 1 offset 0,0.5
set ytics 1 offset 0.5,0
set xlabel '$x$ / m' offset 0,1
set ylabel '$y$ / m' offset 1.5,0
unset colorbox

set bmargin 2.1
set tmargin 0.9

set multiplot layout 1,3
set lmargin 4
set rmargin 0
set label 1 '\ft $f = 1000$\,Hz' at 1.7,1.95 right front
plot 'sound_field_fs_1000Hz.dat' binary matrix with image,\
     'array.txt'     @array_inactive w p,\
     'array_wfs.txt' @array_active w p
set border 1
set format y ''
set ytics scale 0
unset ylabel
set lmargin 2
set rmargin 2
set label 1 '\ft $2000$\,Hz'
plot 'sound_field_fs_2000Hz.dat' binary matrix with image,\
     'array.txt'     @array_inactive w p,\
     'array_wfs.txt' @array_active w p
set lmargin 0
set rmargin 4
set label 1 '\ft $5000$\,Hz'
plot 'sound_field_fs_5000Hz.dat' binary matrix with image,\
     'array.txt'     @array_inactive w p,\
     'array_wfs.txt' @array_active w p
unset multiplot

call 'plot.plt' 'fig3_09'
