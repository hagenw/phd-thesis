#!/usr/bin/gnuplot
#
# FIGURE 5.5: Distributions of the directions of the auditory event as rated by
# the listeners at the position (-1, -0.75, 0) m for the loudspeaker array with
# 14 loudspeakers. The results for a synthesized point source for WFS and
# NFC-HOA for different orders M are shown. For WFS only the results for the
# first 9 listeners were analyzed to have an equal number of answers as in the
# case for NFC-HOA.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'border.cfg'
load 'grid.cfg'
set grid xtics ytics mxtics
load 'paired.pal'

set terminal epslatex size 10.3cm,4.5cm color colortext @small
set output 'fig5_05.tex'

unset key

# --- histogram settings
n=50 #number of intervals
max=100. #max value
min=-100. #min value
width=(max-min)/n #interval width
#function used to map a value to the intervals
hist(x,width)=width*floor(x/width)+width/2.0
set boxwidth width*0.9
set style fill solid 0.5 #fillstyle

set xrange [min:max]
set yrange [0:22]
set xlabel '$\phi_\text{auditory event}$' offset 0,0.5
set ylabel 'number of occurences' offset 1,0
set format x '$%g\degree$'
set xtics 90
set mxtics 2

set lmargin 3
set rmargin 0

set multiplot
set size 0.325,1
set origin 0.05,0
set label 1 '\ft \acs{WFS}' at 96,18.5 right front
plot 'wfs_ps_nls14_X-1.00_Y-0.75.txt' u (hist($1,width)):(1.0) smooth freq w boxes ls 1
set origin 0.374,0
set lmargin 1.5
set rmargin 1.5
load 'xborder.cfg'
set format x '$%g\degree$'
set label 1 '\ft \acs{NFC-HOA}'
set label 2 '\ft $M=28$' at 96,16 right front
set label 3 '\ft listener at $(-1,-0.75,0)$\,m' at 0,24 center front
plot 'nfchoa_ps_nls14_order28_X-1.00_Y-0.75.txt' u (hist($1,width)):(1.0) smooth freq w boxes ls 1
set origin 0.698,0
set lmargin 0
set rmargin 3
set label 2 '\ft $M=7$'
unset label 3
set label 4 '\tiny first distribution' at -50,6 center front tc ls 101
set arrow from -50,5 to -20,3.4 nohead front ls 101
set label 5 '\tiny second distribution' at 70,11 center front tc ls 101
set arrow from 70,10 to 42,6.4 nohead front ls 101
plot 'nfchoa_ps_nls14_order7_X-1.00_Y-0.75.txt' i 0 u (hist($1,width)):(1.0) smooth freq w boxes ls 5,\
     ''                                         i 1 u (hist($1,width)):(1.0) smooth freq w boxes ls 1
unset multiplot

call 'plot.plt' 'fig5_05'
