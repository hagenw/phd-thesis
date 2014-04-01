#!/usr/bin/gnuplot
#
# <+DESCRIPTION+>
#
# AUTHOR: Hagen Wierstorf
# gnuplot 4.6 patchlevel 3

reset
set loadpath '../../gnuplot'

set terminal epslatex size 10cm,10cm color colortext
set output 'dietz2011.tex'

load 'noborder.cfg'
load 'moreland.pal'
# lines with different grey
set style line 11 lc rgb '#bfbfbf' lt 1 lw 2
set style line 12 lc rgb '#808080' lt 1 lw 2
set style line 13 lc rgb '#404040' lt 1 lw 2

unset key

set yrange [-10:190]
set xrange [0:100]

set tmargin 0
set bmargin 0
set lmargin 0
set rmargin 0

set style rectangle fs empty

monoralpart(y) = sprintf('\
    set object rectangle center 25,%f size 40,15 front;\
    set object rectangle center 75,%f size 40,15 front',y,y)
binauralpart(y) = sprintf('\
    set object rectangle center 50,%f size 90,15 front',y)
arrow(x,y,ls,lw) = sprintf('\
    set arrow from %f,%f to %f,%f nohead back ls %i lw %i',\
    x,y-5,x,y+5,ls,lw)
monoralarrow1(x,y,lw) = sprintf('\
    eval arrow(%f,%f,2,%i);\
    eval arrow(%f,%f,7,%i)',\
    x,y,lw,x+50,y,lw)
monoralarrow2(x,y,lw) = sprintf('\
    eval arrow(%f,%f,1,%i);\
    eval arrow(%f,%f,3,%i);\
    eval arrow(%f,%f,8,%i);\
    eval arrow(%f,%f,6,%i)',\
    x-0.57143,y,lw,\
    x+0.57143,y,lw,\
    x+50-0.57143,y,lw,\
    x+50.57143,y,lw)
binauralarrow1(x,y,lw) = sprintf('\
    eval arrow(%f,%f,12,%i)',\
    x,y,lw)
binauralarrow2(x,y,lw) = sprintf('\
    eval arrow(%f,%f,11,%i);\
    eval arrow(%f,%f,13,%i)',\
    x-0.75,y,lw,x+0.75,y,lw)
binauralarrow3(x,y,lw) = sprintf('\
    eval arrow(%f,%f,11,%i);\
    eval arrow(%f,%f,12,%i);\
    eval arrow(%f,%f,13,%i)',\
    x-1,y,lw,x,y,lw,x+1,y,lw)


set multiplot


eval monoralarrow1(25,0,69)
eval monoralarrow1(25,5,69)
set label '$l(t)$' at 25,2.5 center front tc rgb 'white'
set label '$r(t)$' at 75,2.5 center front tc rgb 'white'
# -- middle ear -----------------------------------------------------------------------------------
set label '\ft middle ear' at 0,17.5 right front tc ls 12                                           #
eval monoralpart(17.5)                                                                              #
# -- middle ear -----------------------------------------------------------------------------------
eval monoralarrow1(25,30,69)
# -- gammatone filterbank -------------------------------------------------------------------------
set label '\ft \shortstack{gammatone \\ filterbank}' at 0,42.5 right front tc ls 12                 #
eval monoralpart(42.5)                                                                              #
# -- gammatone filterbank -------------------------------------------------------------------------
do for [fc=1:12] { eval monoralarrow1(5+3.0769*fc,55,3) }
# -- compression and haircells --------------------------------------------------------------------
set label '\ft \shortstack{inner haircell \\ and compression}' at 0,67.5 right front tc ls 12       #
eval monoralpart(67.5)                                                                              #
# -- compression and haircells --------------------------------------------------------------------
do for [fc=1:12] { eval monoralarrow1(5+3.0769*fc,80,3) }
# -- modulation filterbank ------------------------------------------------------------------------
set label '\ft \shortstack{modulation \\ filterbank}' at 0,92.5 right front tc ls 12                #
eval monoralpart(92.5)                                                                              #
# -- modulation filterbank ------------------------------------------------------------------------
do for [fc=1:12] { eval monoralarrow2(5+3.0769*fc,105,1.5) }
# -- binaural processor ---------------------------------------------------------------------------
set label '\ft \shortstack{binaural \\ processor}' at 0,117.5 right front tc ls 12                  #
set label '\ac{ITD}' at 20,117.5 center front tc ls 12                                              #
set label '\ac{ILD}' at 50,117.5 center front tc ls 12                                              #
set label '\acs{IVS}' at 80,117.5 center front tc ls 12                                             #
eval binauralpart(117.5)                                                                            #
# -- binaural processor ---------------------------------------------------------------------------
do for [fc=1:12] { eval binauralarrow3(5+6.9231*fc,130,2) }
# -- unwrap ITD -----------------------------------------------------------------------------------
set label '\ft \ac{ITD}-$\phi$-mapping' at 0,142.5 right front tc ls 12                             #
set label '\ft unwrap \ac{ITD}' at 20,142.5 center front tc ls 12                                   #
set label '\ft \acs{IVS} mask' at 80,142.5 center front tc ls 12                                    #
eval binauralpart(142.5)                                                                            #
# -- unwrap ITD -----------------------------------------------------------------------------------
do for [fc=1:12] { eval binauralarrow1(5+6.9231*fc,155,6) }
# -- cross-frequency azimuth ----------------------------------------------------------------------
set label '\ft \shortstack{cross-frequency \\ processing}' at 0,167.5 right front tc ls 12          #
set label '\ft equal weighting' at 20,167.5 center front tc ls 12                                   #
set label '\ft outlier removal' at 80,167.5 center front tc ls 12                                   #
eval binauralpart(167.5)                                                                            #
# -- cross-frequency azimuth ----------------------------------------------------------------------
eval arrow(50,180,12,69)
eval arrow(50,185,12,69)
set label '$\phi$' at 50,182.5 center front tc rgb 'white'

plot 1/0

unset object
unset arrow
unset label

# plot middle ear
set size 0.4,0.08
#set origin 0.05,0.17
set origin 0.05,0.1
set yrange [-90:-70]
set xrange [195:1400]
#set xrange [20:6000]
set logscale x
plot 'middleear.txt' u 1:2 w l ls 12
set origin 0.55,0.1
replot

# plot gammatone filterbank
set origin 0.05,0.225
set yrange [-15:5]
#set xrange [180:6000]
set xrange [195:1400]
#set xrange [20:6000]
set logscale x
plot for [ii=2:13] 'gammatonefilterbank.txt' u 1:ii w l ls 12
set origin 0.55,0.225
replot

# plot innerhaircell processing
set origin 0.05,0.35
set xrange [195:1400]
set yrange [-90:-70]
set logscale x
plot 'innerhaircell.txt' u 1:2 w l ls 12
set origin 0.55,0.35
replot

# plot modulationfilterbank
set origin 0.05,0.475
set yrange [-15:5]
set xrange [20:1400]
set logscale x
#set object circle center 808.22,-12.5 size 1.01 fc ls 11 fs solid 
set object circle center 289.34,-7 size 1.01 fc ls 11 fs solid 
set object circle center 414.19,-7 size 1.01 fc ls 11 fs solid 
set object circle center 348.40,-7 size 1.01 fc ls 11 fs solid
set object circle center 761.40,-7 size 1.01 fc ls 11 fs solid 
set object circle center 874.27,-7 size 1.01 fc ls 11 fs solid 
set object circle center 1000.0,-7 size 1.01 fc ls 11 fs solid 
plot 'modulationfilterbank.txt' u 1:7 w l ls 11, \
     ''                         u 1:26 w l ls 13
set origin 0.55,0.475
replot
unset object

# plot compression
set size 0.04,0.04
set origin 0.08,0.355
comp(x) = x**.4
set xrange [-0.02:1]
set yrange [-0.0:1]
unset logscale
set size ratio -1
set label '\tiny $x^{0.4}$' at 0.15,0.3 left front tc ls 12
set object rectangle center 0.25,0.5 size 2,2 front
set samples 2000
plot comp(x) w l ls 12
set origin 0.58,0.355
replot
unset label
unset object

# plot half-wave rectification
set size ratio 0
set origin 0.155,0.355
hwr(x) = sin(x)>0 ? sin(x) : 0
set xrange [-0.3:6*pi]
set yrange [-1.2:1.2]
set object rectangle center 3*pi,0 size 12*pi,3
set label '$+$' at -8,0 center front
set label '$+$' at 8+6*pi-0.3,0 center front
set samples 2000
plot hwr(x) w l ls 12
set origin 0.655,0.355
replot

# plot unwrap ITD
set origin 0.155,0.74
set size 0.1,0.05
# TODO

# plot ITD lookup table
unset object
unset label
set origin 0.45,0.74
set ylabel '\tiny $\phi$' offset 2,0 tc ls 12
set xlabel '\tiny \ac{ITD}' offset 0,1.6 tc ls 12
set yrange [-90:90]
set xrange [-0.9:0.9]
load 'greens.pal'
set palette gray
set cbrange [-2:11]
unset colorbox
plot for [n=11:0:-1] 'lookup.txt' i n every 5 u 2:1:(n) w lines lt 1 lw 1 lc palette


# plot IVS mask
# TODO

unset multiplot

# vim:set textwidth=120:
