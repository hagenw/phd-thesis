#!/usr/bin/gnuplot
#
# Figure 3.3: Sound pressure in decibel of a plane wave synthesized with 2.5D
# WFS (2.55). The result of an infinite linear secondary source distribution
# is compared with two truncated ones. Parameters: n_k = (0, -1, 0),
# x_ref = (0, -2, 0) m, f = 3 kHz.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'border.cfg'
load 'moreland.pal'
load 'blues.pal'
load 'array.cfg'

set terminal epslatex size 15.8cm,4.5cm color colortext @small
set output 'fig3_03.tex'

unset key
set size ratio -1

set xrange [-2.1:2.1]
set yrange [-3.5:0.5]
set cbrange [0:60]
set tics scale 0.75 out nomirror
set xtics 1 offset 0,0.5
set ytics 1 offset 0.5,0
set cbtics 10 offset -0.5,0
set cbtics add ('$60$\,dB' 60)
set xlabel '$x$ / m' offset 0,1
set ylabel '$y$ / m' offset 1.5,0
unset colorbox

set bmargin 2.5
set tmargin 0.5

set multiplot #layout 1,3
set size 0.32,1
set origin 0,0
set lmargin 4
set rmargin 0
plot 'sound_field_inf.dat' binary matrix u 1:2:($3+30) with image,\
     'array_inf.txt' @array_active w l
set origin 0.317,0
set lmargin 2
set rmargin 2
set border 1
set format y ''
set ytics scale 0
unset ylabel
#set colorbox
plot 'sound_field_truncated.dat' binary matrix u 1:2:($3+30) with image,\
     'array_truncated.txt' @array_active w l
set origin 0.634,0
set colorbox user vertical origin 0.9235,0.555 size 0.015,0.4 front
set lmargin 0
set rmargin 4
plot 'sound_field_truncated_round.dat' binary matrix u 1:2:($3+30) with image,\
     'array_truncated_round.txt' @array_active w l
unset multiplot

call 'plot.plt' 'fig3_03'
