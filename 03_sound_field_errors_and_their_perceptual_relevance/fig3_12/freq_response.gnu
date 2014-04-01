#!/usr/bin/gnuplot
reset
set macros
set loadpath '../../gnuplot'

set t epslatex size 15cm,9cm color colortext
set output 'freq_response.tex';

load 'grid.cfg'
set grid xtics ytics mxtics
#load 'paired.pal'
load 'rdbu.pal'

unset key

set bmargin 2
set tmargin 1

set logscale x
set xrange [0.1:20]
set yrange [-45:45]

db(x) = 20*log10(x)

set multiplot layout 2,3
load 'yborder.cfg'
set xtics nomirror out scale 0,0.001 # add mxtics
set ylabel 'sound pressure'
set lmargin 4
set rmargin 0
set label 1 '\ft continuous secondary sources' at 1.4,52 center tc ls 101
set label 2 '\ft \ac{NFC-HOA}' at 0.13,-41 left front tc ls 101
plot 'freq_response_nfchoa_X0.00_Y0.00.txt' u ($1/1000):(db($2)-52.556+30) w l ls 1 lw 3, \
     'freq_response_nfchoa_X0.75_Y0.00.txt' u ($1/1000):(db($2)-53.179) w l ls 2 lw 3, \
     'freq_response_nfchoa_X0.00_Y0.75.txt' u ($1/1000):(db($2)-55.224-30) w l ls 3 lw 3
load 'noborder.cfg'
set xtics nomirror out scale 0,0.001 # add mxtics
unset ylabel
set lmargin 2
set rmargin 2
set label 1 '\ft 64 secondary sources'
plot 'freq_response_nfchoa_X0.00_Y0.00_nls64.txt' u ($1/1000):(db($2)-16.638+30) w l ls 1 lw 3,\
     'freq_response_nfchoa_X0.75_Y0.00_nls64.txt' u ($1/1000):(db($2)-17.261) w l ls 2 lw 3,\
     'freq_response_nfchoa_X0.00_Y0.75_nls64.txt' u ($1/1000):(db($2)-19.306-30) w l ls 3 lw 3
load 'xborder.cfg'
set xlabel '$f$ / kHz'
set lmargin 0
set rmargin 4
set label 2 '\ft band-limited \ac{NFC-HOA}'
plot 'freq_response_nfchoa_X0.00_Y0.00_nls64_band_limited.txt' u ($1/1000):(db($2)-16.638+30) w l ls 1 lw 3,\
     'freq_response_nfchoa_X0.75_Y0.00_nls64_band_limited.txt' u ($1/1000):(db($2)-17.261) w l ls 2 lw 3,\
     'freq_response_nfchoa_X0.00_Y0.75_nls64_band_limited.txt' u ($1/1000):(db($2)-19.306-30) w l ls 3 lw 3
load 'xyborder.cfg'
set ylabel 'sound pressure'
set bmargin 3
set tmargin 0
set lmargin 4
set rmargin 0
unset label 1
set label 2 '\ft \ac{WFS}'
set label 3 '\scs listener at'  at 12,34 right front tc ls 101
set label 4 '\scs $(0,0,0)$\,m' at 12,25 right front tc ls 101
set label 5 '\scs $(0.75,0,0)$\,m' at 12,-5 right front tc ls 101
set label 6 '\scs $(0,0.75,0)$\,m' at 12,-35 right front tc ls 101
plot 'freq_response_wfs_X0.00_Y0.00.txt' u ($1/1000):(db($2)-52.576+30) w l ls 1 lw 3,\
     'freq_response_wfs_X0.75_Y0.00.txt' u ($1/1000):(db($2)-53.168) w l ls 2 lw 3,\
     'freq_response_wfs_X0.00_Y0.75.txt' u ($1/1000):(db($2)-55.549-30) w l ls 3 lw 3
load 'xborder.cfg'
set lmargin 2
set rmargin 2
unset for [ii=3:6] label ii
plot 'freq_response_wfs_X0.00_Y0.00_nls64.txt' u ($1/1000):(db($2)-16.675+30) w l ls 1 lw 3,\
     'freq_response_wfs_X0.75_Y0.00_nls64.txt' u ($1/1000):(db($2)-17.228) w l ls 2 lw 3,\
     'freq_response_wfs_X0.00_Y0.75_nls64.txt' u ($1/1000):(db($2)-19.582-30) w l ls 3 lw 3
unset multiplot

# vim: set textwidth=200:
