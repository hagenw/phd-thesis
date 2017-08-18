#!/usr/bin/gnuplot
#
# FIGURE 6.8: Model prediction of the sweet-spot sizes for different SFS setups
# synthesizing a point source. As a comparison a stereophony setup presents the
# same source. The sweet-spot is defined as all points where the absolute
# localization error is less or equal to 5 deg.
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

set terminal epslatex size 15.3cm,12cm color colortext @small
set output 'fig6_08.tex'

unset key
set size ratio -1

set xrange [-2.1:2.1]
set yrange [-2.1:2.6]

set tmargin 0
set bmargin 0
set lmargin 0
set rmargin 0

unset colorbox

set cbrange [0:1]
set palette defined (0 '#ffffff',1 '#a6cfe4')
#set palette negative
sweetspot(x) = x>5 ? 0 : 1

# === start plotting =====================================================
set multiplot
set size 0.217,0.33

# --- 1 ---
# Stereo 
set origin 0.11,0.65
set yrange [-1.5:2.6]
set label 1 '\ft stereophony' at graph 0, graph 0.7 right front
set arrow 21 from 1.4434,2.7 to -1.4434,2.7 heads size 0.05,90,0 front ls 101 # mark distance between adjacent loudspeakers
set label 21 '\tiny $2.89$\,m' at 0,2.9 front center tc ls 101
plot 'stereo.dat'                       u 1:2:(sweetspot($3)) binary matrix w image,\
     'array_nls2_stereo.txt'            @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 2 ---
# WFS point source, 56 secondary sources
set origin 0.1,0.32
set yrange [-2.1:2.6]
set label 1 '\ft \acs{WFS}'
set arrow 21 from 1.210,1.194 to 1.322,1.069 heads size 0.05,90,0 front ls 101
set label 21 '\tiny $0.17$\,m' at 1.452,1.298 rotate by -48.21 front center tc ls 101
plot 'wfs_circular_nls56.dat'           u 1:2:(sweetspot($3)) binary matrix w image,\
     'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_ps.txt'  @array_active w p,\
     set_point_source(0,2.5)            @point_source 

# --- 3 ---
# WFS point source, 28 secondary sources
set origin 0.3175,0.32
set label 1 ''
set arrow 21 from 1.077,1.314 to 1.314,1.077
set label 21 '\tiny $0.34$\,m' at 1.372,1.372 rotate by -45
plot 'wfs_circular_nls28.dat'           u 1:2:(sweetspot($3)) binary matrix w image,\
     'array_nls28_circular.txt'         @array_inactive w p,\
     'array_nls28_circular_wfs_ps.txt'  @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 4 ---
# WFS point source, 14 secondary sources
set origin 0.535,0.32
set arrow 21 from 0.421,1.643 to 1.022,1.353
set label 21 '\tiny $0.67$\,m' at 0.823,1.723 rotate by -25.71
plot 'wfs_circular_nls14.dat'           u 1:2:(sweetspot($3)) binary matrix w image,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_ps.txt'  @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 5 ---
# NFC-HOA point source, 56 secondary sources
set origin 0.1,0
unset arrow 21
unset label 21
set label 1 '\ft \acs{NFC-HOA}'
set label 13 '\scs $M = 28$' at 1.2,1.5 left front tc ls 101
plot 'nfchoa_band-limited_nls56.dat'    u 1:2:(sweetspot($3)) binary matrix w image,\
     'array_nls56_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 10 ---
# NFC-HOA point source, 28 secondary sources
set origin 0.3175,0
set label 1 ''
set label 13 '\scs $M=14$'
plot 'nfchoa_band-limited_nls28.dat'    u 1:2:(sweetspot($3)) binary matrix w image,\
     'array_nls28_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 11 ---
# NFC-HOA point source, 14 secondary sources
set origin 0.535,0
set label 13 '\scs $M=7$'
plot 'nfchoa_band-limited_nls14.dat'    u 1:2:(sweetspot($3)) binary matrix w image,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 12 ---
# NFC-HOA point source, 14 secondary sources, order 28
set origin 0.7525,0
set label 13 '\scs $M=28$'
plot 'nfchoa_order28_nls14.dat'         u 1:2:(sweetspot($3)) binary matrix w image,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

unset multiplot

call 'plot.plt' 'fig6_08'

# vim: set textwidth=200:
