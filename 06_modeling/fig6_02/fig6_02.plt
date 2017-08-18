#!/usr/bin/gnuplot
#
# FIGURE 6.2: Distributions of the auditory event's directions as predicted by
# the binaural model for the listening position (-0.75, -0.75, 0) m and the
# circular secondary source distribution with 14 sources. The results for a
# synthesized point source for WFS and NFC-HOA up to different orders M are
# shown.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'border.cfg'
load 'grid.cfg'
set grid xtics ytics mxtics
load 'paired.pal'

set terminal epslatex size 10.3cm,4.5cm color colortext @small
set output 'fig6_02.tex'

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
set yrange [0:57]
set xlabel '$\phi_\text{auditory event}$' offset 0,0.5
set ylabel 'number of occurence' offset 1,0
set format x '$%g\degree$'
set xtics 90
set mxtics 2

set lmargin 3
set rmargin 0

set multiplot
set size 0.325,1
set origin 0.05,0
set label 1 '\ft \acs{WFS}' at 96,47 right front
plot 'wfs_ps_nls14_X-0.75_Y-0.75.txt' u (hist($1,width)):(1.0) smooth freq w boxes ls 1
set origin 0.374,0
set lmargin 1.5
set rmargin 1.5
load 'xborder.cfg'
set format x '$%g\degree$'
set label 1 '\ft \acs{NFC-HOA}'
set label 2 '\ft $M=28$' at 96,41 right front
set label 3 '\ft listener at $(-0.75,-0.75,0)$\,m' at 0,62 center front
plot 'nfchoa_ps_nls14_order28_X-0.75_Y-0.75.txt' u (hist($1,width)):(1.0) smooth freq w boxes ls 1
set origin 0.698,0
set lmargin 0
set rmargin 3
set label 2 '\ft $M=7$'
unset label 3
set label 4 '\tiny first distribution' at -50,23 center front tc ls 101
set arrow from -50,20 to -15,14 nohead front ls 101
set label 5 '\tiny second distribution' at 70,13 center front tc ls 101
set arrow from 70,10 to 42,6.4 nohead front ls 101
plot 'nfchoa_ps_nls14_order7_X-0.75_Y-0.75.txt' i 0 u (hist($1,width)):(1.0) smooth freq w boxes ls 5,\
     ''                                         i 1 u (hist($1,width)):(1.0) smooth freq w boxes ls 1
unset multiplot

call 'plot.plt' 'fig6_02'
