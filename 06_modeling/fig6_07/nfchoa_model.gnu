#!/usr/bin/gnuplot
#
# Plot localization model results for WFS, NFC-HOA and different loudspeaker
# array setups
#
# Explanation of calculated values:
# * the labels printed beside the position rows are the mean absolute
#   localization error, about the corresponding values from the rows. The values
#   were calculated by hand from the result files
# * the label representing the localization blur is the mean standard deviation
#   averaged over all positions and loudspeaker setups; the ones were more than
#   one arrow is printed for one position were excluded from the average
#
# AUTHOR: Hagen Wierstorf

reset
set macros
set loadpath '../../gnuplot'

set terminal epslatex size 15cm,6.5cm color colortext
set output 'nfchoa_model.tex'

load 'localization.cfg'
load 'array.cfg'
load 'noborder.cfg'

unset key
set size ratio -1


set cbrange [0:40]

set tmargin 0
set bmargin 0
set lmargin 1
set rmargin 1

unset colorbox


# === start plotting =====================================================
set multiplot layout 1,3

# --- 1 NFC-HOA ---
arrow_size = 3
set xrange [-2:2]
set yrange [-2:2.6]
set arrow 21 from 1.077,1.314 to 1.314,1.077 heads size 0.05,90,0 front ls 101
set label 21 '\tiny $0.34$\,m' at 1.372,1.372 rotate by -45 front center tc ls 101
plot 'nfchoa_circle_nls28_order14.txt'  @localization_arrow,\
     'array_nfchoa_circle.txt'          @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 2 NFC-HOA wrong angles of secondary sources ---
unset label
unset arrow
arrow_size = 3
set xrange [-2:2]
set yrange [-2:2.6]
plot 'nfchoa_random_circle_nls28_order14.txt' @localization_arrow,\
     'array_nfchoa_random_circle.txt'   @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 3 NFC-HOA wrong angles and positions of secondary sources ---
arrow_size = 3
set xrange [-2:2]
set yrange [-2:2.6]
set label '\ft \ac{NFC-HOA}, $M=14$' at 1.55,-1.9 right front tc ls 101
plot 'nfchoa_jitter_nls28_order14.txt'  @localization_arrow,\
     'array_nfchoa_jitter.txt'          @array_active w p,\
     set_point_source(0,2.5)            @point_source


unset multiplot
