#!/usr/bin/gnuplot
#
# FIGURE 5.4: Average localization results for all four experiments. The black
# symbols indicate loudspeakers, the grey ones the synthesized source. At every
# listening position, an arrow is pointing into the direction from which the
# listeners perceived the corresponding auditory event. The color of the arrow
# displays the absolute localization error, which is also summarized as an
# average beside the arrows for every row of positions. The average confidence
# interval for all localization results is 2.3 deg.  Listening conditions which
# resulted in listeners saying that they perceived two sources in Exp. 4 are
# highlighted with a small 2 written below the position.
#
# Explanation of calculated values:
# * the labels printed beside the position rows are the mean absolute
#   localization error, about the corresponding values from the rows. The values
#   were calculated by hand from the result files
# * the label representing the mean standard deviation is calculated about all
#   positions. For positions were more than one normal distribution was found
#   (the ones were more than one arrow is printed for one position) were
#   excluded from the average
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
set output 'fig5_04.tex'

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

# --- 1 ---
# WFS point source, 15 secondary sources
set origin 0.15,0.83
set xrange [-2.1:2.1]
set yrange [-2.3:1.1]
set label 1 '\ft \acs{WFS}' at graph 0, graph 0.5 right front
set label 31 '\ft localization blur:' at graph 0, graph 0.32 right front
set label 32 '\ft $2.29\degree \pm 0.3\degree$' at graph 0, graph 0.19 right front
set label 10 '\ft $0.5\degree$' at 0.15,-1.5 left front             # mean localization error for y=-1.5m
set label 11 '\ft $0.6\degree$' at 0.15,-2.0 left front             # mean localization error for y=-2m
set arrow 21 from 1.221,0.2 to 1.425,0.2 heads size 0.05,90,0 front ls 101 # mark distance between adjacent loudspeakers
set label 21 '\tiny $0.20$\,m' at 1.323,0.4 front center tc ls 101
plot 'wfs_nls15_linear_ps.txt'          @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls15_linear.txt'           @array_active w p,\
     set_point_source(0,1)              @point_source

# --- 2 ---
# WFS point source, 8 secondary sources
set origin 0.358,0.83
set label 1 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $1.9\degree$'
set label 11 '\ft $1.5\degree$'
set arrow 21 from 1.018,0.2 to 1.425,0.2
set label 21 '\tiny $0.41$\,m' at 1.222,0.4
plot 'wfs_nls8_linear_ps.txt'           @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls8_linear.txt'            @array_active w p,\
     set_point_source(0,1)              @point_source

# --- 3 ---
# WFS point source, 3 secondary sources
set origin 0.566,0.83
set label 10 '\ft $6.7\degree$'
set label 11 '\ft $5.9\degree$'
set arrow 21 from 0,0.2 to 1.425,0.2
set label 21 '\tiny $1.43$\,m' at 0.713,0.4
plot 'wfs_nls3_linear_ps.txt'           @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls3_linear.txt'            @array_active w p,\
     set_point_source(0,1)              @point_source

# --- 4 ---
# WFS point source, 56 secondary sources
set origin 0.15,0.663
set yrange [-2.1:2.6]
set label 1 '\ft \acs{WFS}'
set label 31 '\ft localization blur:'
set label 32 '\ft $2.76\degree \pm 0.7\degree$' at graph 0, graph 0.22 right front
set label 10 '\ft $0.9\degree$' at 0.15, 0.75 left front
set label 11 '\ft $0.9\degree$' at 0.15, 0.00 left front
set label 12 '\ft $0.6\degree$' at 0.15,-0.75 left front
set arrow 21 from 1.210,1.194 to 1.322,1.069
set label 21 '\tiny $0.17$\,m' at 1.452,1.298 rotate by -48.21
plot 'wfs_nls56_circular_ps.txt'        @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_ps.txt'  @array_active w p,\
     set_point_source(0,2.5)            @point_source 

# --- 5 ---
# WFS point source, 28 secondary sources
set origin 0.358,0.663
set label 1 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $1.7\degree$'
set label 11 '\ft $1.9\degree$'
set label 12 '\ft $1.4\degree$'
set arrow 21 from 1.077,1.314 to 1.314,1.077
set label 21 '\tiny $0.34$\,m' at 1.372,1.372 rotate by -45
plot 'wfs_nls28_circular_ps.txt'        @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls28_circular.txt'         @array_inactive w p,\
     'array_nls28_circular_wfs_ps.txt'  @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 6 ---
# WFS point source, 14 secondary sources
set origin 0.566,0.663
set label 10 '\ft $4.2\degree$'
set label 11 '\ft $1.7\degree$'
set label 12 '\ft $0.4\degree$'
set arrow 21 from 0.421,1.643 to 1.022,1.353
set label 21 '\tiny $0.67$\,m' at 0.823,1.723 rotate by -25.71
plot 'wfs_nls14_circular_ps.txt'        @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_ps.txt'  @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 7 ---
# NFC-HOA point source, 56 secondary sources
set origin 0.15,0.496
unset arrow 21
unset label 21
set label 1 '\ft \acs{NFC-HOA}'
set label 31 '\ft localization blur:'
set label 32 '\ft $3.84\degree \pm 0.8\degree$'
set label 10 '\ft $5.0\degree$'
set label 11 '\ft $1.4\degree$'
set label 12 '\ft $0.7\degree$'
set label 13 '\scs $M = 28$' at 1.2,1.5 left front tc ls 101
plot 'hoa_nls56_order28_ps.txt'         @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls56_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source 

# --- 8 ---
# NFC-HOA point source, 28 secondary sources
set origin 0.358,0.496
set label 1 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $8.1\degree$'
set label 11 '\ft $4.2\degree$'
set label 12 '\ft $1.4\degree$'
set label 13 '\scs $M=14$'
plot 'hoa_nls28_order14_ps.txt'         @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls28_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 9 ---
# NFC-HOA point source, 14 secondary sources
set origin 0.566,0.496
set label 2 '\tiny $2$' at -1.25,-0.23 center front
set label 3 '\tiny $2$' at -1.00,-0.23 center front
set label 4 '\tiny $2$' at -0.75,-0.23 center front
set label 5 '\tiny $2$' at -1.00,-0.98 center front
set label 6 '\tiny $2$' at -0.75,-0.98 center front
set label 10 '\ft $11.7\degree$'
set label 11 '\ft $38.5\degree$'
set label 12 '\ft $20.7\degree$'
set label 13 '\scs $M=7$'
plot 'hoa_nls14_order7_ps.txt'          @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

unset label 2
unset label 3
unset label 4
unset label 5
unset label 6
unset label 13

# --- 10 ---
# WFS plane wave, 56 secondary sources
set origin 0.15,0.329
set label 1 '\ft \acs{WFS}'
set label 31 '\ft localization blur:'
set label 32 '\ft $3.30\degree \pm 1.0\degree$'
set label 10 '\ft $2.3\degree$'
set label 11 '\ft $0.6\degree$'
set label 12 '\ft $0.7\degree$'
plot 'wfs_nls56_circular_pw.txt'        @localization_arrow,\
     'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_pw.txt'  @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 11 ---
# WFS plane wave, 28 secondary sources
set origin 0.358,0.329
set label 1 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $4.4\degree$'
set label 11 '\ft $1.9\degree$'
set label 12 '\ft $1.3\degree$'
plot 'wfs_nls28_circular_pw.txt'        @localization_arrow,\
     'array_nls28_circular.txt'         @array_inactive w p,\
     'array_nls28_circular_wfs_pw.txt'  @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 12 ---
# WFS plane wave, 14 secondary sources
set origin 0.566,0.329
set label 10 '\ft $5.8\degree$'
set label 11 '\ft $4.9\degree$'
set label 12 '\ft $2.1\degree$'
plot 'wfs_nls14_circular_pw.txt'        @localization_arrow,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_pw.txt'  @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 13 ---
# NFC-HOA plane wave, 56 secondary sources
set origin 0.15,0.162
set label 1 '\ft \acs{NFC-HOA}'
set label 31 '\ft localization blur:'
set label 32 '\ft $4.75\degree \pm 0.8\degree$'
set label 2 '\tiny $2$' at -1.00,0.52 center front
set label 10 '\ft $6.5\degree$'
set label 11 '\ft $4.0\degree$'
set label 12 '\ft $4.9\degree$'
set label 13 '\scs $M = 28$' at 1.2,1.5 left front tc ls 101
plot 'hoa_nls56_order28_pw.txt'         @localization_arrow,\
     'array_nls56_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave
unset label 2

# --- 14 ---
# NFC-HOA plane wave, 28 secondary sources
set origin 0.358,0.162
set label 1 ''
set label 31 ''
set label 32 ''
set label 2 '\tiny $2$' at -1.00,0.52 center front
set label 3 '\tiny $2$' at -1.25,-0.23 center front
set label 10 '\ft $13.0\degree$'
set label 11 '\ft $10.2\degree$'
set label 12 '\ft $7.3\degree$'
set label 13 '\scs $M = 14$'
plot 'hoa_nls28_order14_pw.txt'         @localization_arrow,\
     'array_nls28_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave
unset label 2
unset label 3

# --- 15 ---
# NFC-HOA plane wave, 14 secondary sources
set origin 0.566,0.162
set label 2 '\tiny $2$' at -0.75,0.52 center front
set label 3 '\tiny $2$' at -0.75,-0.23 center front
set label 4 '\tiny $2$' at -1.00,-0.98 center front
set label 5 '\tiny $2$' at -0.75,-0.98 center front
set label 10 '\ft $2.3\degree$'
set label 11 '\ft $23.3\degree$'
set label 12 '\ft $15.6\degree$'
set label 13 '\scs $M = 7$'
plot 'hoa_nls14_order7_pw.txt'          @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave
unset label 2
unset label 3
unset label 4
unset label 5
unset label 13

# --- 16 ---
# WFS focused source, 56 secondary sources
set origin 0.15,-0.005
set label 1 '\ft \acs{WFS}'
set label 31 '\ft localization blur:'
set label 32 '\ft $4.77\degree \pm 0.6\degree$'
set label 10 '\ft $163.8\degree$'
set label 11 '\ft $19.0\degree$'
set label 12 '\ft $5.3\degree$'
plot 'wfs_nls56_circular_fs.txt'        @localization_arrow,\
     'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_fs.txt'  @array_active w p,\
     set_focused_source(0,0.5)          @focused_source

# --- 17 ---
# WFS focused source, 28 secondary sources
set origin 0.358,-0.005
set label 1 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $166.5\degree$'
set label 11 '\ft $39.3\degree$'
set label 12 '\ft $16.5\degree$'
plot 'wfs_nls28_circular_fs.txt'        @localization_arrow,\
     'array_nls28_circular.txt'         @array_inactive w p,\
     'array_nls28_circular_wfs_fs.txt'  @array_active w p,\
     set_focused_source(0,0.5)          @focused_source

# --- 18 ---
# WFS focused source, 14 secondary sources
set origin 0.566,-0.005
set label 10 '\ft $168.6\degree$'
set label 11 '\ft $50.3\degree$'
set label 12 '\ft $24.9\degree$'
plot 'wfs_nls14_circular_fs.txt'        @localization_arrow,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_fs.txt'  @array_active w p,\
     set_focused_source(0,0.5)          @focused_source

# --- 9.1 ---
# NFC-HOA point source, 14 secondary sources, order 28
set origin 0.775,0.496
set label 10 '\ft $4.2\degree$'
set label 11 '\ft $2.8\degree$'
set label 12 '\ft $2.5\degree$'
set label 13 '\scs $M=28$' at 1.2,1.5 left front tc ls 101
plot 'hoa_nls14_order28_ps.txt'         @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 15.1 ---
# NFC-HOA plane wave, 14 secondary sources, order 28
set origin 0.775,0.162
set label 10 '\ft $8.2\degree$'
set label 11 '\ft $3.6\degree$'
set label 12 '\ft $3.0\degree$'
plot 'hoa_nls14_order28_pw.txt'         @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

unset multiplot

call 'plot.plt' 'fig5_04'
