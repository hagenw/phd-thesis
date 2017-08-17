#!/usr/bin/gnuplot
#
# FIGURE 5.10: Average results with confidence intervals for the perceived
# coloration. Dark colors show results for the central listening position,
# lighter colors for the off-center position.
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
load 'paired.pal'

set terminal epslatex size 15.94cm,7cm color colortext @small
set output 'fig5_10.tex'

unset key

set xrange [-0.5:11.5]
set yrange [-1:1]

set ylabel 'perceived coloration' offset 6,0
set xlabel 'system'

set lmargin 7
set rmargin 0
set bmargin 4

# offset to the real x-value
of = 0.1

set multiplot layout 1,2

set xtics rotate by -45
set format y ''
set xtics ('ref' 0,'stereo' 1,'$0.3$\,cm' 2,'$0.5$\,cm' 3,'$1$\,cm' 4,'$2$\,cm' 5, '$4$\,cm' 6,'$8$\,cm' 7,'$17$\,cm' 8,'$34$\,cm' 9,'$67$\,cm' 10,'low' 11)
set ytics ('\ft\shortstack{no \\difference}' -1,0.5 1,0 0,-0.5 1,'\ft\shortstack{very \\different}' 1)

set label 1 '\ft \acs{WFS}' at 7,-0.9 front center tc ls 101
set label 2 '\ft noise'         at 4.5,0.9 center front tc ls 2
set label 3 '\ft $(0,0,0)$\,m'  at 4.5,0.75 center front tc ls 2
set label 4 '\ft $(-1,0,0)$\,m' at 4.5,0.6 center front tc ls 1
plot 'wfs_coloration.txt' i 17 u ($1-of):(-1*$3):4 w yerrorbars ls 1 pt 7 lw 1,\
     ''                   i 16 u ($1-of):(-1*$3):4 w yerrorbars ls 1 pt 5 lw 1,\
     ''                   i 15 u ($1-of):(-1*$3):4 w yerrorbars ls 1 pt 6 lw 1,\
     ''                   i 8  u ($1+of):(-1*$3):4 w yerrorbars ls 2 pt 7 lw 1,\
     ''                   i 7  u ($1+of):(-1*$3):4 w yerrorbars ls 2 pt 5 lw 1,\
     ''                   i 6  u ($1+of):(-1*$3):4 w yerrorbars ls 2 pt 6 lw 1

load 'xborder.cfg'
set ytics ('' -1,0.5 1,0 0,-0.5 1,'' 1)
set xlabel offset 0,1.48
set lmargin 2
set rmargin 5
set label 2 '\ft speech'  tc ls 6
set label 3 tc ls 6
set label 4 tc ls 5
plot 'wfs_coloration.txt' i 11 u ($1-of):(-1*$3):4 w yerrorbars ls 5 pt 7 lw 1,\
     ''                   i 10 u ($1-of):(-1*$3):4 w yerrorbars ls 5 pt 5 lw 1,\
     ''                   i 9  u ($1-of):(-1*$3):4 w yerrorbars ls 5 pt 6 lw 1,\
     ''                   i 2  u ($1+of):(-1*$3):4 w yerrorbars ls 6 pt 7 lw 1,\
     ''                   i 1  u ($1+of):(-1*$3):4 w yerrorbars ls 6 pt 5 lw 1,\
     ''                   i 0  u ($1+of):(-1*$3):4 w yerrorbars ls 6 pt 6 lw 1

unset multiplot

call 'plot.plt' 'fig5_10'

# vim: set textwidth=300:
