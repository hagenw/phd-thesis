#!/usr/bin/gnuplot
#
# FIGURE 2.8: Sound pressure for a monochromatic point source synthesized by
# 2.5D NFC-HOA (2.50). Parameters: x_s = (0, 2.5, 0) m, x_ref = (0, 0, 0),
# f = 1 kHz.
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
set output 'fig2_08.tex'

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

plot 'sound_field_nfchoa_ps_f1000Hz_nls64.dat' binary matrix with image,\
     'array.txt' @array_active w l

call 'plot.plt' 'fig2_08'
