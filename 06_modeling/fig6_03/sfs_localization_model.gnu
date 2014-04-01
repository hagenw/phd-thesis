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

set terminal epslatex size 10cm,21cm color colortext
set output 'sfs_localization_model_a.tex'

load 'localization.cfg'
load 'array.cfg'

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
set multiplot layout 6,3

# --- 1 data ---
set xrange [-2.1:2.1]
set yrange [-2.3:1.1]
# WFS point source, 15 secondary sources
set label 1 '\ft \ac{WFS}' at screen 0, graph 0.7 right front
set label 41 '\ft experiment' at screen 0, graph 0.5 right front 
set label 31 '\ft localization blur:' at screen 0, graph 0.32 right front
set label 32 '\ft $2.29\degree \pm 0.3\degree$' at screen 0, graph 0.2 right front
set label 10 '\ft $0.5\degree$' at 0.15,-1.5 left front             # mean localization error for y=-1.5m
set label 11 '\ft $0.6\degree$' at 0.15,-2.0 left front             # mean localization error for y=-2m
set arrow 21 from 1.221,0.2 to 1.425,0.2 heads size 0.05,90,0 front ls 101 # mark distance between adjacent loudspeakers
set label 21 '\tiny $0.20$\,m' at 1.323,0.4 front center tc ls 101
plot 'wfs_nls15_linear_ps.txt'          @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls15_linear.txt'           @array_active w p,\
     set_point_source(0,1)              @point_source

# --- 2 data ---
# WFS point source, 8 secondary sources
set label 1 ''
set label 41 ''
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

# --- 3 data ---
# WFS point source, 3 secondary sources
set label 10 '\ft $6.7\degree$'
set label 11 '\ft $5.9\degree$'
set arrow 21 from 0,0.2 to 1.425,0.2
set label 21 '\tiny $1.43$\,m' at 0.713,0.4
plot 'wfs_nls3_linear_ps.txt'           @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls3_linear.txt'            @array_active w p,\
     set_point_source(0,1)              @point_source

# --- 1 model ---
unset arrow 21
unset label 21
set label 1 '\ft \ac{WFS}'
set label 41 '\ft binaural model' 
set label 31 '\ft localization blur:'
set label 32 '\ft $4.42\degree \pm 0.3\degree$'
set label 10 '\ft $0.7\degree$'
set label 11 '\ft $0.6\degree$'
# WFS point source, 15 secondary sources
plot 'wfs_nls15_linear_ps_model.txt'    @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls15_linear.txt'           @array_active w p,\
     set_point_source(0,1)              @point_source

# --- 2 model ---
# WFS point source, 8 secondary sources
set label 1 ''
set label 41 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $1.4\degree$'
set label 11 '\ft $1.5\degree$'
plot 'wfs_nls8_linear_ps_model.txt'     @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls8_linear.txt'            @array_active w p,\
     set_point_source(0,1)              @point_source

# --- 3 model ---
# WFS point source, 3 secondary sources
set label 10 '\ft $6.1\degree$'
set label 11 '\ft $5.5\degree$'
plot 'wfs_nls3_linear_ps_model.txt'     @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls3_linear.txt'            @array_active w p,\
     set_point_source(0,1)              @point_source

# --- 4 data ---
set yrange [-2.1:2.6]
# WFS point source, 56 secondary sources
set label 1 '\ft \ac{WFS}'
set label 41 '\ft experiment'
set label 31 '\ft localization blur:'
set label 32 '\ft $2.76\degree \pm 0.7\degree$' at screen 0, graph 0.22 right front
set label 10 '\ft $0.9\degree$' at 0.15, 0.75 left front
set label 11 '\ft $0.9\degree$' at 0.15, 0.00 left front
set label 12 '\ft $0.6\degree$' at 0.15,-0.75 left front
set arrow 21 from 1.210,1.194 to 1.322,1.069 heads size 0.05,90,0 front ls 101
set label 21 '\tiny $0.17$\,m' at 1.452,1.298 rotate by -48.21 front center tc ls 101
plot 'wfs_nls56_circular_ps.txt'        @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_ps.txt'  @array_active w p,\
     set_point_source(0,2.5)            @point_source 

# --- 5 data ---
# WFS point source, 28 secondary sources
set label 1 ''
set label 41 ''
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

# --- 6 data ---
# WFS point source, 14 secondary sources
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

# --- 4 model ---
set yrange [-2.1:2.6]
# WFS point source, 56 secondary sources
unset arrow 21
unset label 21
set label 1 '\ft \ac{WFS}'
set label 41 '\ft binaural model'
set label 31 '\ft localization blur:'
set label 32 '\ft $3.34\degree \pm 0.2\degree$'
set label 10 '\ft $1.6\degree$' at 0.15, 0.75 left front
set label 11 '\ft $1.1\degree$' at 0.15, 0.00 left front
set label 12 '\ft $0.7\degree$' at 0.15,-0.75 left front
plot 'wfs_nls56_circular_ps_model.txt'  @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_ps.txt'  @array_active w p,\
     set_point_source(0,2.5)            @point_source 

# --- 5 model ---
# WFS point source, 28 secondary sources
set label 1 ''
set label 41 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $1.8\degree$'
set label 11 '\ft $0.9\degree$'
set label 12 '\ft $0.8\degree$'
plot 'wfs_nls28_circular_ps_model.txt'  @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls28_circular.txt'         @array_inactive w p,\
     'array_nls28_circular_wfs_ps.txt'  @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 6 model ---
# WFS point source, 14 secondary sources
set label 10 '\ft $3.6\degree$'
set label 11 '\ft $2.5\degree$'
set label 12 '\ft $1.4\degree$'
plot 'wfs_nls14_circular_ps_model.txt'  @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_ps.txt'  @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 7 data ---
# NFC-HOA point source, 56 secondary sources
set label 1 '\ft \ac{NFC-HOA}'
set label 41 '\ft experiment'
set label 31 '\ft localization blur:'
set label 32 '\ft $3.92\degree \pm 0.8\degree$'
set label 10 '\ft $5.0\degree$'
set label 11 '\ft $1.4\degree$'
set label 12 '\ft $0.7\degree$'
plot 'hoa_nls56_order28_ps.txt'         @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls56_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source 

# --- 8 data ---
# NFC-HOA point source, 28 secondary sources
set label 1 ''
set label 41 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $8.1\degree$'
set label 11 '\ft $4.2\degree$'
set label 12 '\ft $1.4\degree$'
plot 'hoa_nls28_order14_ps.txt'         @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls28_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 9 data ---
# NFC-HOA point source, 14 secondary sources
set label 2 '\tiny $2$' at -1.25,-0.23 center front
set label 3 '\tiny $2$' at -1.00,-0.23 center front
set label 4 '\tiny $2$' at -0.75,-0.23 center front
set label 5 '\tiny $2$' at -1.00,-0.98 center front
set label 6 '\tiny $2$' at -0.75,-0.98 center front
set label 10 '\ft $11.7\degree$'
set label 11 '\ft $32.2\degree$'
set label 12 '\ft $16.5\degree$'
plot 'hoa_nls14_order7_ps.txt'          @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 7 model ---
# NFC-HOA point source, 56 secondary sources
set label 1 '\ft \ac{NFC-HOA}'
set label 41 '\ft binaural model'
set label 2 ''
set label 3 ''
set label 4 ''
set label 5 ''
set label 6 ''
set label 31 '\ft localization blur:'
set label 32 '\ft $4.29\degree \pm 0.3\degree$'
set label 10 '\ft $1.7\degree$'
set label 11 '\ft $0.9\degree$'
set label 12 '\ft $0.5\degree$'
plot 'hoa_nls56_order28_ps_model.txt'   @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls56_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source 

# --- 8 model ---
# NFC-HOA point source, 28 secondary sources
set label 1 ''
set label 41 ''
set label 31 ''
set label 32 ''
set label 10 '\ft $2.7\degree$'
set label 11 '\ft $1.2\degree$'
set label 12 '\ft $0.6\degree$'
plot 'hoa_nls28_order14_ps_model.txt'   @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls28_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 9 model ---
# NFC-HOA point source, 14 secondary sources
set label 10 '\ft $6.2\degree$'
set label 11 '\ft $8.7\degree$'
set label 12 '\ft $8.6\degree$'
plot 'hoa_nls14_order7_ps_model.txt'    @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 9.1 data ---
# NFC-HOA point source, 14 secondary sources, order 28
set origin 1,0.16667
set label 10 '\ft $4.2\degree$'
set label 11 '\ft $2.8\degree$'
set label 12 '\ft $2.5\degree$'
plot 'hoa_nls14_order28_ps.txt'         @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

# --- 9.1 model ---
# NFC-HOA point source, 14 secondary sources, order 28
set origin 1,0
set label 10 '\ft $4.1\degree$'
set label 11 '\ft $2.3\degree$'
set label 12 '\ft $2.4\degree$'
plot 'hoa_nls14_order28_ps_model.txt'   @localization_grey_line,\
     ''                                 @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_point_source(0,2.5)            @point_source

unset label 2
unset label 3
unset label 4
unset label 5
unset label 6

unset multiplot

# ========================================================================

set output 'sfs_localization_model_b.tex'

set multiplot layout 6,3

# --- 10 data ---
# WFS plane wave, 56 secondary sources
set label 1 '\ft \ac{WFS}'
set label 41 '\ft experiment'
set label 31 '\ft localization blur:'
set label 32 '\ft $3.30\degree \pm 1.0\degree$'
set label 10 '\ft $2.3\degree$'
set label 11 '\ft $0.6\degree$'
set label 12 '\ft $0.7\degree$'
plot 'wfs_nls56_circular_pw.txt'        @localization_arrow,\
     'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_pw.txt'  @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 11 data ---
# WFS plane wave, 28 secondary sources
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
set label 10 '\ft $5.8\degree$'
set label 11 '\ft $4.9\degree$'
set label 12 '\ft $2.1\degree$'
plot 'wfs_nls14_circular_pw.txt'        @localization_arrow,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_pw.txt'  @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 10 model ---
# WFS plane wave, 56 secondary sources
set label 1 '\ft \ac{WFS}'
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
set label 10 '\ft $7.5\degree$'
set label 11 '\ft $2.5\degree$'
set label 12 '\ft $1.6\degree$'
plot 'wfs_nls14_circular_pw_model.txt'  @localization_arrow,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_pw.txt'  @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 13 data ---
# NFC-HOA plane wave, 56 secondary sources
set label 1 '\ft \ac{NFC-HOA}'
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
set label 1 '\ft \ac{NFC-HOA}'
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
set label 1 '\ft \ac{WFS}'
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
set label 10 '\ft $168.6\degree$'
set label 11 '\ft $50.3\degree$'
set label 12 '\ft $24.9\degree$'
plot 'wfs_nls14_circular_fs.txt'        @localization_arrow,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_fs.txt'  @array_active w p,\
     set_focused_source(0,0.5)          @focused_source

# --- 16 model ---
# WFS focused source, 56 secondary sources
set label 1 '\ft \ac{WFS}'
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
set label 10 '\ft $172.8\degree$'
set label 11 '\ft $42.4\degree$'
set label 12 '\ft $20.3\degree$'
plot 'wfs_nls14_circular_fs_model.txt'  @localization_arrow,\
     'array_nls14_circular.txt'         @array_inactive w p,\
     'array_nls14_circular_wfs_fs.txt'  @array_active w p,\
     set_focused_source(0,0.5)          @focused_source

# --- 15.1 data ---
# NFC-HOA plane wave, 14 secondary sources, order 28
set origin 1,0.5
set label 10 '\ft $8.2\degree$'
set label 11 '\ft $3.6\degree$'
set label 12 '\ft $3.0\degree$'
plot 'hoa_nls14_order28_pw.txt'         @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

# --- 15.1 model ---
# NFC-HOA plane wave, 14 secondary sources, order 28
set origin 1,0.333333
set label 10 '\ft $7.7\degree$'
set label 11 '\ft $7.9\degree$'
set label 12 '\ft $3.4\degree$'
plot 'hoa_nls14_order28_pw_model.txt'   @localization_arrow,\
     'array_nls14_circular.txt'         @array_active w p,\
     set_plane_wave(0,2.2)              @plane_wave

unset multiplot

# vim: set textwidth=200:
