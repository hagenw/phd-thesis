#!/usr/bin/gnuplot
#
# Plot the setup for the WFS linear loudspeaker array localization experiment
#
# AUTHOR: Hagen Wierstorf

reset
set macros
set loadpath '../../gnuplot'

set terminal epslatex size 5cm,7.5cm color colortext
set output 'fs_exp2_setup.tex'

load 'localization.cfg'
load 'array.cfg'
load 'noborder.cfg'

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
set multiplot layout 3,2

# --- 1 ---
set xrange [-5.1:5.1]
set yrange [-6:0.2]
# WFS focused source, 67 secondary sources
plot 'array_nls67_linear.txt'           @array_active ps 0.5 w p,\
     'listener_positions.txt'           i 1 w p ls 1, \
     set_focused_source(0,-1)           @focused_source

# --- 2 ---
# WFS focused source, 27 secondary sources
plot 'array_nls27_linear.txt'           @array_active ps 0.5 w p,\
     'listener_positions.txt'           i 0 w p ls 1, \
     set_focused_source(0,-1)           @focused_source

# --- 3 ---
# WFS focused source, 13 secondary sources
plot 'array_nls13_linear.txt'           @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_focused_source(0,-1)           @focused_source

# --- 4 ---
# WFS focused source, 6 secondary sources 
plot 'array_nls6_linear.txt'            @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_focused_source(0,-1)           @focused_source

# --- 5 ---
# WFS focused source, 3 secondary sources 
plot 'array_nls3_linear.txt'            @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_focused_source(0,-1)           @focused_source

# --- 6 ---
set arrow from -3,0.7 to -2,0.7 nohead front ls 101 lw 4
set label '\tiny $1$\,m' at -2.5,1.4 center front tc ls 101
plot 1/0

unset multiplot
