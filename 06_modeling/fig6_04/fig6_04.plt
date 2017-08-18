#!/usr/bin/gnuplot
#
# FIGURE 6.4: ITD values over time for different frequencies as indicated by the
# color. The ITD was calculated by the binaural model for a single noise burst
# synthesized as a focused source or point source with WFS (2.76), (2.64) and
# NFC-HOA (2.50). The magnitude of the signal in the frequency channel is
# indicated by the opacity of the ITD points, with lighter points correspond to
# lower magnitudes.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set loadpath '../../gnuplot' 'data' 'src'

load 'latex.cfg'

set terminal epslatex size 14.5cm,10.5cm color colortext @small
set output 'fig6_04.tex'

unset key

set xrange [-1:1]
set yrange [0.1:0.9]
set cbrange [-80:-30]
unset colorbox

# limit time values in order to print no weight points on y-axis
limity(y) = y<0.12 ? 1/0 : y
# point size
PS=0.3
# sampling rate
FS = 44100

set multiplot

set size 0.2269,0.314

# --- 1 WFS fs 56 sources ---
set origin 0.08,0.697
set lmargin 2
set rmargin 0
set tmargin 2
set bmargin 0
load 'yborder.cfg'
set ytics (0.1,0.3,0.5,0.7,0.9)
load 'grid.cfg'
set ylabel 'time / s'
set label '\ft \acs{WFS}' at -0.9,0.14 left front tc ls 101
set label '\scs 56 s.' at -0.75,0.86 center front tc ls 101
datafile = 'wfs_nls56_X-0.75_Y0.00_fs'
load 'plot_itd_map.plt'

# --- WFS fs 28 sources ---
set origin 0.307,0.69
load 'noborder.cfg'
load 'grid.cfg'
set label '\ft focused source' at 0,1 center front
set label '\scs 28 s.' at -0.75,0.86 center front tc ls 101
datafile = 'wfs_nls28_X-0.75_Y0.00_fs'
load 'plot_itd_map.plt'

# --- WFS fs 14 sources ---
set origin 0.535,0.69
load 'grid.cfg'
set label '\scs 14 s.' at -0.75,0.86 center front tc ls 101
datafile = 'wfs_nls14_X-0.75_Y0.00_fs'
load 'plot_itd_map.plt'

# --- WFS ps 56 sources ---
set origin 0.08,0.355
set lmargin 2
set rmargin 0
set tmargin 1
set bmargin 1
load 'yborder.cfg'
set ytics (0.1,0.3,0.5,0.7,0.9)
load 'grid.cfg'
set ylabel 'time / s'
set label '\ft \acs{WFS}' at -0.9,0.14 left front tc ls 101
set label '\scs 56 s.' at -0.75,0.86 center front tc ls 101
datafile = 'wfs_nls56_X-0.75_Y0.00_ps'
load 'plot_itd_map.plt'

# --- WFS ps 28 sources ---
set origin 0.307,0.355
load 'noborder.cfg'
load 'grid.cfg'
set label '\ft point source' at 0,1 center front
set label '\scs 28 s.' at -0.75,0.86 center front tc ls 101
datafile = 'wfs_nls28_X-0.75_Y0.00_ps'
load 'plot_itd_map.plt'

# --- WFS ps 14 sources ---
set origin 0.535,0.355
load 'grid.cfg'
set label '\scs 14 s.' at -0.75,0.86 center front tc ls 101
datafile = 'wfs_nls14_X-0.75_Y0.00_ps'
load 'plot_itd_map.plt'

# --- NFC-HOA ps 56 sources, order 28 ---
set origin 0.08,0.04
set lmargin 2
set rmargin 0
set tmargin 0
set bmargin 2
load 'xyborder.cfg'
set ytics (0.1,0.3,0.5,0.7,0.9)
load 'grid.cfg'
set ylabel 'time / s'
set xlabel '\acs{ITD} / ms'
set label '\ft \acs{NFC-HOA}' at -0.9,0.14 left front tc ls 101
set label '\scs $M = 28$' at 0.75,0.14 center front tc ls 101
set label '\scs 56 s.' at -0.75,0.86 center front tc ls 101
datafile = 'nfchoa_nls56_order28_X-0.75_Y0.00_ps'
load 'plot_itd_map.plt'

# --- NFC-HOA ps 28 sources, order 14 ---
set origin 0.307,0.04
load 'xborder.cfg'
load 'grid.cfg'
set xlabel '\acs{ITD} / ms'
set label '\scs $M = 14$' at 0.75,0.14 center front tc ls 101
set label '\scs 28 s.' at -0.75,0.86 center front tc ls 101
datafile = 'nfchoa_nls28_order14_X-0.75_Y0.00_ps'
load 'plot_itd_map.plt'

# --- NFC-HOA ps 14 sources, order 7 ---
set origin 0.535,0.04
load 'xborder.cfg'
load 'grid.cfg'
set xlabel '\acs{ITD} / ms'
set label '\scs $M = 7$' at 0.75,0.14 center front tc ls 101
set label '\scs 14 s.' at -0.75,0.86 center front tc ls 101
datafile = 'nfchoa_nls14_order7_X-0.75_Y0.00_ps'
load 'plot_itd_map.plt'

# --- NFC-HOA ps 14 sources, order 28 ---
set origin 0.763,0.04
load 'xborder.cfg'
load 'grid.cfg'
set xlabel '\acs{ITD} / ms'
set label '\scs $M = 28$' at 0.75,0.14 center front tc ls 101
set label '\scs 14 s.' at -0.75,0.86 center front tc ls 101
set label '\ft $165$\,Hz'  at -0.7,1.7 center tc rgb '#0025ad'
set label '\ft $316$\,Hz'  at -0.7,1.55 center tc rgb '#00ada4'
set label '\ft $524$\,Hz'  at -0.7,1.4 center tc rgb '#5fad00'
set label '\ft $812$\,Hz'  at -0.7,1.25 center tc rgb '#ad8800'
set label '\ft $1210$\,Hz' at -0.7,1.1 center tc rgb '#ad1400'
set label '\scs listener at' at 0.5,1.2 center tc ls 101
set label '\scs $(-0.75,0,0)$\,m' at 0.5,1.1 center tc ls 101
set cbrange [-70:-20]
datafile = 'nfchoa_nls14_order28_X-0.75_Y0.00_ps'
load 'plot_itd_map.plt'

unset multiplot

# Make a raster version out of the image to reduce size:
unset output
!epstopdf fig6_04-inc.eps
!convert -density 400 fig6_04-inc.pdf fig6_04-inc_low.pdf
!mv fig6_04-inc_low.pdf fig6_04-inc.pdf
!pdflatex fig6_04.tex
!rm fig6_04.tex \
    fig6_04.aux \
    fig6_04-inc.eps \
    fig6_04-inc.pdf \
    fig6_04.log \
    fig6_04.out

# vim: set textwidth=200:
