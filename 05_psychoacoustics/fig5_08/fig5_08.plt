#!/usr/bin/gnuplot
#
# FIGURE 5.8: Amplitude spectra for the varying secondary source distribution
# conditions.  The spectra were simulated for the place of the left ear of the
# listener. The left graph shows the spectra for the central listening position,
# the right for the off-center position. The distance between the secondary
# sources is given for all WFS spectra. The spectra are shifted in absolute
# magnitude in order to meaningfully display them. Parameters:
# x_s = (0, 2.5,0) m, x_ref = (0, 0, 0) m, circular secondary source
# distribution with a diameter of 3 m.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'grid.cfg'
set grid xtics ytics mxtics
load 'blgrrd.pal'

set terminal epslatex size 16.4cm,10cm color colortext @small
set output 'fig5_08.tex';

unset key

set bmargin 4
set tmargin 2

set logscale x
set xrange [0.1:20]
set yrange [-100:320]
unset colorbox

db(x) = 20*log10(x)

set multiplot layout 1,2
load 'xyborder.cfg'
set xtics add ('$100$' 0.1,'$400$' 0.4,'$1$k' 1,'$4$k' 4,'$10$k' 10)
set xlabel 'frequency / Hz'
set ytics 40
set ylabel 'sound pressure / dB' offset 1,0
set lmargin 6
set rmargin 0
set label 1  '\ft virtual microphone at $(-0.1,0,0)$\,m' at 1.4,340 center tc ls 101
set label 2  '\ft \acs{WFS}'  at 1.1,120 left front tc ls 101
set label 3  '\ft $0.3$\,cm' at 0.11,310 left front tc ls 10
set label 4  '\ft $0.5$\,cm' at 0.11,268 left front tc ls 9
set label 5  '\ft $1$\,cm'   at 0.11,230 left front tc ls 8
set label 6  '\ft $2$\,cm'   at 0.11,190 left front tc ls 7
set label 7  '\ft $4$\,cm'   at 0.11,153 left front tc ls 6
set label 8  '\ft $8$\,cm'   at 0.11,111  left front tc ls 5
set label 9  '\ft $17$\,cm'  at 0.11,74  left front tc ls 4
set label 10 '\ft $34$\,cm'  at 0.11,30   left front tc ls 3
set label 11 '\ft $67$\,cm'  at 0.11,-12 left front tc ls 2
set label 12 '\ft stereo'    at 0.11,-53 left front tc ls 23
plot for [ii=3:11] 'coloration_wfs_freq_response_center.txt' u ($1/1000):(db(column(ii))+10+(ii-2)*40) w l ls ii-2,\
                   ''                                        u ($1/1000):(db($2)+5) w l ls 23

load 'xborder.cfg'
unset ylabel
set lmargin 2
set rmargin 4
set label 1  '\ft virtual microphone at $(-1.1,0,0)$\,m'
set label 3  at 0.11,310
set label 4  at 0.11,269
set label 5  at 0.11,230
set label 6  at 0.11,190
set label 7  at 0.11,150
set label 8  at 0.11,113
set label 9  at 0.11,69
set label 10 at 0.11,27
set label 11 at 0.11,-12
set label 12 at 0.11,-53
plot for [ii=3:11] 'coloration_wfs_freq_response_off-center.txt' u ($1/1000):(db(column(ii))+10+(ii-2)*40) w l ls ii-2,\
                   ''                                            u ($1/1000):(db($2)+10) w l ls 23
unset multiplot

call 'plot.plt' 'fig5_08'

# vim: set textwidth=200:
