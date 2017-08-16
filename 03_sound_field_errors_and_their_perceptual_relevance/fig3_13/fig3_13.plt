#!/usr/bin/gnuplot
#
# FIGURE 3.13: Sound pressure of a cosine shaped impulse synthesized as a plane
# wave by NFC-HOA (2.45) and WFS (2.57). Parameters: n_k = (0, -1, 0),
# x_ref = (0, 0, 0), t = 4.6 ms, 64 secondary sources for the sampled
# distributions.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'border.cfg'
load 'moreland.pal'
load 'array.cfg'

set terminal epslatex size 15cm,9.1cm color colortext @small
set output 'fig3_13.tex';

unset key
set size ratio -1


set xrange [-1.75:1.75]
set yrange [-1.75:1.75]
set cbrange [-0.8:0.8] # go only to |0.8| to enhance visibility in figure
set tics scale 0.75 out nomirror
set xtics 1 offset 0,0.5
set ytics 1 offset 0.5,0
set cbtics 1
unset colorbox

set multiplot layout 2,3
set tmargin 1.8
set bmargin 1.15
set label 11 '\ft continuous secondary sources' at 0,2.3 center front tc ls 101
set label 1 '\ft \acs{NFC-HOA}' at -1.7,1.95 left front tc ls 101
load 'yborder.cfg'
set ylabel '$y$ / m' offset 1.5,0
set lmargin 4
set rmargin 0
plot 'nfchoa.dat' binary matrix u 1:2:(64*real($3)) with image,\
     'array.txt' @array_active w l
load 'noborder.cfg'
set lmargin 2
set rmargin 2
set label 11 '\ft 64 secondary sources'
plot 'nfchoa_nls64.dat' binary matrix u 1:2:(32*real($3)) with image,\
     'array_nls64.txt' @array_active w p
load 'xborder.cfg'
set xlabel '$x$ / m' offset 0,1
set lmargin 0
set rmargin 4
set label 1 '\ft band-limited \acs{NFC-HOA}'
plot 'nfchoa_nls64_band_limited.dat' binary matrix u 1:2:(4*real($3)) with image,\
     'array_nls64.txt' @array_active w p
set tmargin 0.85
set bmargin 2.1
load 'xyborder.cfg'
set ylabel '$y$ / m' offset 1.5,0
set lmargin 4
set rmargin 0
set label 1 '\ft \acs{WFS}'
unset label 11
plot 'wfs.dat' binary matrix u 1:2:(real(-$3)) with image,\
     'array.txt' @array_inactive w l,\
     'array_wfs.txt' @array_active w l
load 'xborder.cfg'
set lmargin 2
set rmargin 2
plot 'wfs_nls64.dat' binary matrix u 1:2:(real(-$3)) with image,\
     'array_nls64.txt'  @array_inactive w p,\
     'array_wfs_nls64.txt' @array_active w p
unset multiplot

call 'plot.plt' 'fig3_13'
