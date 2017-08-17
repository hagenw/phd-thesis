#!/usr/bin/gnuplot
#
# Figure 5.2: Setup for Experiment 2. The position of the synthesized source is
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

set terminal epslatex size 5cm,7.5cm color colortext @footnotesize
set output 'fig5_02.tex'

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

set xrange [-1.55:1.55]

# === start plotting =====================================================
set multiplot layout 3,3

# --- 1 ---
set yrange [-2.1:2.6]
# WFS point source, 56 secondary sources
plot 'array_nls56_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_point_source(0,2.5)            @point_source 

# --- 2 ---
# WFS point source, 28 secondary sources
plot 'array_nls28_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_point_source(0,2.5)            @point_source

# --- 3 ---
# WFS point source, 14 secondary sources
plot 'array_nls14_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_point_source(0,2.5)            @point_source

# --- 4 ---
# WFS plane wave, 56 secondary sources
plot 'array_nls56_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_plane_wave(0,2.5)              @plane_wave

# --- 5 ---
# WFS plane wave, 28 secondary sources
plot 'array_nls28_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_plane_wave(0,2.5)              @plane_wave

# --- 6 ---
# WFS plane wave, 14 secondary sources
set arrow from 0.75,-2.7 to 1.75,-2.7 nohead front ls 101 lw 4
set label '\tiny $1$\,m' at 1.25,-2.3 center front tc ls 101
plot 'array_nls14_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_plane_wave(0,2.5)              @plane_wave

# --- 7 ---
# WFS focused source, 56 secondary sources
unset arrow
unset label
plot 'array_nls56_circular.txt'         @array_active ps 0.5 w p,\
     set_focused_source(0,0.5)          @focused_source,\
     'listener_positions.txt'           w p ls 1

# --- 8 ---
# WFS focused source, 28 secondary sources
plot 'array_nls28_circular.txt'         @array_active ps 0.5 w p,\
     set_focused_source(0,0.5)          @focused_source,\
     'listener_positions.txt'           w p ls 1

# --- 9 ---
# WFS focused source, 14 secondary sources
plot 'array_nls14_circular.txt'         @array_active ps 0.5 w p,\
     set_focused_source(0,0.5)          @focused_source,\
     'listener_positions.txt'           w p ls 1

unset multiplot

call 'plot.plt' 'fig5_02'
