#!/usr/bin/gnuplot
reset
set macros
set loadpath '../../gnuplot'

set t epslatex size 15cm,9cm color colortext
set output 'sound_field_time_fixed_filtered.tex';

load 'grid.cfg'
#load 'paired.pal'
load 'rdbu.pal'

unset key

set bmargin 2
set tmargin 1

set multiplot layout 2,3
load 'yborder.cfg'
set ylabel 'sound pressure'
set lmargin 4
set rmargin 0
set label 1 '\ft continuous secondary sources' at 6,1.4 center tc ls 101
set label 2 '\ft \ac{NFC-HOA}' at 11.8,-4.6 right front tc ls 101
stats 'lowpass_nfchoa_X0.00_Y0.00.txt' u 2 nooutput
plot [*:*] [-5:1] 'lowpass_nfchoa_X0.00_Y0.00.txt'  u ($1*1000):($2/STATS_max)   w l ls 8 lw 2,\
                  'lowpass_nfchoa_X0.75_Y0.00.txt'  u ($1*1000):($2/STATS_max-2) w l ls 7 lw 2,\
                  'lowpass_nfchoa_X0.00_Y0.75.txt'  u ($1*1000):($2/STATS_max-4) w l ls 6 lw 2,\
                  'highpass_nfchoa_X0.00_Y0.00.txt' u ($1*1000):($2/STATS_max)   w l ls 1 lw 2,\
                  'highpass_nfchoa_X0.75_Y0.00.txt' u ($1*1000):($2/STATS_max-2) w l ls 2 lw 2,\
                  'highpass_nfchoa_X0.00_Y0.75.txt' u ($1*1000):($2/STATS_max-4) w l ls 3 lw 2
load 'noborder.cfg'
unset ylabel
set lmargin 2
set rmargin 2
set label 1 '\ft 64 secondary sources'
set label 3 '\tiny numerically unstable' at 7.50,-1.93 front tc ls 2
set label 4 '\tiny numerically unst.' at 8.22,-3.93 front tc ls 3
limit1(x,y) = x*1000.>7.25 ? 1/0 : y # this hides the numerical unstable parts
limit2(x,y) = x*1000.>7.97 ? 1/0 : y
stats 'lowpass_nfchoa_X0.00_Y0.00_nls64.txt' u 2 nooutput
plot [*:*] [-5:1] 'lowpass_nfchoa_X0.00_Y0.00_nls64.txt'  u ($1*1000):($2/STATS_max)              w l ls 8 lw 2,\
                  'lowpass_nfchoa_X0.75_Y0.00_nls64.txt'  u ($1*1000):(limit1($1,$2/STATS_max-2)) w l ls 7 lw 2,\
                  'lowpass_nfchoa_X0.00_Y0.75_nls64.txt'  u ($1*1000):(limit2($1,$2/STATS_max-4)) w l ls 6 lw 2,\
                  'highpass_nfchoa_X0.00_Y0.00_nls64.txt' u ($1*1000):($2/STATS_max)              w l ls 1 lw 2,\
                  'highpass_nfchoa_X0.75_Y0.00_nls64.txt' u ($1*1000):(limit1($1,$2/STATS_max-2)) w l ls 2 lw 2,\
                  'highpass_nfchoa_X0.00_Y0.75_nls64.txt' u ($1*1000):(limit2($1,$2/STATS_max-4)) w l ls 3 lw 2
unset label 3
unset label 4
load 'xborder.cfg'
set xlabel '$t$ / ms'
set lmargin 0
set rmargin 4
set label 2 '\ft band-limited \ac{NFC-HOA}'
set label 3 '\scs $<2$\,kHz' at 2.8,-1.2 center front tc ls 7
set label 4 '\scs $>2$\,kHz' at 6.2,-1.4 center front tc ls 2
stats 'lowpass_nfchoa_X0.00_Y0.00_nls64_band_limited.txt' u 2 nooutput
plot [*:*] [-5:1] 'lowpass_nfchoa_X0.00_Y0.00_nls64_band_limited.txt'  u ($1*1000):($2/STATS_max)   w l ls 8 lw 2,\
                  'lowpass_nfchoa_X0.75_Y0.00_nls64_band_limited.txt'  u ($1*1000):($2/STATS_max-2) w l ls 7 lw 2,\
                  'lowpass_nfchoa_X0.00_Y0.75_nls64_band_limited.txt'  u ($1*1000):($2/STATS_max-4) w l ls 6 lw 2,\
                  'highpass_nfchoa_X0.00_Y0.00_nls64_band_limited.txt' u ($1*1000):($2/STATS_max)   w l ls 1 lw 2,\
                  'highpass_nfchoa_X0.75_Y0.00_nls64_band_limited.txt' u ($1*1000):($2/STATS_max-2) w l ls 2 lw 2,\
                  'highpass_nfchoa_X0.00_Y0.75_nls64_band_limited.txt' u ($1*1000):($2/STATS_max-4) w l ls 3 lw 2
unset label 1
load 'xyborder.cfg'
set ylabel 'sound pressure'
set bmargin 3
set tmargin 0
set lmargin 4
set rmargin 0
set label 2 '\ft \ac{WFS}'
set label 3 '\scs listener at'  at 11,1.2 right front tc ls 101
set label 4 '\scs $(0,0,0)$\,m' at 11,0.5 right front tc ls 101
set label 5 '\scs $(0.75,0,0)$\,m' at 11,-1.5 right front tc ls 101
set label 6 '\scs $(0,0.75,0)$\,m' at 11,-3.5 right front tc ls 101
stats 'lowpass_wfs_X0.00_Y0.00.txt' u 2 nooutput
plot [*:*] [-5:1] 'lowpass_wfs_X0.00_Y0.00.txt'  u ($1*1000):($2/STATS_min)   w l ls 8 lw 2,\
                  'lowpass_wfs_X0.75_Y0.00.txt'  u ($1*1000):($2/STATS_min-2) w l ls 7 lw 2,\
                  'lowpass_wfs_X0.00_Y0.75.txt'  u ($1*1000):($2/STATS_min-4) w l ls 6 lw 2,\
                  'highpass_wfs_X0.00_Y0.00.txt' u ($1*1000):($2/STATS_min)   w l ls 1 lw 2,\
                  'highpass_wfs_X0.75_Y0.00.txt' u ($1*1000):($2/STATS_min-2) w l ls 2 lw 2,\
                  'highpass_wfs_X0.00_Y0.75.txt' u ($1*1000):($2/STATS_min-4) w l ls 3 lw 2
unset for [ii=3:6] label ii
load 'xborder.cfg'
set lmargin 2
set rmargin 2
stats 'lowpass_wfs_X0.00_Y0.00_nls64.txt' u 2 nooutput
plot [*:*] [-5:1] 'lowpass_wfs_X0.00_Y0.00_nls64.txt'  u ($1*1000):($2/STATS_min)   w l ls 8 lw 2,\
                  'lowpass_wfs_X0.75_Y0.00_nls64.txt'  u ($1*1000):($2/STATS_min-2) w l ls 7 lw 2,\
                  'lowpass_wfs_X0.00_Y0.75_nls64.txt'  u ($1*1000):($2/STATS_min-4) w l ls 6 lw 2,\
                  'highpass_wfs_X0.00_Y0.00_nls64.txt' u ($1*1000):($2/STATS_min)   w l ls 1 lw 2,\
                  'highpass_wfs_X0.75_Y0.00_nls64.txt' u ($1*1000):($2/STATS_min-2) w l ls 2 lw 2,\
                  'highpass_wfs_X0.00_Y0.75_nls64.txt' u ($1*1000):($2/STATS_min-4) w l ls 3 lw 2
unset multiplot

# vim: set textwidth=200:
