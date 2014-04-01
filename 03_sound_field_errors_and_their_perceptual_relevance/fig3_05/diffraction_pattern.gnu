#!/usr/bin/gnuplot
reset
set macros
set loadpath '../../gnuplot'

set t epslatex size 5cm,2.5cm color colortext
set output 'diffraction_pattern.tex'

# create data
set table 'sinc.txt'
set xrange [-2*pi:2*pi]
set yrange [-1:1]
f(y) = (sin(y)/y)**2
plot f(x)
unset table

load 'border.cfg'
load 'grid.cfg'
load 'paired.pal'

unset key
set border 0
unset tics

set rmargin 1
set lmargin 1
set bmargin 1
set tmargin 1

set xrange [-25:10]
set yrange [-2*pi:3*pi]
set size ratio -1

set style line 201 lc rgb 'black' lt 1 lw 1

set arrow from -22,-2 to -22,2    nohead back ls 101 lw 3

set arrow from -22, 0    to   0,-pi   nohead front ls 2 lw 3
set arrow from -22, 2    to   0, 2-pi nohead front ls 1 lw 3
set arrow from -22,-2    to   0,-2-pi nohead front ls 1 lw 3

set arrow from -24,-2    to -24, 2    heads size 0.5,90 front ls 201
set label '\ft $L$' at -25.5,0 center
set arrow from -22, 2    to -22+0.55978,2-0.079937 heads size 0.5,90 front ls 201
set label '\ft $\lambda$' at -21,3 center
set arrow from 1.5,-pi to 1.5,pi heads size 0.5,90 front ls 201
set label '\ft $\Delta_\text{s}$' at 3.5,0 center
set arrow from -22,2.5*pi to 0,2.5*pi heads size 0.5,90 front ls 201
set label '\ft $|y_\text{s}-y_0|$' at -11,3*pi center
set object circle at -22,0 size 6 arc [-8:0]
set label '\ft $\alpha$' at -15,0 center

plot 'sinc.txt' u ($2*7+3):1 w l ls 2 lw 3
