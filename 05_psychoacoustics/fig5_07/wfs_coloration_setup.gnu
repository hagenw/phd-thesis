#!/usr/bin/gnuplot
#
# Plot setup for the circular loudspeaker array and WFS coloration experiment
#
# AUTHOR: Hagen Wierstorf

reset
set macros
set loadpath '../../gnuplot'

set terminal epslatex size 5cm,5.5cm color colortext
set output 'wfs_coloration_setup.tex'

load 'localization.cfg'
load 'array.cfg'
load 'noborder.cfg'

set style line 1 lc rgb 'black' pt 2 ps 0.75 lw 1

unset key
set size ratio -1

set tmargin 0
set bmargin 0

unset tics
unset xlabel
unset ylabel

set xrange [-1.55:1.55]
set yrange [-2.1:2.6]

# === start plotting =====================================================
set multiplot layout 2,2

# --- 1 ---
set lmargin 0.5
set rmargin 3
# WFS point source, 14 secondary sources
plot 'array_nls14.txt'                  @array_active ps 0.5 w p,\
     'listener_positions1.txt'          w p ls 1, \
     set_point_source(0,2.5)            @point_source

# --- 2 ---
set lmargin 3
set rmargin 0.5
# WFS point source, 3584 secondary sources
plot 'array.txt'                        @array_active w l,\
     'listener_positions1.txt'          w p ls 1, \
     set_point_source(0,2.5)            @point_source

# --- 3 ---
set lmargin 0.5
set rmargin 3
# WFS point source, 56 secondary sources
plot 'array_nls56.txt'                  @array_active ps 0.5 w p,\
     'listener_positions2.txt'          w p ls 1, \
     set_point_source(0,2.5)            @point_source

# --- 4 ---
set arrow from -2.05,2.7 to -1.05,2.7 nohead front ls 101 lw 4
set label '\tiny $1$\,m' at -1.525,3.1 center front tc ls 101
set label '\ft \ldots' at -1.75,5 center front
plot 1/0

unset multiplot
