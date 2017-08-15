#!/usr/bin/gnuplot
#
# FIGURE 2.3: Sound pressure in decibel for secondary source distributions with
# different dimensionality all driven by the same signals. The sound pressure is
# color coded, lighter color corresponds to lower pressure. In the 3D case a
# planar distribution of point sources is applied, in the 2.5D case a linear
# distribution of point sources, and in the 2D case a linear distribution of
# line sources.
#
# NOTE: this generates only parts of the plots that where later put together
# under inkscape in order to generate the published figure.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'noborder.cfg'
load 'blues.pal'

set terminal epslatex size 5cm,5cm color colortext @small

unset key
unset colorbox

set size ratio -1 
set lmargin 0
set rmargin 0
set tmargin 0
set bmargin 0

# 2D and 3D
set cbrange [-40:5]

set xrange [-2:0]
set yrange [-1.5:0.5]
set output '2d_3d_xy_1.tex'
plot '2d_3d_xy.dat' binary matrix u 1:2:(20*log10($3)) w image
call 'plot.plt' '2d_3d_xy_1'
set xrange [0:2]
set yrange [-1.5:0.5]
set output '2d_3d_xy_2.tex'
plot '2d_3d_xy.dat' binary matrix u 1:2:(20*log10($3)) w image
call 'plot.plt' '2d_3d_xy_2'

set xrange [-1.5:0.5]
set yrange [-1.5:0]
set output '2d_3d_yz_1.tex'
plot '2d_3d_yz.dat' binary matrix u 1:2:(20*log10($3)) w image
call 'plot.plt' '2d_3d_yz_1'
set xrange [-1.5:0.5]
set yrange [0:1.5]
set output '2d_3d_yz_2.tex'
plot '2d_3d_yz.dat' binary matrix u 1:2:(20*log10($3)) w image
call 'plot.plt' '2d_3d_yz_2'

# 2.5D
set cbrange [-40:-5]

set xrange [-2:0]
set yrange [-1.5:0.5]
set output '25d_xy_1.tex'
plot '25d_xy.dat' binary matrix u 1:2:(20*log10($3)) w image
call 'plot.plt' '25d_xy_1'
set xrange [0:2]
set yrange [-1.5:0.5]
set output '25d_xy_2.tex'
plot '25d_xy.dat' binary matrix u 1:2:(20*log10($3)) w image
call 'plot.plt' '25d_xy_2'

set xrange [-1.5:0.5]
set yrange [-1.5:0]
set output '25d_yz_1.tex'
plot '25d_yz.dat' binary matrix u 1:2:(20*log10($3)) w image
call 'plot.plt' '25d_yz_1'
set xrange [-1.5:0.5]
set yrange [0:1.5]
set output '25d_yz_2.tex'
plot '25d_yz.dat' binary matrix u 1:2:(20*log10($3)) w image
call 'plot.plt' '25d_yz_2'
