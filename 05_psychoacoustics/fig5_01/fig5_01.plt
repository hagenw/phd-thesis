#!/usr/bin/gnuplot
#
# FIGURE 5.1: Setup for Experiment 1. The position of the synthesized source is
# indicated by the grey point. The position of the listener by black crosses
# and secondary sources by black dots.
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
set output 'fig5_01.tex'

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
set multiplot layout 1,3

# --- 1 ---
set xrange [-2.1:2.1]
set yrange [-2.3:1.1]
# WFS point source, 15 secondary sources
plot 'array_nls15_linear.txt'           @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_point_source(0,1)              @point_source

# --- 2 ---
# WFS point source, 8 secondary sources
plot 'array_nls8_linear.txt'            @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_point_source(0,1)              @point_source

# --- 3 ---
# WFS point source, 3 secondary sources
set arrow from 1,-2.7 to 2,-2.7 nohead front ls 101 lw 4
set label '\tiny $1$\,m' at 1.5,-2.2 center front tc ls 101
plot 'array_nls3_linear.txt'            @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_point_source(0,1)              @point_source

unset multiplot

call 'plot.plt' 'fig5_01'
