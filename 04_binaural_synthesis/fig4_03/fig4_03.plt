#!/usr/bin/gnuplot
#
# FIGURE 4.1: Functional principle of dynamic binaural synthesis. The listener
# is wearing headphones and a head tracker. The audio material is convolved
# with the HRTF that incorporates all simulated loudspeakers for the
# corresponding listener orientation.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

!pdflatex --jobname=fig4_03 src/fig4_03.tex
!rm fig4_03.log
