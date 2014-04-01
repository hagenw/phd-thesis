#!/usr/bin/gnuplot
set t epslatex size 10cm,7cm color colortext
set output 'amplitudes_moving_source.tex';

load 'border.cfg'
load 'grid.cfg'
load 'paired.pal'

set format '$%g$'

unset key

set xrange [-4.5:8]
set yrange [-16:9]
set xtics 1 offset 0,0.5 scale 0
set ytics 3 offset 0.5,0
unset xlabel
unset ylabel
set format x ''
set xtics scale 0

set lmargin 5

set multiplot layout 2,1
set border 2
set label 1 '\twoD' at 7.5,7.5 center front
set label 2 '\ft listener positions'      at 7, -3.0 right  front tc ls 101
set label 3 '\ft $(0,-2,0)$\,m'           at 7, -6.0 right  front tc ls 6
set label 4 '\ft $(0,-4,0)$\,m'           at 7, -9.0 right  front tc ls 7
set label 5 '\ft $(2,-2,0)$\,m'           at 7,-12.0 right  front tc ls 8
set label 6 '\ft moving focused/line source' at 0.5,  7.5 left   front tc ls 7
set label 7 '\ft \eqref{eq:D_wfs_ls}'     at 4,  3   center front tc ls 7
set label 8 '\ft \eqref{eq:D_wfs_ls_fs}'  at -3, 4.5 center front tc ls 7
set bmargin 1
set tmargin 1
load 'greens.pal'
plot 'amplitudes_moving_source_2D_X0.0_Y-2.0.txt' u 1:($3-$2-19.989) w l ls 6 lw 3,\
     'amplitudes_moving_source_2D_X0.0_Y-4.0.txt' u 1:($3-$2-19.989) w l ls 7 lw 3,\
     'amplitudes_moving_source_2D_X2.0_Y-2.0.txt' u 1:($3-$2-19.989) w l ls 8 lw 3,\
     '<echo "0 0"' w p pt 7 ps 1.5 lc rgb 'black'
unset label
set label 1 '\twohalfD' at 7.5,7.5 center front
set label 2 '\ft moving focused/point source' at 0.5,7.5 left front tc ls 7
set label 3 '\ft $(0,-2,0)$\,m'           at 7, -6.0 right  front tc ls 6
set label 4 '\ft $(0,-4,0)$\,m'           at 7, -9.0 right  front tc ls 7
set label 5 '\ft $(2,-2,0)$\,m'           at 7,-12.0 right  front tc ls 8
set label 6 '\ft \eqref{eq:D_wfs_ps_25D_without_approximation}' \
                                          at 4,  3.8 center front tc ls 3
set label 7 '\ft \eqref{eq:D_wfs_ps_25D}' at 4, -6.5 center front tc ls 7
set label 8 '\ft \eqref{eq:D_wfs_fs_25D_without_approximation}' \
                                          at -2, 0   center front tc ls 3 
set label 9 '\ft \eqref{eq:D_wfs_fs_25D}' at -.5,-13 center front tc ls 7
set border 3
set xtics scale 0.75
set format x '$%g$'
set xlabel '$y_\text{s}$ / m' offset 0,1
set ylabel 'amplitude deviation / dB' offset 1.5,4.7
set bmargin 2
set tmargin 0
load 'blues.pal'
plot 'amplitudes_moving_source_25D_ps_X0.0_Y-2.0.txt' u 1:($3-$2-20.962) w l ls 2 lw 3,\
     'amplitudes_moving_source_25D_ps_X0.0_Y-4.0.txt' u 1:($3-$2-20.962) w l ls 3 lw 3,\
     'amplitudes_moving_source_25D_ps_X2.0_Y-2.0.txt' u 1:($3-$2-20.962) w l ls 4 lw 3,\
     'amplitudes_moving_source_25D_X0.0_Y-2.0.txt'    u 1:($3-$2-29.989) w l ls 6 lw 3,\
     'amplitudes_moving_source_25D_X0.0_Y-4.0.txt'    u 1:($3-$2-29.989) w l ls 7 lw 3,\
     'amplitudes_moving_source_25D_X2.0_Y-2.0.txt'    u 1:($3-$2-29.989) w l ls 8 lw 3,\
     '<echo "0 0"' w p pt 7 ps 1.5 lc rgb 'black'
unset multiplot

