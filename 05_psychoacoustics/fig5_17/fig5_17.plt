#!/usr/bin/gnuplot
#
# FIGURE 5.17: Mean and standard error for the rating of the attribute pair few
# artifacts vs. many artifacts plotted over the condition. The mean is
# calculated over all subjects, source materials and the different listener
# positions.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'border.cfg'
load 'grid.cfg'
set grid mytics
load 'rdbu.pal'
set style line 9 lc rgb '#000000' lt 1 lw 1

set terminal epslatex size 10.5cm,5cm color colortext @small
set output 'fig5_17.tex'

unset key
set xtics rotate by -45
set yrange [-1:1]

set multiplot layout 1,2

set ytics ('many' 1 0,0.5 1,'' 0 0,-0.5 1,'few' -1 0)
set xrange [-0.5:5.5]

set xtics ('ref' 0,'$0.3$' 1,'$0.75$' 2,'$1.8$' 3,'$4$' 4,'$10$' 5)
set ytics scale 0.75,0.5
set xlabel 'array length / m' offset 0,0.5
set ylabel 'artifacts' offset 2,0

# draw a line through y = 0
#set xzeroaxis ls 11

set lmargin 6
set rmargin 1
set bmargin 4
set tmargin 1
# Plot mean with variance (std^2) as boxes with yerrorbar
plot 'fs_artifacts.txt' i 0 u 0:1:(0.7) w p ls 9 pt 7 ps 1.5, \
     ''                 i 0 u 0:1:($2/sqrt(6)) w yerrorbars ls 9


set xrange [-0.5:8.5]
set ytics ('right' 1 0,0.5 1,'' 0 0,-0.5 1,'left' -1 0)
set xtics ('ref' 0,'$0.3$' 1,'$0.75$' 2,'$1.8$' 3,'$4$' 4,'$0.3$' 5,'$0.75$' 6,'$1.8$' 7,'$10$' 8)
set ylabel 'position' offset 4,0
set xlabel offset 0,0.5
set label '\ft $R=4$\,m'  at 2.2,-0.28 center front rotate by 30 tc ls 8
set label '\ft $R=10$\,m' at 6.3,0.14 center front rotate by 10 tc ls 2
plot 'fs_position.txt' i 0 u 0:1:(0.7)        w p ls 9 pt 7 ps 1.5, \
     ''                i 0 u 0:1:($2/sqrt(6))      w yerrorbars ls 9, \
     ''                i 1 u ($0+1):1:(0.7)   w p ls 8 pt 7 ps 1.5, \
     ''                i 1 u ($0+1):1:($2/sqrt(6)) w yerrorbars ls 8, \
     ''                i 2 u ($0+5):1:(0.7)   w p ls 2 pt 7 ps 1.5, \
     ''                i 2 u ($0+5):1:($2/sqrt(6)) w yerrorbars ls 2

unset multiplot

call 'plot.plt' 'fig5_17'
