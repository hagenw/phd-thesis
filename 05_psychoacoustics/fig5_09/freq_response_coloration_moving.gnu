#!/usr/bin/gnuplot
reset
set macros
set loadpath '../../gnuplot'

set t epslatex size 7.5cm,10cm color colortext
set output 'freq_response_coloration_moving.tex';

load 'grid.cfg'
set grid xtics ytics mxtics
load 'blgrrd.pal'

unset key

set bmargin 4
set tmargin 1

set logscale x
set xrange [0.1:20]
set yrange [-40:400]
unset colorbox

set xtics add ('$100$' 0.1,'$400$' 0.4,'$1$k' 1,'$4$k' 4,'$10$k' 10)
db(x) = 20*log10(x)

load 'xyborder.cfg'
set xtics nomirror out scale 0.75,0.001 # add mxtics
set ytics 40
set xlabel 'frequency / Hz'
set ylabel 'sound pressure / dB' offset 1,0
set lmargin 3
set rmargin 0
set label 1  '\ft loudspeaker spacing $17$\,cm' at 1.4,420 center front tc ls 101
set label 2  '\ft \ac{WFS}'             at 1,200 center front tc ls 101
set label 3  '\ft $(-0.1,0,0)$\,m'      at 0.11, -7 front tc ls 12
set label 4  '\ft $(-0.35,0,0)$\,m'     at 0.11, 30 front tc ls 13
set label 5  '\ft $(-0.6,0,0)$\,m'      at 0.11, 68 front tc ls 14
set label 6  '\ft $(-0.85,0,0)$\,m'     at 0.11,114 front tc ls 15
set label 7  '\ft $(-1.1,0,0)$\,m'      at 0.11,149 front tc ls 16
set label 8  '\ft $(-1.35,0,0)$\,m'     at 0.11,188 front tc ls 17
set label 9  '\ft $(-0.35,-0.5,0)$\,m'  at 0.11,231 front tc ls 18
set label 10 '\ft $(-0.6,-0.5,0)$\,m'   at 0.11,274 front tc ls 19
set label 11 '\ft $(-0.85,-0.5,0)$\,m'  at 0.11,314 front tc ls 20
set label 12 '\ft $(-1.1,-0.5,0)$\,m'   at 0.11,354 front tc ls 21
set label 13 '\ft $(-1.35,-0.5,0)$\,m'  at 0.11,390 front tc ls 22
plot for [ii=2:12] 'coloration_wfs_freq_resp_moving.txt' u ($1/1000):(db(column(ii))-35+ii*40):ii w l ls ii+10

# vim: set textwidth=200:
