#!/usr/bin/gnuplot
#
# FIGURE 3.6: Sound pressure of a focused source synthesized with 2.5D WFS
# (2.74). Three different linear secondary source distributions were applied,
# ranging from 10 m to 0.75 m. In white the size of the focal point as given by
# ∆s, linear is indicated. Parameters: x_s = (0, -1, 0) m, x_ref = (0, -2, 0) m,
# f = 2000 Hz.
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

set terminal epslatex size 15cm,4.5cm color colortext @small
set output 'fig3_06.tex';

unset key
set size ratio -1

set xrange [-1.75:1.75]
set yrange [-3.00:0.25]
set cbrange [-1:1]
set tics scale 0.75 out nomirror
set xtics 1 offset 0,0.5
set ytics 1 offset 0.5,0
set xlabel '$x$ / m' offset 0,1
set ylabel '$y$ / m' offset 1.5,0
unset colorbox

set bmargin 3
set tmargin 0

set multiplot layout 1,3
set lmargin 4
set rmargin 0
set label 1 '\ft $10$\,m' at 1.7,-2.8 right front
set label 2 '$\Delta_\text{s}$' at 1,-1 center front
set arrow 1 from -0.086,-1 to 0.086,-1 nohead front lw 6 lc rgb 'white'
plot 'focal_point_10m.dat' binary matrix with image,\
     'array_10m.txt' @array_active w l
set border 1
set format y ''
set ytics scale 0
unset ylabel
set lmargin 2
set rmargin 2
set label 1 '\ft $1.8$\,m'
set arrow 1 from -0.096,-1 to 0.096,-1
plot 'focal_point_1.8m.dat' binary matrix with image,\
    'array_1.8m.txt' @array_active w l
set lmargin 0
set rmargin 4
set label 1 '\ft $0.75$\,m'
set arrow 1 from -0.236,-1 to 0.236,-1
plot 'focal_point_0.75m.dat' binary matrix with image,\
    'array_0.75m.txt' @array_active w l
unset multiplot

call 'plot.plt' 'fig3_06'
