#!/usr/bin/gnuplot
#
# FIGURE 3.12: Sound pressure in decibel of a plane wave synthesized by NFC-HOA
# (2.45) and WFS (2.55). Mono-frequent simulations were done for all frequencies
# at three different listening positions. A fixed offset was added to the
# amplitudes for two of the positions for better visualization. Parameters:
# n_k = (0, -1, 0), x_ref = (0, 0, 0) m, circular secondary source distribution
# with a diameter of 3 m.
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

set terminal epslatex size 16cm,9.15cm color colortext @small
set output 'fig3_12.tex';

unset key

set tmargin 1.2
set bmargin 2

set logscale x
set xrange [0.1:20]
set yrange [-45:45]

db(x) = 20*log10(x)

set multiplot
set size 0.356,0.5
set origin 0,0.5
load 'yborder.cfg'
set xtics nomirror out scale 0,0.001 # add mxtics
set ylabel 'sound pressure'
set lmargin 7
set rmargin 0
set label 1 '\ft continuous secondary sources' at 1.4,52 center tc ls 101
set label 2 '\ft \acs{NFC-HOA}' at 0.13,-41 left front tc ls 101
plot 'freq_response_nfchoa_X0.00_Y0.00.txt' u ($1/1000):(db($2)-52.556+30) w l ls 1 lw 3, \
     'freq_response_nfchoa_X0.75_Y0.00.txt' u ($1/1000):(db($2)-53.179) w l ls 2 lw 3, \
     'freq_response_nfchoa_X0.00_Y0.75.txt' u ($1/1000):(db($2)-55.224-30) w l ls 3 lw 3
set origin 0.335,0.5
load 'noborder.cfg'
set xtics nomirror out scale 0,0.001 # add mxtics
unset ylabel
set lmargin 3.5
set rmargin 3.5
set label 1 '\ft 64 secondary sources'
plot 'freq_response_nfchoa_X0.00_Y0.00_nls64.txt' u ($1/1000):(db($2)-16.638+30) w l ls 1 lw 3,\
     'freq_response_nfchoa_X0.75_Y0.00_nls64.txt' u ($1/1000):(db($2)-17.261) w l ls 2 lw 3,\
     'freq_response_nfchoa_X0.00_Y0.75_nls64.txt' u ($1/1000):(db($2)-19.306-30) w l ls 3 lw 3
set origin 0.67,0.5
load 'xborder.cfg'
set xlabel '$f$ / kHz'
set lmargin 0
set rmargin 7
set label 2 '\ft band-limited \acs{NFC-HOA}'
plot 'freq_response_nfchoa_X0.00_Y0.00_nls64_band_limited.txt' u ($1/1000):(db($2)-16.638+30) w l ls 1 lw 3,\
     'freq_response_nfchoa_X0.75_Y0.00_nls64_band_limited.txt' u ($1/1000):(db($2)-17.261) w l ls 2 lw 3,\
     'freq_response_nfchoa_X0.00_Y0.75_nls64_band_limited.txt' u ($1/1000):(db($2)-19.306-30) w l ls 3 lw 3
set origin 0,0
load 'xyborder.cfg'
set ylabel 'sound pressure'
set bmargin 3.2
set tmargin 0
set lmargin 7
set rmargin 0
unset label 1
set label 2 '\ft \acs{WFS}'
set label 3 '\scs listener at'  at 12,34 right front tc ls 101
set label 4 '\scs $(0,0,0)$\,m' at 12,25 right front tc ls 101
set label 5 '\scs $(0.75,0,0)$\,m' at 12,-5 right front tc ls 101
set label 6 '\scs $(0,0.75,0)$\,m' at 12,-35 right front tc ls 101
plot 'freq_response_wfs_X0.00_Y0.00.txt' u ($1/1000):(db($2)-52.576+30) w l ls 1 lw 3,\
     'freq_response_wfs_X0.75_Y0.00.txt' u ($1/1000):(db($2)-53.168) w l ls 2 lw 3,\
     'freq_response_wfs_X0.00_Y0.75.txt' u ($1/1000):(db($2)-55.549-30) w l ls 3 lw 3
set origin 0.335,0
load 'xborder.cfg'
set lmargin 3.5
set rmargin 3.5
unset for [ii=3:6] label ii
plot 'freq_response_wfs_X0.00_Y0.00_nls64.txt' u ($1/1000):(db($2)-16.675+30) w l ls 1 lw 3,\
     'freq_response_wfs_X0.75_Y0.00_nls64.txt' u ($1/1000):(db($2)-17.228) w l ls 2 lw 3,\
     'freq_response_wfs_X0.00_Y0.75_nls64.txt' u ($1/1000):(db($2)-19.582-30) w l ls 3 lw 3
unset multiplot

call 'plot.plt' 'fig3_12'

# vim: set textwidth=200:
