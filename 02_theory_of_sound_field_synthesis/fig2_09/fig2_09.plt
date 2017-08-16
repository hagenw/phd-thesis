#!/usr/bin/gnuplot
#
# FIGURE 2.9: Sound pressure for a monochromatic plane wave synthesized by 2.5D
# WFS (2.55). Parameters: n_k = (0, -1, 0), x_ref = (0, 0, 0), f = 1 kHz.
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

set terminal epslatex size 5cm,5cm color colortext @footnotesize
set output 'fig2_09.tex'

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

set bmargin 1

plot 'sound_field_wfs_pw_f1000Hz_nls1000.dat' binary matrix with image,\
    'array.txt'        @array_inactive w l,\
    'array_wfs_pw.txt' @array_active w l

call 'plot.plt' 'fig2_09'
