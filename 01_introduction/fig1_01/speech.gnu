#!/usr/bin/gnuplot
#
# Create a plot from the speech file
#
# AUTHOR: Hagen Wierstorf
# gnuplot 4.6 patchlevel 3

reset
set loadpath '../../gnuplot'

# wxt
#set terminal wxt size 350,262 enhanced font 'Verdana,10' persist
# png
set terminal pngcairo size 400,299 enhanced font 'Verdana,10'
set output 'speech.png'

load 'noborder.cfg'
load 'paired.pal'

unset key

plot 'speech.txt' w l lc rgb 'black' lw 1
