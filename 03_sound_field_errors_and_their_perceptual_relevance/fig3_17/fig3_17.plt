#!/usr/bin/gnuplot
#
# FIGURE 3.17: ITDs for a pink noise signal synthesized as a point source by
# NFC-HOA (2.45) and WFS (2.57) at three listening positions, with a head
# orientation of 90 deg. Parameters: x_s = (0, 2.5, 0)m, x_ref = (0, 0, 0),
# circular secondary source distribution with a diameter of 3 m.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'grid.cfg'
set grid xtics ytics mxtics
load 'rdbu.pal'

set terminal epslatex size 10.5cm,9.3cm color colortext @small
set output 'fig3_17.tex';

unset key

set bmargin 2
set tmargin 1.4

set logscale x
set xrange [236.3:1296.1]
set yrange [-4:4]

set multiplot
set size 0.542,0.5
set origin 0,0.5
load 'yborder.cfg'
set ytics ('$-0.8$' -3.3,'$0$' -2.5,'$0.8$' -1.7,-0.8,0,0.8,'$-0.8$' 1.7,'$0$' 2.5,'$0.8$' 3.3)
set xtics nomirror out scale 0,0.001 # add mxtics
set ylabel '\acs{ITD} / ms' offset 1,0
set lmargin 6.9
set rmargin 0
set label 1 '\ft continuous secondary sources' at 569,5 center tc ls 101
set label 2 '\ft \acs{NFC-HOA}' at 250,-3.5 left front tc ls 101
set label 3 '\tiny numerically unstable' at 569,2.6 center front tc ls 1
set label 4 '\tiny numerically unstable' at 569,0.1 center front tc ls 2
set label 5 '\tiny numerically unstable' at 569,-2.4 center front tc ls 3
plot 1/0
#plot 'nfchoa_X0.00_Y0.00.txt' u ($1):($2*1000+2) w l ls 1 lw 3, \
#     'nfchoa_X0.50_Y0.00.txt' u ($1):($2*1000) w l ls 2 lw 3, \
#     'nfchoa_X1.00_Y0.00.txt' u ($1):($2*1000-2) w l ls 3 lw 3
set origin 0.432,0.5
unset for [ii=3:5] label ii
load 'noborder.cfg'
set ytics (-3.3,-2.5,-1.7,-0.8,0,0.8,1.7,2.5,3.3)
set xtics nomirror out scale 0,0.001 # add mxtics
unset ylabel
set label 1 '\ft 22 secondary sources'
set label 2 '\ft band-limited \acs{NFC-HOA}'
plot 'nfchoa_X0.00_Y0.00_nls22_band_limited.txt' u ($1):($2*1000+2.5) w l ls 1 lw 3,\
     'nfchoa_X0.50_Y0.00_nls22_band_limited.txt' u ($1):($2*1000) w l ls 2 lw 3,\
     'nfchoa_X1.00_Y0.00_nls22_band_limited.txt' u ($1):($2*1000-2.5) w l ls 3 lw 3
set origin 0,0
set xtics (236.32,289.34 1,348.4,414.19 1,487.49,569.13 1,660.08 1,761.4,\
    874.27 1,1000 1,'$1.1$k' 1140.1,1296.1 1)
load 'xyborder.cfg'
set ytics ('$-0.8$' -3.3,'$0$' -2.5,'$0.8$' -1.7,-0.8,0,0.8,'$-0.8$' 1.7,'$0$' 2.5,'$0.8$' 3.3)
set format x '$%.0f$'
set ylabel '\acs{ITD} / ms' offset 1,0
set xlabel '$f$ / kHz'
set bmargin 3.4
set tmargin 0
unset label 1
set label 2 '\ft \acs{WFS}'
set label 3 '\scs listener at'  at 1200,3.0 right front tc ls 101
set label 4 '\scs $(0,0,0)$\,m' at 1200,1.9 right front tc ls 101
set label 5 '\scs $(0.5,0,0)$\,m' at 1200,-0.6 right front tc ls 101
set label 6 '\scs $(1,0,0)$\,m' at 1200,-3.1 right front tc ls 101
plot 'wfs_X0.00_Y0.00.txt' u ($1):($2*1000+2.5) w l ls 1 lw 3,\
     'wfs_X0.50_Y0.00.txt' u ($1):($2*1000) w l ls 2 lw 3,\
     'wfs_X1.00_Y0.00.txt' u ($1):($2*1000-2.5) w l ls 3 lw 3
set origin 0.432,0
load 'xborder.cfg'
set ytics (-3.3,-2.5,-1.7,-0.8,0,0.8,1.7,2.5,3.3)
set format x '$%.0f$'
unset for [ii=3:6] label ii
plot 'wfs_X0.00_Y0.00_nls22.txt' u ($1):($2*1000+2.5) w l ls 1 lw 3,\
     'wfs_X0.50_Y0.00_nls22.txt' u ($1):($2*1000) w l ls 2 lw 3,\
     'wfs_X1.00_Y0.00_nls22.txt' u ($1):($2*1000-2.5) w l ls 3 lw 3
unset multiplot

call 'plot.plt' 'fig3_17'

# vim: set textwidth=200:
