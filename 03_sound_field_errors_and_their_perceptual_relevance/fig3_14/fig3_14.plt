#!/usr/bin/gnuplot
#
# FIGURE 3.14: Sound pressure of cosine shaped impulse synthesized as a plane
# wave by NFC-HOA (2.45) and WFS (2.57) at three different listening positions.
# A fixed offset was added to the sound pressure at two listening positions for
# a better visualization. Parameters: n_k = (0, -1, 0), x_ref = (0, 0, 0),
# circular secondary source distribution with a diameter of 3 m.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'grid.cfg'
load 'rdbu.pal'

set terminal epslatex size 15.99cm,9.15cm color colortext @small
set output 'fig3_14.tex';

unset key

set bmargin 2
set tmargin 1.2

set multiplot
set size 0.356,0.5
set origin 0,0.5
load 'yborder.cfg'
set ylabel 'sound pressure'
set lmargin 7
set rmargin 0
set label 1 '\ft continuous secondary sources' at 6,1.4 center tc ls 101
set label 2 '\ft \acs{NFC-HOA}' at 11.8,-4.6 right front tc ls 101
stats 'nfchoa_X0.00_Y0.00.txt' u 2 nooutput
plot [*:*] [-5:1] 'nfchoa_X0.00_Y0.00.txt' u ($1*1000):($2/STATS_max) w l ls 1 lw 2, \
                  'nfchoa_X0.75_Y0.00.txt' u ($1*1000):($2/STATS_max-2) w l ls 2 lw 2, \
                  'nfchoa_X0.00_Y0.75.txt' u ($1*1000):($2/STATS_max-4) w l ls 3 lw 2
set origin 0.335,0.5
load 'noborder.cfg'
unset ylabel
set lmargin 3.5
set rmargin 3.5
set label 1 '\ft 64 secondary sources'
set label 3 '\tiny numerically unstable' at 7.50,-1.93 front tc ls 2
set label 4 '\tiny numerically unst.' at 8.22,-3.93 front tc ls 3
limit1(x,y) = x>7.25 ? 1/0 : y # this hides the numerical unstable parts
limit2(x,y) = x>7.97 ? 1/0 : y
stats 'nfchoa_X0.00_Y0.00_nls64.txt' u 2 nooutput
plot [*:*] [-5:1] 'nfchoa_X0.00_Y0.00_nls64.txt' \
    u ($1*1000):($2/STATS_max) w l ls 1 lw 2,\
                  'nfchoa_X0.75_Y0.00_nls64.txt' \
    u ($1*1000):(limit1($1*1000,$2/STATS_max-2)) w l ls 2 lw 2,\
                  'nfchoa_X0.00_Y0.75_nls64.txt' \
    u ($1*1000):(limit2($1*1000,$2/STATS_max-4)) w l ls 3 lw 2
set origin 0.67,0.5
unset label 3
unset label 4
load 'xborder.cfg'
set xlabel '$t$ / ms'
set lmargin 0
set rmargin 7
set label 2 '\ft band-limited \acs{NFC-HOA}'
stats 'nfchoa_X0.00_Y0.00_nls64_band_limited.txt' u 2 nooutput
plot [*:*] [-5:1] 'nfchoa_X0.00_Y0.00_nls64_band_limited.txt' \
    u ($1*1000):($2/STATS_max) w l ls 1 lw 2,\
                  'nfchoa_X0.75_Y0.00_nls64_band_limited.txt' \
    u ($1*1000):($2/STATS_max-2) w l ls 2 lw 2,\
                  'nfchoa_X0.00_Y0.75_nls64_band_limited.txt' \
    u ($1*1000):($2/STATS_max-4) w l ls 3 lw 2
set origin 0,0
load 'xyborder.cfg'
set ylabel 'sound pressure'
set bmargin 3.2
set tmargin 0
set lmargin 7
set rmargin 0
unset label 1
set label 2 '\ft \acs{WFS}'
set label 3 '\scs listener at'  at 11,1.2 right front tc ls 101
set label 4 '\scs $(0,0,0)$\,m' at 11,0.5 right front tc ls 101
set label 5 '\scs $(0.75,0,0)$\,m' at 11,-1.5 right front tc ls 101
set label 6 '\scs $(0,0.75,0)$\,m' at 11,-3.5 right front tc ls 101
stats 'wfs_X0.00_Y0.00.txt' u 2 nooutput
plot [*:*] [-5:1] 'wfs_X0.00_Y0.00.txt' u ($1*1000):($2/STATS_min) w l ls 1 lw 2,\
                  'wfs_X0.75_Y0.00.txt' u ($1*1000):($2/STATS_min-2) w l ls 2 lw 2,\
                  'wfs_X0.00_Y0.75.txt' u ($1*1000):($2/STATS_min-4) w l ls 3 lw 2
set origin 0.335,0
unset for [ii=3:6] label ii
load 'xborder.cfg'
set lmargin 3.5
set rmargin 3.5
stats 'wfs_X0.00_Y0.00_nls64.txt' u 2 nooutput
plot [*:*] [-5:1] 'wfs_X0.00_Y0.00_nls64.txt' \
    u ($1*1000):($2/STATS_min) w l ls 1 lw 2,\
                  'wfs_X0.75_Y0.00_nls64.txt' \
    u ($1*1000):($2/STATS_min-2) w l ls 2 lw 2,\
                  'wfs_X0.00_Y0.75_nls64.txt' \
    u ($1*1000):($2/STATS_min-4) w l ls 3 lw 2
unset multiplot

call 'plot.plt' 'fig3_14'
