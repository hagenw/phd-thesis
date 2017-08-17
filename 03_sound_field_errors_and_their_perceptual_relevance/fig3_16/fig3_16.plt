#!/usr/bin/gnuplot
#
# FIGURE 3.16: Sound pressure of a cosine shaped impulse synthesized as focused
# source by WFS (2.76) at three listening positions. A fixed offset was added
# to the sound pressure at two listening positions for a better visualization.
# Parameters: x_s = (0, 0.5, 0) m, n_s = (0, -1, 0), circular secondary source
# distribution with a diameter of 3 m.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'grid.cfg'
load 'rdbu.pal'

set terminal epslatex size 10.93cm,4.97cm color colortext @small
set output 'fig3_16.tex';

unset key

set bmargin 3.2
set tmargin 1

set multiplot layout 1,2
load 'xyborder.cfg'
set ylabel 'sound pressure'
set xlabel '$t$/ms'
set lmargin 6
set rmargin 0
set label 1 '\ft continuous secondary sources' at 6,1.4 center tc ls 101
set label 2 '\ft \acs{WFS}' at 11.8,-4.6 right front tc ls 101
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
set rmargin 4
set label 1 '\ft 64 secondary sources'
stats 'wfs_X0.00_Y0.00_nls64.txt' u 2 nooutput
plot [*:*] [-5:1] 'wfs_X0.00_Y0.00_nls64.txt'  u ($1*1000):($2/STATS_min)   w l ls 1 lw 2,\
                  'wfs_X0.75_Y0.00_nls64.txt'  u ($1*1000):($2/STATS_min-2) w l ls 2 lw 2,\
                  'wfs_X0.00_Y-0.75_nls64.txt' u ($1*1000):($2/STATS_min-4) w l ls 3 lw 2
unset multiplot

call 'plot.plt' 'fig3_16'

# vim: set textwidth=200:
