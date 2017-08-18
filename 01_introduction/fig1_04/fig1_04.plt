#!/usr/bin/gnuplot
#
# FIGURE 1.4: Loudspeaker setups for two channel stereophony and sound field
# synthesis. The area marked in blue describes the positions were the listener
# can move to and still perceives the same spatial impression. This area is
# smaller for stereophonic setups and is called the sweet-spot. The figure of
# the stereophony setup is a modified version of J. Ahrens. Analytic Methods of
# Sound Field Synthesis. New York: Springer, 2012, Fig. 1.1.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

!pdflatex --jobname=fig1_04 src/fig1_04.tex
!rm fig1_04.log
