#!/usr/bin/gnuplot
#
# Loudspeaker directivity of a loudspeaker array (real vs. simulated)
#
# AUTHOR: Hagen Wierstorf

reset
set macros
set loadpath '../../gnuplot'

set terminal epslatex size 10cm,6cm color colortext
set output 'array_directivity.tex'
set format '$%g$'

load 'border.cfg'
load 'grid.cfg'
set grid xtics ytics mxtics
load 'blgrrd.pal'

unset key
set tmargin 0
set rmargin 0
set lmargin 6

set logscale x

set xlabel 'center frequency / Hz'
set ylabel '$\Delta$ magnitude / dB' offset 1.5,0
set xrange [100:20000]
set yrange [-19:5]
set ytics 3 
set xtics 
set xtics add ('$100$' 100,'$200$' 200,'$400$' 400,'$1$k' 1000,'$2$k' 2000,'$4$k' 4000,'$10$k' 10000,'$20$k' 20000)

set multiplot

# large plot
set label '\ft influence of directivity' at 6000,-17.815 center front
set arrow from 6000,-16.89 to 14000,-9.26 front
plot for [n=1:18] 'array_directivity.txt' u 1:(column(n)+1) w l ls n
unset label

# small plot with loudspeakers
set origin 0.05,0.035
set size 0.75,0.5
set label '\ft real array' at 0,0.35 center front
set xrange [-2.7:2.7]
set yrange [-2.2:0.2]
unset border; unset tics; unset xlabel; unset ylabel
unset logscale
call 'set_ls.gnu' '-2.55' '0' '-1.5708' '1' '#ada400' '0.1'
call 'set_ls.gnu' '-2.40' '0' '-1.5708' '1' '#99ad00' '0.1'
call 'set_ls.gnu' '-2.25' '0' '-1.5708' '1' '#7cad00' '0.1'
call 'set_ls.gnu' '-2.10' '0' '-1.5708' '1' '#5fad00' '0.1'
call 'set_ls.gnu' '-1.95' '0' '-1.5708' '1' '#42ad00' '0.1'
call 'set_ls.gnu' '-1.80' '0' '-1.5708' '1' '#25ad00' '0.1'
call 'set_ls.gnu' '-1.65' '0' '-1.5708' '1' '#09ad00' '0.1'
call 'set_ls.gnu' '-1.50' '0' '-1.5708' '1' '#00ad14' '0.1'
call 'set_ls.gnu' '-1.35' '0' '-1.5708' '1' '#00ad31' '0.1'
call 'set_ls.gnu' '-1.20' '0' '-1.5708' '1' '#00ad4e' '0.1'
call 'set_ls.gnu' '-1.05' '0' '-1.5708' '1' '#00ad6b' '0.1'
call 'set_ls.gnu' '-0.90' '0' '-1.5708' '1' '#00ad88' '0.1'
call 'set_ls.gnu' '-0.75' '0' '-1.5708' '1' '#00ada4' '0.1'
call 'set_ls.gnu' '-0.60' '0' '-1.5708' '1' '#0099ad' '0.1'
call 'set_ls.gnu' '-0.45' '0' '-1.5708' '1' '#007cad' '0.1'
call 'set_ls.gnu' '-0.30' '0' '-1.5708' '1' '#0060ad' '0.1'
call 'set_ls.gnu' '-0.15' '0' '-1.5708' '1' '#0042ad' '0.1'
call 'set_ls.gnu' '-0.00' '0' '-1.5708' '1' '#0025ad' '0.1'
call 'set_ls.gnu' ' 0.15' '0' '-1.5708' '1' '#0042ad' '0.1'
call 'set_ls.gnu' ' 0.30' '0' '-1.5708' '1' '#0060ad' '0.1'
call 'set_ls.gnu' ' 0.45' '0' '-1.5708' '1' '#007cad' '0.1'
call 'set_ls.gnu' ' 0.60' '0' '-1.5708' '1' '#0099ad' '0.1'
call 'set_ls.gnu' ' 0.75' '0' '-1.5708' '1' '#00ada4' '0.1'
call 'set_ls.gnu' ' 0.90' '0' '-1.5708' '1' '#00ad88' '0.1'
call 'set_ls.gnu' ' 1.05' '0' '-1.5708' '1' '#00ad6b' '0.1'
call 'set_ls.gnu' ' 1.20' '0' '-1.5708' '1' '#00ad4e' '0.1'
call 'set_ls.gnu' ' 1.35' '0' '-1.5708' '1' '#00ad31' '0.1'
call 'set_ls.gnu' ' 1.50' '0' '-1.5708' '1' '#00ad14' '0.1'
call 'set_ls.gnu' ' 1.65' '0' '-1.5708' '1' '#09ad00' '0.1'
call 'set_ls.gnu' ' 1.80' '0' '-1.5708' '1' '#25ad00' '0.1'
call 'set_ls.gnu' ' 1.95' '0' '-1.5708' '1' '#42ad00' '0.1'
call 'set_ls.gnu' ' 2.10' '0' '-1.5708' '1' '#5fad00' '0.1'
call 'set_ls.gnu' ' 2.25' '0' '-1.5708' '1' '#7cad00' '0.1'
call 'set_ls.gnu' ' 2.40' '0' '-1.5708' '1' '#99ad00' '0.1'
call 'set_ls.gnu' ' 2.55' '0' '-1.5708' '1' '#ada400' '0.1'
#call 'gp_set_head.gnu' '0' '-2' '1.5708'
plot 1/0

# small plot with loudspeakers
unset label
unset arrow
unset object
set origin 0.05,0.0
set size 0.75,0.5
set label '$-$' at 0,0.7 center front
set label '\ft simulated array' at 0,0.35 center front
set xrange [-2.7:2.7]
set yrange [-1.3:0.9]
unset border; unset tics; unset xlabel; unset ylabel
unset logscale
call 'set_ls.gnu' '-2.55' '0' '-0.6651' '1' '#ada400' '0.1'
call 'set_ls.gnu' '-2.40' '0' '-0.6947' '1' '#99ad00' '0.1'
call 'set_ls.gnu' '-2.25' '0' '-0.7266' '1' '#7cad00' '0.1'
call 'set_ls.gnu' '-2.10' '0' '-0.7610' '1' '#5fad00' '0.1'
call 'set_ls.gnu' '-1.95' '0' '-0.7980' '1' '#42ad00' '0.1'
call 'set_ls.gnu' '-1.80' '0' '-0.8379' '1' '#25ad00' '0.1'
call 'set_ls.gnu' '-1.65' '0' '-0.8810' '1' '#09ad00' '0.1'
call 'set_ls.gnu' '-1.50' '0' '-0.9273' '1' '#00ad14' '0.1'
call 'set_ls.gnu' '-1.35' '0' '-0.9770' '1' '#00ad31' '0.1'
call 'set_ls.gnu' '-1.20' '0' '-1.0304' '1' '#00ad4e' '0.1'
call 'set_ls.gnu' '-1.05' '0' '-1.0873' '1' '#00ad6b' '0.1'
call 'set_ls.gnu' '-0.90' '0' '-1.1479' '1' '#00ad88' '0.1'
call 'set_ls.gnu' '-0.75' '0' '-1.2120' '1' '#00ada4' '0.1'
call 'set_ls.gnu' '-0.60' '0' '-1.2793' '1' '#0099ad' '0.1'
call 'set_ls.gnu' '-0.45' '0' '-1.3495' '1' '#007cad' '0.1'
call 'set_ls.gnu' '-0.30' '0' '-1.4219' '1' '#0060ad' '0.1'
call 'set_ls.gnu' '-0.15' '0' '-1.4959' '1' '#0042ad' '0.1'
call 'set_ls.gnu' '-0.00' '0' '-1.5708' '1' '#0025ad' '0.1' # center
call 'set_ls.gnu' ' 0.15' '0' '-1.6457' '1' '#0042ad' '0.1'
call 'set_ls.gnu' ' 0.30' '0' '-1.7197' '1' '#0060ad' '0.1'
call 'set_ls.gnu' ' 0.45' '0' '-1.7921' '1' '#007cad' '0.1'
call 'set_ls.gnu' ' 0.60' '0' '-1.8623' '1' '#0099ad' '0.1'
call 'set_ls.gnu' ' 0.75' '0' '-1.9296' '1' '#00ada4' '0.1'
call 'set_ls.gnu' ' 0.90' '0' '-1.9937' '1' '#00ad88' '0.1'
call 'set_ls.gnu' ' 1.05' '0' '-2.0542' '1' '#00ad6b' '0.1'
call 'set_ls.gnu' ' 1.20' '0' '-2.1112' '1' '#00ad4e' '0.1'
call 'set_ls.gnu' ' 1.35' '0' '-2.1645' '1' '#00ad31' '0.1'
call 'set_ls.gnu' ' 1.50' '0' '-2.2143' '1' '#00ad14' '0.1'
call 'set_ls.gnu' ' 1.65' '0' '-2.2606' '1' '#09ad00' '0.1'
call 'set_ls.gnu' ' 1.80' '0' '-2.3036' '1' '#25ad00' '0.1'
call 'set_ls.gnu' ' 1.95' '0' '-2.3435' '1' '#42ad00' '0.1'
call 'set_ls.gnu' ' 2.10' '0' '-2.3806' '1' '#5fad00' '0.1'
call 'set_ls.gnu' ' 2.25' '0' '-2.4150' '1' '#7cad00' '0.1'
call 'set_ls.gnu' ' 2.40' '0' '-2.4469' '1' '#99ad00' '0.1'
call 'set_ls.gnu' ' 2.55' '0' '-2.4765' '1' '#ada400' '0.1'
plot 1/0

unset multiplot
