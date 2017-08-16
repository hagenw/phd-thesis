#!/usr/bin/gnuplot
#
# FIGURE 3.1: Amplitudes of sources synthesized via WFS minus the amplitudes of
# corresponding real sources dependent on the listener’s position along the
# y-axis. A source is synthesized correctly if its amplitude deviation is 0 dB.
# An infinite linear secondary source distribution located on the x-axis was
# used, indicated by the black dot. A comparison between 2D and 2.5D synthesis
# is shown, with the reference point at x_ref = (0, -2, 0) m for the 2.5D case.
# The used driving functions are given within the figure. Parameters: f = 1 kHz.
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
# redefine red line to use dashed line
set style line 6 dt 3 lc rgb '#E31A1C'

set terminal epslatex size 10.7cm,5cm color colortext @small
set output 'fig3_01.tex';

unset key
set xrange [-5.5:0.5]
set yrange [-7:10]
set tics scale 0.75 out nomirror
set xtics 1 offset 0,0.5
set ytics 3 offset 0.5,0
set xlabel '$y$ / m' offset 0,1
set ylabel 'amplitude deviation / dB' offset 1.5,0

set multiplot layout 1,2
set label 1 '2D'                   at -2.5,9.5 center front
set label 2 '\ft (2.59)'           at -4.5,4.2  center front tc ls 1
set label 3 '\ft (2.61)'           at -4.5,5.7  center front tc ls 2
set label 4 '\ft (2.66)'           at  0.7,-1.1 center front tc ls 4
set label 5 '\ft (2.54)'           at -3.5,-1.2 center front tc ls 6
set label 6 '\ft point source'     at  0.2,5.5  right  front tc ls 2
set label 7 '\ft line source'      at  0.2,4.0  right  front tc ls 4
set label 8 '\ft plane wave'       at  0.2,2.5  right  front tc ls 6

set lmargin 4.5
set rmargin 1
plot 'amplitudes_2D.txt'  u 1:($11-$2) w l ls 1 lw 3,\
     ''                   u 1:($6-$2)  w l ls 2 lw 3,\
     ''                   u 1:($7-$3)  w l ls 4 lw 3,\
     ''                   u 1:($8-$4)  w l ls 6 lw 3,\
     '<echo "0 0"'                     w p pt 7 ps 1.5 lc rgb 'black'
set border 1
unset ylabel
unset label 6
unset label 7
unset label 8
set ytics scale 0
set format y ''
set label 1 '2.5D'
set label 2 '\ft (2.60)'           at -4.5,0.4 center front tc ls 1
set label 3 '\ft (2.62)'           at -4.5,1.9 center front tc ls 2
set label 4 '\ft (2.67)'           at  0.9,5   center front tc ls 4
set label 5 '\ft (2.55)'           at -3,-3.5  center front tc ls 6
set label 6 '\ft moving listener'  at -6,9.5   center front tc ls 101
set lmargin 2
set rmargin 3.5
plot 'amplitudes_25D.txt' u 1:($11-$2) w l ls 1 lw 3,\
     ''                   u 1:($6-$2)  w l ls 2 lw 3,\
     ''                   u 1:($7-$3)  w l ls 4 lw 3,\
     ''                   u 1:($8-$4)  w l ls 6 lw 3,\
     '<echo "0 0"'                     w p pt 7 ps 1.5 lc rgb 'black'
unset multiplot

call 'plot.plt' 'fig3_01'
