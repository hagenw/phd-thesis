#!/usr/bin/gnuplot
#
# Coloration results from Wittek (2007)
#
# AUTHOR: Hagen Wierstorf
# gnuplot 4.6 patchlevel 0

reset
set macros
set loadpath '../../gnuplot'

set terminal epslatex size 10cm,7cm color colortext
set output 'wittek.tex'

load 'border.cfg'
load 'grid.cfg'
load 'paired.pal'

unset key

set xrange [0.5:6.5]
set yrange [0:4]

set ylabel '\shortstack{perceived \\intra-system coloration}' offset 12,0
set xlabel 'system'

set lmargin 8

set format y ''
set xtics ('real' 1,'stereo' 2,'$0.03$\,m' 3,'$0.12$\,m' 4,'$0.24$\,m' 5,'$0.48$\,m' 6)
set ytics ('\ft\shortstack{no \\difference}' 0,'' 1,'' 2,'' 3,'\ft\shortstack{extremely \\different}' 4)

set label '\ac{WFS}'  at 4.5,0.2 center front tc ls 101
set label '\ft noise' at 3.5,3.5 center front tc ls 2 
plot 'wittek.txt' i 0 u 2:3:4 w yerrorbars ls 2 ps 2 pt 6 lw 1,\
     ''           i 1 u 2:3:4 w yerrorbars ls 2 ps 2 pt 5 lw 1,\
     ''           i 2 u 2:3:4 w yerrorbars ls 2 ps 2 pt 7 lw 1
