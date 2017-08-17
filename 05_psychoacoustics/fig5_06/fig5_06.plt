#!/usr/bin/gnuplot
#
# FIGURE 5.6: Average results with confi- dence intervals for the following
# question: Is there a timbral difference between the reference and the
# stimulus?  Whereby the reference and the other stimuli were presented by the
# same system each time, leading to the measurement of intra-system coloration.
# The average is calculated over all subjects and the different positions of the
# sources. All loudspeakers, including real, stereo, and WFS, were simulated via
# binaural synthesis. The results are replotted from H.  Wittek. “Perceptual
# differences between wavefield synthesis and stereophony”.  PhD thesis.
# University of Surrey, 2007, Fig. 8.6.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'border.cfg'
load 'grid.cfg'
load 'paired.pal'

set terminal epslatex size 10cm,7cm color colortext @small
set output 'fig5_06.tex'

unset key

set xrange [0.5:6.5]
set yrange [0:4]

set ylabel '\shortstack{perceived \\intra-system coloration}' offset 12,0
set xlabel 'system'

set lmargin 8

set format y ''
set xtics ('real' 1,'stereo' 2,'$0.03$\,m' 3,'$0.12$\,m' 4,'$0.24$\,m' 5,'$0.48$\,m' 6)
set ytics ('\ft\shortstack{no \\difference}' 0,'' 1,'' 2,'' 3,'\ft\shortstack{extremely \\different}' 4)

set label '\acs{WFS}'  at 4.5,0.2 center front tc ls 101
set label '\ft noise' at 3.5,3.5 center front tc ls 2 
plot 'wittek.txt' i 0 u 2:3:4 w yerrorbars ls 2 ps 2 pt 6 lw 1,\
     ''           i 0 u 2:3   w points     ps 1.9 lc "white" pt 7 lw 1,\
     ''           i 1 u 2:3:4 w yerrorbars ls 2 ps 2 pt 5 lw 1,\
     ''           i 2 u 2:3:4 w yerrorbars ls 2 ps 2 pt 7 lw 1

call 'plot.plt' 'fig5_06'
