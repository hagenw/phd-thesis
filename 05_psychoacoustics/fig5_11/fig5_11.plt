#!/usr/bin/gnuplot
#
# FIGURE 5.11: Perceived coloration rated with the attribute pair very
# different, no difference. The latter corresponds to a value of 0 in the
# figure, the former to a value of 10. The values are written directly at the
# listening position where the listener had to rate the coloration, and are
# further highlighted by a corresponding color. The average confidence interval
# is 1.2 over all positions.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'localization.cfg'
load 'array.cfg'
load 'noborder.cfg'

set terminal epslatex size 11.5cm,6cm color colortext @small
set output 'fig5_11.tex'

unset key
set size ratio -1

set cbrange [-1:1]

set tmargin 0
set bmargin 0
set lmargin 0
set rmargin 0

unset colorbox

set xrange [-2.1:2.1]
set yrange [-2.1:2.6]

set multiplot
set size 0.437,1

# WFS point source, 56 secondary sources
# noise
set origin -0.03,0
load 'blues.pal'
set label 1 '\ft noise' at 0,0.5 center front tc ls 7
set arrow 21 from 1.210,1.194 to 1.322,1.069 heads size 0.05,90,0 front ls 101
set label 21 '\tiny $0.17$\,m' at 1.452,1.298 rotate by -48.21 front center tc ls 101
plot 'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_ps.txt'  @array_active w p,\
     'wfs_coloration_pos.txt' i 2 u 1:2:3 w p pt 7 ps 2.5 lc palette,\
     ''                       i 2 u 1:($2+0.02):(sprintf('\\color{white}\\tiny $\\mathbf{%.0f}$',(-1*$3+1)*5)) w labels lc rgb 'white',\
     set_point_source(0,2.5)            @point_source 

unset arrow
unset label 21
# speech
set origin 0.407,0
load 'reds.pal'
set label 1 '\ft speech' #at 0,0.5 center front tc ls 2
set arrow from 2,-2 to 2,-1 heads size 0.05,90,0 ls 101
set arrow from 1.97,-1.5 to 2.03,-1.5 nohead ls 101
set label '\ft very different' at 2.1,-1 left front tc ls 101
set label '\ft no difference'  at 2.1,-2 left front tc ls 101
set label '\ft $0$'            at 1.9,-2 right front tc ls 101
set label '\ft $5$'            at 1.9,-1.5 right front tc ls 101
set label '\ft $10$'           at 1.9,-1 right front tc ls 101
set label '\ft \acs{WFS}'       at -2.2,-1.5 center front tc ls 101
plot 'array_nls56_circular.txt'         @array_inactive w p,\
     'array_nls56_circular_wfs_ps.txt'  @array_active w p,\
     'wfs_coloration_pos.txt' i 0 u 1:2:3 w p pt 7 ps 2.5 lc palette,\
     ''                       i 0 u 1:($2+0.02):(sprintf('\\color{white}\\tiny $\\mathbf{%.0f}$',(-1*$3+1)*5)) w labels lc rgb 'white',\
     set_point_source(0,2.5)            @point_source 

unset multiplot

call 'plot.plt' 'fig5_11'

# vim: set textwidth=200:
