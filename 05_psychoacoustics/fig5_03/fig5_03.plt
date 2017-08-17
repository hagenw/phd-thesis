#!/usr/bin/gnuplot
#
# Figure 5.3: Setup for Experiment 3. The position of the synthesized source is
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

set terminal epslatex size 5cm,10cm color colortext @footnotesize
set output 'fig5_03.tex'

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
set multiplot layout 4,3

# --- 1 ---
set yrange [-2.1:2.6]
# NFC-HOA point source, 56 secondary sources
plot 'array_nls56_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_point_source(0,2.5)            @point_source 

# --- 2 ---
# NFC-HOA point source, 28 secondary sources
plot 'array_nls28_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_point_source(0,2.5)            @point_source

# --- 3 ---
# NFC-HOA point source, 14 secondary sources
plot 'array_nls14_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_point_source(0,2.5)            @point_source

# --- 4 ---
plot 1/0

# --- 5 ---
plot 1/0

# --- 6 ---
# NFC-HOA point source, 14 secondary sources
plot 'array_nls14_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_point_source(0,2.5)            @point_source

# --- 7 ---
# NFC-HOA plane wave, 56 secondary sources
plot 'array_nls56_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_plane_wave(0,2.5)              @plane_wave

# --- 8 ---
# NFC-HOA plane wave, 28 secondary sources
plot 'array_nls28_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_plane_wave(0,2.5)              @plane_wave

# --- 9 ---
# NFC-HOA plane wave, 14 secondary sources
plot 'array_nls14_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_plane_wave(0,2.5)              @plane_wave

# --- 10 ---
plot 1/0

# --- 11 ---
set arrow from -2.05,2.7 to -1.05,2.7 nohead front ls 101 lw 4
set label '\tiny $1$\,m' at -1.525,3.1 center front tc ls 101
plot 1/0

# --- 12 ---
# NFC-HOA plane wave, 14 secondary sources
unset arrow
unset label
plot 'array_nls14_circular.txt'         @array_active ps 0.5 w p,\
     'listener_positions.txt'           w p ls 1, \
     set_plane_wave(0,2.5)              @plane_wave

unset multiplot

call 'plot.plt' 'fig5_03'
