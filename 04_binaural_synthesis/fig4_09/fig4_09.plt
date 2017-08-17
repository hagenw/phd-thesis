#!/usr/bin/gnuplot
#
# FIGURE 4.9: Differences in magnitude between real loudspeaker setups and their
# binaural simulation. A single loudspeaker (mono) or a circular loudspeaker
# array driven by WFS was applied to synthesize a point source in the front,
# left, right, or back of the listener.
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
load 'rdbu.pal'

set terminal epslatex size 10.42cm,8cm color colortext @small
set output 'fig4_09.tex'

unset key 

set logscale x

set xrange [100:20000]
set yrange [-10:15]

set multiplot
# 1
set size 0.31933333,0.35
set origin 0.05,0.65
set lmargin 4
set rmargin 0
#set xtics (100,'$1$k' 1000,'$10$k' 10000) offset 0,1
set format x ''
set xtics add ('$100$' 100)
set xtics add ('$1$k' 1000)
set xtics add ('$10$k' 10000)
set mxtics 5
set xtics offset 0,0.5
load 'xyborder.cfg'
set label 1 '\ft left' at 200,12 front left
unset xlabel
unset ylabel
plot 'pinta_recordings_2.txt' u 1:3 w l ls 1 lw 2, \
     ''                       u 1:4 w l ls 2 lw 2, \
     ''                       u 1:5 w l ls 3 lw 2, \
     ''                       u 1:2 w l ls 8 lw 2
# 2
set lmargin 3
set rmargin 1
set origin 0.36933333,0.65
load 'xborder.cfg'
set label 1 '\ft right'
plot 'pinta_recordings_4.txt' u 1:3 w l ls 1 lw 2, \
     ''                       u 1:4 w l ls 2 lw 2, \
     ''                       u 1:5 w l ls 3 lw 2, \
     ''                       u 1:2 w l ls 8 lw 2
# 3
set lmargin 2
set rmargin 2
set origin 0.69066667,0.65
set label 1 '\ft back'
plot 'pinta_recordings_3.txt' u 1:3 w l ls 1 lw 2, \
     ''                       u 1:4 w l ls 2 lw 2, \
     ''                       u 1:5 w l ls 3 lw 2, \
     ''                       u 1:2 w l ls 8 lw 2
# 4
set size 0.96,0.7
set origin 0.05,0
set lmargin 4
set rmargin 2
load 'xyborder.cfg'
set xtics autofreq
set xtics add ('$100$' 100,'$200$' 200,'$400$' 400,'$1$k' 1000,'$2$k' 2000,'$4$k' 4000,'$10$k' 10000,'$20$k' 20000)
set format x '$%g$'
set xtics offset 0,0
set mxtics 10
set xlabel 'center frequencies / Hz'
set ylabel '$\Delta$magnitude / dB' offset 1,0
set label 1 '\ft front'
set label '\ft mono'                        at 800,12 left front tc ls 8
set label '\ft WFS,  4 active loudspeakers' at 800,10 left front tc ls 1
set label '\ft WFS,  9 active loudspeakers' at 800, 8 left front tc ls 2
set label '\ft WFS, 17 active loudspeakers' at 800, 6 left front tc ls 3
set label '\ft real loudspeaker $-$ binaural simulation' at 200,-8 front
plot 'pinta_recordings_1.txt' u 1:3 t '\ft WFS 14 speakers' w l ls 1 lw 3, \
     ''                     u 1:4 t '\ft WFS 28 speakers' w l ls 2 lw 3, \
     ''                     u 1:5 t '\ft WFS 56 speakers' w l ls 3 lw 3, \
     ''                     u 1:2 w l ls 8 lw 3
unset multiplot

call 'plot.plt' 'fig4_09'
