#!/usr/bin/gnuplot
#
# FIGURE 6.5: Model predictions of the perceived directions for a synthesized
# point source in the audience area. The three different linear secondary
# source distributions were all driven by WFS (2.64).
#
# Explanation of calculated values:
# * the labels printed beside the position rows are the mean absolute
#   localization error, about the corresponding values from the rows. The values
#   were calculated by hand from the result files
# * the label representing the localization blur is the mean standard deviation
#   averaged over all positions and loudspeaker setups; the ones were more than
#   one arrow is printed for one position were excluded from the average
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

set terminal epslatex size 15cm,6.5cm color colortext @small
set output 'fig6_05.tex'

unset key
set size ratio -1

set cbrange [0:40]

set tmargin 0
set bmargin 0
set lmargin 1
set rmargin 1

unset colorbox

arrow_size = 3

# === start plotting =====================================================
set multiplot layout 1,3

# --- 1 data ---
set xrange [-2.1:2.1]
set yrange [-3.3:1.1]
# WFS point source, 15 secondary sources
set arrow 21 from 1.221,0.2 to 1.425,0.2 heads size 0.05,90,0 front ls 101 # mark distance between adjacent loudspeakers
set label 21 '\tiny $0.20$\,m' at 1.323,0.4 front center tc ls 101
plot 'wfs_linear_nls15.txt'             @localization_arrow,\
     'array_nls15_linear.txt'           @array_active w p,\
     set_point_source(0,1)              @point_source

# --- 2 data ---
# WFS point source, 8 secondary sources
set arrow 21 from 1.018,0.2 to 1.425,0.2
set label 21 '\tiny $0.41$\,m' at 1.222,0.4
plot 'wfs_linear_nls8.txt'              @localization_arrow,\
     'array_nls8_linear.txt'            @array_active w p,\
     set_point_source(0,1)              @point_source

# --- 3 data ---
# WFS point source, 3 secondary sources
set label 1 '\ft \acs{WFS}' at 2.1,-3.4 right front tc ls 101
set arrow 21 from 0,0.2 to 1.425,0.2
set label 21 '\tiny $1.43$\,m' at 0.713,0.4
plot 'wfs_linear_nls3.txt'              @localization_arrow,\
     'array_nls3_linear.txt'            @array_active w p,\
     set_point_source(0,1)              @point_source

unset multiplot

call 'plot.plt' 'fig6_05'
