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

set terminal epslatex size 10cm,6.5cm color colortext
set output 'wfs_model.tex'

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
set multiplot layout 1,2

# --- 1 data ---
arrow_size = 2.8
set xrange [-2:2]
set yrange [-2.1:3.1]
# WFS plane wave, box shape, 40 secondary sources
set arrow 21 from 1.244,2.1 to 1.6,2.1 heads size 0.05,90,0 front ls 101 # mark distance between adjacent loudspeakers
set label 21 '\tiny $0.36$\,m' at 1.422,2.3 front center tc ls 101
plot 'wfs_box_nls40.txt'                @localization_arrow,\
     'array_box_nls40.txt'              @array_inactive w p,\
     'array_box_nls40_wfs.txt'          @array_active w p,\
     set_plane_wave(0,2.8)            @plane_wave

# --- 2 data ---
arrow_size = 3
set xrange [-2.2:2.2]
set yrange [-3.7:1.6]
# WFS point source, concave shaped, 50 secondary sources
set arrow 21 from -0.155,0.65 to 0.155,0.65
set label 21 '\tiny $0.31$\,m' at 0,0.85
set label '\ft \ac{WFS}' at 2.1,-3.85 right front tc ls 101
plot 'wfs_concave_nls10.txt'            @localization_arrow,\
     'concave_array.txt'                @array_inactive w p,\
     'concave_array_selected.txt'       @array_active w p,\
     set_point_source(0,1.5)            @point_source

unset multiplot
