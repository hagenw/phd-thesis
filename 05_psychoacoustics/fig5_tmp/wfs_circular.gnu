#!/usr/bin/gnuplot
#
# <+DESCRIPTION+>
#
# AUTHOR: Hagen Wierstorf

reset

#@WXT
#set terminal epslatex size 5.4cm,4.5cm color colortext
set terminal epslatex size 15cm,7.5cm color colortext
set output 'wfs_circular.tex'

load 'localization.cfg'

unset key
set size ratio -1

set style line 101 lc rgb '#808080' lt 1 lw 1

set xrange [-1.7:1.7]
set yrange [-1.8:2.6]
set cbrange [0:40]


set label 1 '\ft loudspeaker spacing:' at 1.8,3 right
set label 2 '[loudspeaker spacing]'at 1.8,2.6 right
set label 3 '[SFS]' at -1.9,0 right
set label 4 '[src]' at 0,3 center
set label 7 '[mean error Y0.75]'   at 0.15,0.75
set label 8 '[mean error Y0.00]'   at 0.15,0
set label 9 '[mean error Y-0.75]'  at 0.15,-0.75



set tmargin 9
set bmargin 2
set lmargin 0
set rmargin 0

unset colorbox
unset tics
unset xlabel
unset ylabel
set border 0

# === start plotting =====================================================
set multiplot 6,3

# --- 1 ---
# WFS point source, 56 secondary sources
#set origin -0.38,0
set label 1  ''
set label 2  ''
set label 3  'WFS model'
set label 4  ''
set label 7  '\ft $1.5^\circ$'
set label 8  '\ft $1.1^\circ$'
set label 9  '\ft $0.6^\circ$'
plot 'wfs_nls56_ps_mean.txt'            @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls56.txt'         @array_inactive w p,\
     'circular_array_nls56_wfs_ps.txt'  @array_active w p,\
     "<echo '0 2.5'"                    @point_source 

# --- 2 ---
# WFS point source, 28 secondary sources
set label 3 ''
unset object
set label 4  'point source'
set label 7  '\ft $1.7^\circ$'
set label 8  '\ft $0.9^\circ$'
set label 9  '\ft $0.7^\circ$'
plot 'wfs_nls28_ps_mean.txt'            @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls28.txt'         @array_inactive w p,\
     'circular_array_nls28_wfs_ps.txt'  @array_active w p,\
     "<echo '0 2.5'"                    @point_source

# --- 3 ---
# WFS point source, 14 secondary sources
unset object
set label 4  ''
set label 7  '\ft $16.1^\circ$'
set label 8  '\ft $3.3^\circ$'
set label 9  '\ft $1.2^\circ$'
plot 'wfs_nls14_ps_mean.txt'            @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls14.txt'         @array_inactive w p,\
     'circular_array_nls14_wfs_ps.txt'  @array_active w p,\
     "<echo '0 2.5'"                    @point_source
# --- 4 ---
# WFS plane wave, 56 secondary sources
unset object
set label 3 'WFS data'
set label 7 '\ft $0.9^\circ$'
set label 8 '\ft $0.9^\circ$'
set label 9 '\ft $0.6^\circ$'
plot 'wfs_nls56_pw_mean.txt'            @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls56.txt'         @array_inactive w p,\
     'circular_array_nls56_wfs_pw.txt'  @array_active w p,\
     "<echo '0 2.5'"                    @plane_wave

# --- 5 ---
# WFS plane wave, 28 secondary sources
unset object
set label 3 ''
set label 7 '\ft $1.7^\circ$'
set label 8 '\ft $1.9^\circ$'
set label 9 '\ft $1.4^\circ$'
plot 'wfs_nls28_pw_mean.txt'            @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls28.txt'         @array_inactive w p,\
     'circular_array_nls28_wfs_pw.txt'  @array_active w p,\
     "<echo '0 2.5'"                    @plane_wave

# --- 6 ---
# WFS plane wave, 14 secondary sources
unset object
set label 7  '\ft $4.2^\circ$'
set label 8  '\ft $1.7^\circ$'
set label 9  '\ft $0.4^\circ$'
plot 'wfs_nls14_pw_mean.txt'            @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls14.txt'         @array_inactive w p,\
     'circular_array_nls14_wfs_pw.txt'  @array_active w p,\
     "<echo '0 w.5'"                    @plane_wave

# --- 7 ---
# NFC-HOA point source, 56 secondary sources
unset object
set label 7  '\ft $0.8^\circ$'
set label 8  '\ft $1.2^\circ$'
set label 9  '\ft $1.5^\circ$'
set arrow 1 from 0,-2.0 to 1,-2.0 nohead ls 101
set arrow 2 from 0,-2.1 to 0,-1.9 nohead ls 101
set arrow 3 from 1,-2.1 to 1,-1.9 nohead ls 101
set label 10 '$1$\,m' at 0.5,-2.3 center tc ls 101
plot 'hoa_nls56_ps_mean.txt'            @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls56.txt'         @array_active w p,\
     "<echo '0 2.5'"                    @point_source

# --- 8 ---
# NFC-HOA point source, 28 secondary sources
unset object
unset arrow
unset label 10
set label 4  'plane wave'
set label 7  '\ft $3.2^\circ$'
set label 8  '\ft $2.7^\circ$'
set label 9  '\ft $1.7^\circ$'
plot 'hoa_nls28_ps_mean.txt'            @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls28.txt'         @array_active w p,\
     "<echo '0 2.5'"                    @point_source

# --- 9 ---
# NFC-HOA point source, 14 secondary sources
unset object
set label 4  ''
set label 7  '\ft $8.6^\circ$'
set label 8  '\ft $2.9^\circ$'
set label 9  '\ft $2.3^\circ$'
plot 'hoa_nls14_ps_mean.txt'            @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls14.txt'         @array_active w p,\
     "<echo '0 2.5'"                    @point_source

# --- 10 ---
# NFC-HOA plane wave, 56 secondary sources
unset object
set label 1 '\ft loudspeaker spacing:'
set label 2 '\ft $0.17$\,m'
set label 7 '\ft $2.3^\circ$'
set label 8 '\ft $0.6^\circ$'
set label 9 '\ft $0.7^\circ$'
plot 'hoa_nls56_pw_mean.txt'            @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls56.txt'         @array_active w p,\
     "<echo '0 2.5'"                    @plane_wave
    
# --- 11 ---
# NFC-HOA plane wave, 28 secondary sources
unset object
set label 1 ''
set label 2 '\ft $0.34$\,m'
set label 7 '\ft $4.4^\circ$'
set label 8 '\ft $1.9^\circ$'
set label 9 '\ft $1.3^\circ$'
plot 'hoa_nls28_pw_mean.txt'            @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls28.txt'         @array_active w p,\
     "<echo '0 2.5'"                    @plane_wave

# --- 12 ---
# NFC-HOA plane wave, 14 secondary sources
unset object
set label 2 '\ft $0.67$\,m'
set label 7 '\ft $5.8^\circ$'
set label 8 '\ft $4.9^\circ$'
set label 9 '\ft $2.1^\circ$'
set cbtics 20 out nomirror scale 0.75 offset 0,0.5
set format cb '$%g^\circ$'
set colorbox user horizontal origin 0.32,0.075 size 0.08,0.02 front border 101
plot 'hoa_nls14_pw_mean.txt'            @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls14.txt'         @array_active w p,\
     "<echo '0 2.5'"                    @plane wave

# --- 13 ---
plot 1/0

# --- 14 ---
plot 1/0

# --- 15 ---
# NFC-HOA point source, 14 secondary sources, 28th order
unset object
plot 'hoa_nls1456_ps_mean.txt'          @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls14.txt'         @array_active w p,\
     "<echo '0 2.5'"                    @point_source

# --- 16 ---
plot 1/0

# --- 17 ---
plot 1/0

# --- 18 ---
# NFC-HOA plane wave, 14 secondary sources, 28th order
plot 'hoa_nls1456_pw_mean.txt'          @localization_grey_line,\
     ''                                 @localization_arrow,\
     'circular_array_nls14.txt'         @array_active w p,\
     "<echo '0 2.5'"                    @plane_wave

unset multiplot
