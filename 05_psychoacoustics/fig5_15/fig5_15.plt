#!/usr/bin/gnuplot
#
# FIGURE 5.15: Direction, amplitude and time of appearance of wave fronts for
# the 4 m loudspeaker array (left) and the 10 m array (right). The results are
# shown for different angles phi at a radius of 1 m and 4 m, respectively. The
# arrows are pointing towards the direction from which the wave fronts arrive.
# The time of appearance is given by the starting point of the arrow. The length
# and color of the arrow is proportional to the amplitude of the wave front in
# dB. The dark blue arrows indicate the desired wave fronts.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'border.cfg'
load 'blues.pal'
set style line 10 lc rgb '#000000' lt 1 lw 2

set terminal epslatex size 11.4cm,6cm color colortext @small
set output 'fig5_15.tex'

# Set the ratio in order to get the right aspect ratio for the arrows in the
# plot
set size ratio 2.0/3
unset key
unset colorbox
set cbrange [40:110]

set multiplot layout 1,2 rowsfirst

set lmargin 7
set rmargin 0
# --- Plot 1: L = 4m ---
xmin=-0.5; xmax=2.5
ymin=-0.019; ymax=0.011
set xrange[xmin:xmax]
set yrange[ymin:ymax]
set xtics('$0\degree$' 0,'$30\degree$' 1,'$60\degree$' 2)
set ytics('$-20$' -0.02,'$-15$' -0.015,'$-10$' -0.01,'$-5$' -0.005,0)

set xlabel 'listener angle $\phi$'
set ylabel '$t$ / ms'

#set label 'y =' at -2.2,-0.07
#set label '3' at -0.2,-0.07
#set label '4' at 1.8,-0.07
#set label '4' at 4.8,-0.07
#set label '4' at 9.8,-0.07
#set label '4' at 14.8,-0.07

# Factor to display x and y with equal length on the monitor for the vectors
# We have above chosen a ratio of 2/3 for the axis. For the x-axis we have a
# length of 1 for one listener position. For the y-axis we have a length of
# 0.03. The ratio_factor is now calculated by 2/3 = r * 1/0.03
r = 1.0/50
# Scaling factor (scale the overall length of the vectors)
# This value can be chosen abritrary and is only to fit the length of the arrows
# in the graph area.
sc = 1.0/250

# Draw legend for dB values
lx = -0.3
ly = -0.011
#set arrow 4 from lx,ly to lx,ly+30*sc*r ls 3
#set label 3 '$30$\,dB' at graph 0.07,0.3
# Little distance to make tic visible again
d=0.04
#set arrow 1 from xmin+d,0 to xmax-d nohead ls 5
# Lines to make boundaries between 0° and 30°, and 30° and 60°
set arrow 2 from 0.5,ymin to 0.5,ymax back nohead lc rgb '#d6d7d9' lt 0 lw 1
set arrow 3 from 1.5,ymin to 1.5,ymax back nohead lc rgb '#d6d7d9' lt 0 lw 1
set label 1 '\ft $R = 1$\,m' at graph 0.03,0.2
set label 2 '\ft $L = 4$\,m'   at graph 0.03,0.1
set style arrow 1 head filled lt 1 lw 1 lc palette
set style arrow 2 head filled lt 1 lw 1 lc rgb '#084594'
plot 'direction_L4_xs0_ys1_X0.0_Y2.0_dB.txt' i 0 every 2::3 u (0):2:($3*sc):($4*sc*r):5 with vectors as 1,\
     ''                                      i 1            u (0):2:($3*sc):($4*sc*r)   with vectors as 2,\
     'direction_L4_xs0_ys1_X0.5_Y1.9_dB.txt' i 0 every 2::3 u (1):2:($3*sc):($4*sc*r):5 with vectors as 1,\
     ''                                      i 1            u (1):2:($3*sc):($4*sc*r)   with vectors as 2,\
     'direction_L4_xs0_ys1_X0.9_Y1.5_dB.txt' i 0 every 2::3 u (2):2:($3*sc):($4*sc*r):5 with vectors as 1,\
     ''                                      i 1            u (2):2:($3*sc):($4*sc*r)   with vectors as 2

# --- Plot 2: L = 10m ---
set lmargin 2
set rmargin 5
load 'xborder.cfg'
unset ytics
set label 1 '\ft $R = 4$\,m' at graph 0.03,0.2
set label 2 '\ft $L = 10$\,m'  at graph 0.03,0.1
plot 'direction_L10_xs0_ys1_X0.0_Y5.0_dB.txt' i 0 every 2::3 u (0):2:($3*sc):($4*sc*r):5 with vectors as 1, \
     ''                                       i 1            u (0):2:($3*sc):($4*sc*r)   with vectors as 2, \
     'direction_L10_xs0_ys1_X2.0_Y4.5_dB.txt' i 0 every 2::3 u (1):2:($3*sc):($4*sc*r):5 with vectors as 1, \
     ''                                       i 1            u (1):2:($3*sc):($4*sc*r)   with vectors as 2, \
     'direction_L10_xs0_ys1_X3.5_Y3.0_dB.txt' i 0 every 2::3 u (2):2:($3*sc):($4*sc*r):5 with vectors as 1, \
     ''                                       i 1            u (2):2:($3*sc):($4*sc*r)   with vectors as 2

unset multiplot

call 'plot.plt' 'fig5_15'

# vim: set textwidth=300:
