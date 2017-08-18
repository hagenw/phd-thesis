#!/usr/bin/gnuplot
#
# FIGURE 6.3a+b: Average localization results for all four experiments. The
# black symbols indicate loudspeakers, the grey ones the synthesized source. On
# every listening position an arrow is pointing into the direction the listener
# perceived the corresponding auditory event from. The color of the arrow
# displays the absolute localization error, which is also summarized beside the
# arrows for every row of positions. The average confidence interval for the
# localization results is 2.3 deg. Listening conditions that resulted in
# listeners saying that they perceived two sources in Exp. 4 of Section 5.1 are
# highlighted with a small 2 written below the position.
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

set terminal epslatex size 16cm,21cm color colortext @small
set output 'fig6_03b.tex'

set style line 101 lc rgb '#808080' lt 1 lw 1

unset key
set size ratio -1

set cbrange [0:40]

set tmargin 0
set bmargin 0
set lmargin 0
set rmargin 0

unset colorbox
unset tics
unset xlabel
unset ylabel
set border 0

# === start plotting =====================================================
set multiplot
set size 0.208,0.167

# --- 1 data ---
set origin 0.15,0.83
set xrange [-2.1:2.1]
set yrange [-2.1:2.6]
# WFS point source, 15 secondary sources
set label 1 '\ft \acs{WFS}' at graph 0, graph 0.7 right front
set label 41 '\ft experiment' at graph 0, graph 0.5 right front 
set label 31 '\ft localization blur:' at graph 0, graph 0.32 right front
set label 32 '\ft $3.30\degree \pm 1.0\degree$' at graph 0, graph 0.22 right front
set label 10 '\ft $2.3\degree$' at 0.15, 0.75 left front
set label 11 '\ft $0.6\degree$' at 0.15, 0.00 left front
set label 12 '\ft $0.7\degree$' at 0.15,-0.75 left front
plot 'wfs_nls56_circular_pw.txt'        @localization_arrow,\
     'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_pw.txt'  @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 11 data ---
# WFS plane wave, 28 secondary sources
set origin 0.358,0.83
set label 1 ''
set label 41 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $4.4\degree$'
set label 11 '\ft $1.9\degree$'
set label 12 '\ft $1.3\degree$'
plot 'wfs_nls28_circular_pw.txt'        @localization_arrow,\
     'array_nls28_circular.txt'         @array_inactive w p,\
     'array_nls28_circular_wfs_pw.txt'  @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 12 data ---
# WFS plane wave, 14 secondary sources
set origin 0.566,0.83
set label 10 '\ft $5.8\degree$'
set label 11 '\ft $4.9\degree$'
set label 12 '\ft $2.1\degree$'
plot 'wfs_nls14_circular_pw.txt'        @localization_arrow,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_pw.txt'  @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 10 model ---
# WFS plane wave, 56 secondary sources
set origin 0.15,0.663
set label 1 '\ft \acs{WFS}'
set label 41 '\ft binaural model'
set label 31 '\ft localization blur:'
set label 32 '\ft $3.93\degree \pm 0.3\degree$'
set label 10 '\ft $1.0\degree$'
set label 11 '\ft $1.4\degree$'
set label 12 '\ft $1.6\degree$'
plot 'wfs_nls56_circular_pw_model.txt'  @localization_arrow,\
     'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_pw.txt'  @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 11 model ---
# WFS plane wave, 28 secondary sources
set origin 0.358,0.663
set label 1 ''
set label 41 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $3.0\degree$'
set label 11 '\ft $2.2\degree$'
set label 12 '\ft $1.7\degree$'
plot 'wfs_nls28_circular_pw_model.txt'  @localization_arrow,\
     'array_nls28_circular.txt'         @array_inactive w p,\
     'array_nls28_circular_wfs_pw.txt'  @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 12 model ---
# WFS plane wave, 14 secondary sources
set origin 0.566,0.663
set label 10 '\ft $7.5\degree$'
set label 11 '\ft $2.5\degree$'
set label 12 '\ft $1.6\degree$'
plot 'wfs_nls14_circular_pw_model.txt'  @localization_arrow,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_pw.txt'  @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 13 data ---
# NFC-HOA plane wave, 56 secondary sources
set origin 0.15,0.496
set label 1 '\ft \acs{NFC-HOA}'
set label 41 '\ft experiment'
set label 31 '\ft localization blur:'
set label 32 '\ft $4.75\degree \pm 0.8\degree$'
set label 2 '\tiny $2$' at -1.00,0.52 center front
set label 10 '\ft $6.5\degree$'
set label 11 '\ft $4.0\degree$'
set label 12 '\ft $4.9\degree$'
plot 'hoa_nls56_order28_pw.txt'         @localization_arrow,\
     'array_nls56_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave
unset label 2

# --- 14 data ---
# NFC-HOA plane wave, 28 secondary sources
set origin 0.358,0.496
set label 1 ''
set label 41 ''
set label 31 ''
set label 32 ''
set label 2 '\tiny $2$' at -1.00,0.52 center front
set label 3 '\tiny $2$' at -1.25,-0.23 center front
set label 10 '\ft $11.9\degree$'
set label 11 '\ft $9.1\degree$'
set label 12 '\ft $7.3\degree$'
plot 'hoa_nls28_order14_pw.txt'         @localization_arrow,\
     'array_nls28_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave
unset label 2
unset label 3

# --- 15 data ---
# NFC-HOA plane wave, 14 secondary sources
set origin 0.566,0.496
set label 2 '\tiny $2$' at -0.75,0.52 center front
set label 3 '\tiny $2$' at -0.75,-0.23 center front
set label 4 '\tiny $2$' at -1.00,-0.98 center front
set label 5 '\tiny $2$' at -0.75,-0.98 center front
set label 10 '\ft $2.3\degree$'
set label 11 '\ft $16.9\degree$'
set label 12 '\ft $12.8\degree$'
plot 'hoa_nls14_order7_pw.txt'          @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave
unset label 2
unset label 3
unset label 4
unset label 5

# --- 13 model ---
# NFC-HOA plane wave, 56 secondary sources
set origin 0.15,0.329
set label 1 '\ft \acs{NFC-HOA}'
set label 41 '\ft binaural model'
set label 31 '\ft localization blur:'
set label 32 '\ft $4.45\degree \pm 0.3\degree$'
set label 10 '\ft $2.1\degree$'
set label 11 '\ft $2.2\degree$'
set label 12 '\ft $1.5\degree$'
plot 'hoa_nls56_order28_pw_model.txt'   @localization_arrow,\
     'array_nls56_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 14 model ---
# NFC-HOA plane wave, 28 secondary sources
set origin 0.358,0.329
set label 1 ''
set label 41 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $3.3\degree$'
set label 11 '\ft $3.9\degree$'
set label 12 '\ft $2.5\degree$'
plot 'hoa_nls28_order14_pw_model.txt'   @localization_arrow,\
     'array_nls28_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 15 model ---
# NFC-HOA plane wave, 14 secondary sources
set origin 0.566,0.329
set label 10 '\ft $6.5\degree$'
set label 11 '\ft $10.2\degree$'
set label 12 '\ft $14.1\degree$'
plot 'hoa_nls14_order7_pw_model.txt'    @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave
unset label 2
unset label 3
unset label 4
unset label 5

# --- 16 data ---
# WFS focused source, 56 secondary sources
set origin 0.15,0.162
set label 1 '\ft \acs{WFS}'
set label 41 '\ft experiment'
set label 31 '\ft localization blur:'
set label 32 '\ft $4.77\degree \pm 0.6\degree$'
set label 10 '\ft $163.8\degree$'
set label 11 '\ft $19.0\degree$'
set label 12 '\ft $5.3\degree$'
plot 'wfs_nls56_circular_fs.txt'        @localization_arrow,\
     'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_fs.txt'  @array_active w p,\
     set_focused_source(0,0.5)          @focused_source

# --- 17 data ---
# WFS focused source, 28 secondary sources
set origin 0.358,0.162
set label 1 ''
set label 41 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $166.5\degree$'
set label 11 '\ft $39.3\degree$'
set label 12 '\ft $16.5\degree$'
plot 'wfs_nls28_circular_fs.txt'        @localization_arrow,\
     'array_nls28_circular.txt'         @array_inactive w p,\
     'array_nls28_circular_wfs_fs.txt'  @array_active w p,\
     set_focused_source(0,0.5)          @focused_source

# --- 18 data ---
# WFS focused source, 14 secondary sources
set origin 0.566,0.162
set label 10 '\ft $168.6\degree$'
set label 11 '\ft $50.3\degree$'
set label 12 '\ft $24.9\degree$'
plot 'wfs_nls14_circular_fs.txt'        @localization_arrow,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_fs.txt'  @array_active w p,\
     set_focused_source(0,0.5)          @focused_source

# --- 16 model ---
# WFS focused source, 56 secondary sources
set origin 0.15,-0.005
set label 1 '\ft \acs{WFS}'
set label 41 '\ft binaural model'
set label 31 '\ft localization blur:'
set label 32 '\ft $8.21\degree \pm 0.6\degree$'
set label 10 '\ft $172.1\degree$'
set label 11 '\ft $3.0\degree$'
set label 12 '\ft $1.1\degree$'
plot 'wfs_nls56_circular_fs_model.txt'  @localization_arrow,\
     'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_fs.txt'  @array_active w p,\
     set_focused_source(0,0.5)          @focused_source

# --- 17 model ---
# WFS focused source, 28 secondary sources
set origin 0.358,-0.005
set label 1 ''
set label 41 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $172.1\degree$'
set label 11 '\ft $23.5\degree$'
set label 12 '\ft $1.0\degree$'
plot 'wfs_nls28_circular_fs_model.txt'  @localization_arrow,\
     'array_nls28_circular.txt'         @array_inactive w p,\
     'array_nls28_circular_wfs_fs.txt'  @array_active w p,\
     set_focused_source(0,0.5)          @focused_source

# --- 18 model ---
# WFS focused source, 14 secondary sources
set origin 0.566,-0.005
set label 10 '\ft $172.8\degree$'
set label 11 '\ft $42.4\degree$'
set label 12 '\ft $20.3\degree$'
plot 'wfs_nls14_circular_fs_model.txt'  @localization_arrow,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_fs.txt'  @array_active w p,\
     set_focused_source(0,0.5)          @focused_source

# --- 15.1 data ---
# NFC-HOA plane wave, 14 secondary sources, order 28
set origin 0.775,0.496
set label 10 '\ft $8.2\degree$'
set label 11 '\ft $3.6\degree$'
set label 12 '\ft $3.0\degree$'
plot 'hoa_nls14_order28_pw.txt'         @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 15.1 model ---
# NFC-HOA plane wave, 14 secondary sources, order 28
set origin 0.775,0.329
set label 10 '\ft $7.7\degree$'
set label 11 '\ft $7.9\degree$'
set label 12 '\ft $3.4\degree$'
plot 'hoa_nls14_order28_pw_model.txt'   @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

unset multiplot

call 'plot.plt' 'fig6_03b'

# vim: set textwidth=200:
