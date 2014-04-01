#!/usr/bin/gnuplot
reset
set macros
set loadpath '../../gnuplot'

set t epslatex size 10cm,4.5cm color colortext
set output 'sound_field_time_fixed_fs.tex';

load 'grid.cfg'
#load 'paired.pal'
load 'rdbu.pal'

unset key

set bmargin 2
set tmargin 1

set multiplot layout 1,2
load 'xyborder.cfg'
#set format y ''
set ylabel 'sound pressure'
set xlabel '$t$/ms'
set lmargin 4
set rmargin 0
set label 1 '\ft continuous secondary sources' at 6,1.4 center tc ls 101
set label 2 '\ft \ac{WFS}' at 11.8,-4.6 right front tc ls 101
set label 3 '\scs listener at'      at 0.7,0.3 left front tc ls 101
set label 4 '\scs $(0,0,0)$\,m'     at 0.7,-0.4 left front tc ls 101
set label 5 '\scs $(0.75,0,0)$\,m'  at 0.7,-2.4 left front tc ls 101
set label 6 '\scs $(0,-0.75,0)$\,m' at 0.7,-4.4 left front tc ls 101
stats 'wfs_X0.00_Y0.00.txt' u 2 nooutput
plot [*:*] [-5:1] 'wfs_X0.00_Y0.00.txt'  u ($1*1000):($2/STATS_min)   w l ls 1 lw 2,\
                  'wfs_X0.75_Y0.00.txt'  u ($1*1000):($2/STATS_min-2) w l ls 2 lw 2,\
                  'wfs_X0.00_Y-0.75.txt' u ($1*1000):($2/STATS_min-4) w l ls 3 lw 2
unset for [ii=3:6] label ii
load 'xborder.cfg'
set lmargin 2
set rmargin 2
set label 1 '\ft 64 secondary sources'
stats 'wfs_X0.00_Y0.00_nls64.txt' u 2 nooutput
plot [*:*] [-5:1] 'wfs_X0.00_Y0.00_nls64.txt'  u ($1*1000):($2/STATS_min)   w l ls 1 lw 2,\
                  'wfs_X0.75_Y0.00_nls64.txt'  u ($1*1000):($2/STATS_min-2) w l ls 2 lw 2,\
                  'wfs_X0.00_Y-0.75_nls64.txt' u ($1*1000):($2/STATS_min-4) w l ls 3 lw 2
unset multiplot

# vim: set textwidth=200:
