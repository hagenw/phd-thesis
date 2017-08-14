#!/usr/bin/gnuplot
#
# FIGURE 2.2: Sound pressure of a point source synthesized with WFS (2.62). The
# secondary source distribution is shown in black, whereby inactive sources are
# marked with a dashed line. Parameters: x_s = (0, 2.5, 0) m,
# x_ref = (0, -3, 0) m, f = 700 Hz.
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

set terminal epslatex size 8cm,5cm color colortext @small
set output 'fig2_02.tex'

unset key
set size ratio -1

set xrange [-9:9]
set yrange [-10:2]
set cbrange [-1:1]
set tics scale 0.75 out nomirror
set xtics 2 offset 0,0.5
set ytics 2 offset 0.5,0
set xlabel '$x$ / m' offset 0,1
set ylabel '$y$ / m' offset 1.5,0
unset colorbox

set bmargin 2.1
set tmargin 0.4
set lmargin 4
set rmargin 1

plot 'concave_array.dat' binary matrix with image,\
    '<export LC_ALL=C && sort -g data/concave_array.txt' @array_inactive w l,\
    'concave_array_selected.txt' @array_active w l

call 'plot.plt' 'fig2_02'
