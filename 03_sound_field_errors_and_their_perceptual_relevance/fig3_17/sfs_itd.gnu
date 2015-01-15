#!/usr/bin/gnuplot
reset
set macros
set loadpath '../../gnuplot'

set t epslatex size 10cm,9cm color colortext
set output 'sfs_itd.tex';

load 'grid.cfg'
set grid xtics ytics mxtics
#load 'paired.pal'
load 'rdbu.pal'

unset key

set bmargin 2
set tmargin 1

set logscale x
set xrange [236.3:1296.1]
set yrange [-4:4]


set multiplot layout 2,2
load 'yborder.cfg'
set ytics ('$-0.8$' -3.3,'$0$' -2.5,'$0.8$' -1.7,-0.8,0,0.8,'$-0.8$' 1.7,'$0$' 2.5,'$0.8$' 3.3)
set xtics nomirror out scale 0,0.001 # add mxtics
set ylabel '\ac{ITD} / ms' offset 1,0
set lmargin 4
set rmargin 0
set label 1 '\ft continuous secondary sources' at 569,5 center tc ls 101
set label 2 '\ft \ac{NFC-HOA}' at 250,-3.5 left front tc ls 101
set label 3 '\tiny numerically unstable' at 569,2.6 center front tc ls 1
set label 4 '\tiny numerically unstable' at 569,0.1 center front tc ls 2
set label 5 '\tiny numerically unstable' at 569,-2.4 center front tc ls 3
plot 1/0
#plot 'nfchoa_X0.00_Y0.00.txt' u ($1):($2*1000+2) w l ls 1 lw 3, \
#     'nfchoa_X0.50_Y0.00.txt' u ($1):($2*1000) w l ls 2 lw 3, \
#     'nfchoa_X1.00_Y0.00.txt' u ($1):($2*1000-2) w l ls 3 lw 3
unset for [ii=3:5] label ii
load 'noborder.cfg'
set ytics (-3.3,-2.5,-1.7,-0.8,0,0.8,1.7,2.5,3.3)
set xtics nomirror out scale 0,0.001 # add mxtics
unset ylabel
set lmargin 2
set rmargin 2
set label 1 '\ft 22 secondary sources'
set label 2 '\ft band-limited \ac{NFC-HOA}'
plot 'nfchoa_X0.00_Y0.00_nls22_band_limited.txt' u ($1):($2*1000+2.5) w l ls 1 lw 3,\
     'nfchoa_X0.50_Y0.00_nls22_band_limited.txt' u ($1):($2*1000) w l ls 2 lw 3,\
     'nfchoa_X1.00_Y0.00_nls22_band_limited.txt' u ($1):($2*1000-2.5) w l ls 3 lw 3
set xtics (236.32,289.34 1,348.4,414.19 1,487.49,569.13 1,660.08 1,761.4,\
    874.27 1,1000 1,'$1.1$k' 1140.1,1296.1 1)
load 'xyborder.cfg'
set ytics ('$-0.8$' -3.3,'$0$' -2.5,'$0.8$' -1.7,-0.8,0,0.8,'$-0.8$' 1.7,'$0$' 2.5,'$0.8$' 3.3)
set format x '$%.0f$'
set ylabel '\ac{ITD} / ms' offset 1,0
set xlabel '$f$ / kHz'
set bmargin 3
set tmargin 0
set lmargin 4
set rmargin 0
unset label 1
set label 2 '\ft \ac{WFS}'
set label 3 '\scs listener at'  at 1200,3.0 right front tc ls 101
set label 4 '\scs $(0,0,0)$\,m' at 1200,1.9 right front tc ls 101
set label 5 '\scs $(0.5,0,0)$\,m' at 1200,-0.6 right front tc ls 101
set label 6 '\scs $(1,0,0)$\,m' at 1200,-3.1 right front tc ls 101
plot 'wfs_X0.00_Y0.00.txt' u ($1):($2*1000+2.5) w l ls 1 lw 3,\
     'wfs_X0.50_Y0.00.txt' u ($1):($2*1000) w l ls 2 lw 3,\
     'wfs_X1.00_Y0.00.txt' u ($1):($2*1000-2.5) w l ls 3 lw 3
load 'xborder.cfg'
set ytics (-3.3,-2.5,-1.7,-0.8,0,0.8,1.7,2.5,3.3)
set format x '$%.0f$'
set lmargin 2
set rmargin 2
unset for [ii=3:6] label ii
plot 'wfs_X0.00_Y0.00_nls22.txt' u ($1):($2*1000+2.5) w l ls 1 lw 3,\
     'wfs_X0.50_Y0.00_nls22.txt' u ($1):($2*1000) w l ls 2 lw 3,\
     'wfs_X1.00_Y0.00_nls22.txt' u ($1):($2*1000-2.5) w l ls 3 lw 3
unset multiplot

# vim: set textwidth=200:
