#!/usr/bin/gnuplot
#
# FIGURE 2.3: Sound pressure in decibel for secondary source distributions with
# different dimensionality all driven by the same signals. The sound pressure is
# color coded, lighter color corresponds to lower pressure. In the 3D case a
# planar distribution of point sources is applied, in the 2.5D case a linear
# distribution of point sources, and in the 2D case a linear distribution of
# line sources.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

!pdflatex --jobname=fig2_03 src/fig2_03.tex
!rm fig2_03.log
