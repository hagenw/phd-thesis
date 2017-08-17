#!/usr/bin/gnuplot
#
# FIGURE 5.13: Setup for Experiment 1. The position of the synthesized focused
# source is indicated by the grey point. The position of the listener by black
# crosses and secondary sources by black dots.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'localization.cfg'
load 'array.cfg'
load 'noborder.cfg'

set terminal epslatex size 5cm,2.5cm color colortext @footnotesize
set output 'fig5_13.tex'

set style line 1 lc rgb 'black' pt 2 ps 0.75 lw 1

unset key
set size ratio -1

set tmargin 0
set bmargin 0
set lmargin 0.5
set rmargin 0.5

unset tics
unset xlabel
unset ylabel

# === start plotting =====================================================
set multiplot layout 1,2

# --- 1 ---
set xrange [-5.1:5.1]
set yrange [-6:0.2]
# WFS focused source, 67 secondary sources
plot 'array_nls67_linear.txt'           @array_active ps 0.5 w p,\
     'listener_positions2.txt'          w p ls 1, \
     set_focused_source(0,-1)           @focused_source

# --- 2 ---
# WFS focused source, 27 secondary sources
set arrow from 2,-5.7 to 3,-5.7 nohead front ls 101 lw 4
set label '\tiny $1$\,m' at 2.5,-5 center front tc ls 101
plot 'array_nls27_linear.txt'           @array_active ps 0.5 w p,\
     'listener_positions1.txt'          w p ls 1, \
     set_focused_source(0,-1)           @focused_source

unset multiplot

call 'plot.plt' 'fig5_13'
