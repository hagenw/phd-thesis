#gp_set_loudspeaker sets a loudspeaker as an gnuplot object
#   Usage: call 'gp_set_loudspeaker.gnu' 'x0' 'y0' 'phi' 'activity' 'color' 'lssize'
#
#   Input parameters:
#       x0, y0      - loudspeaker position
#       phi         - orientation of the loudspeaker
#       activity    - activity of the loudspeaker (0..1)
#       color       - color of speaker
#       lssize      - size of the loudspeaker
#
#   gp_set_loudspeaker sets a single gnuplot object in the
#   form of a loudspeaker at the given position and for the given orientation.
#   The activity gives the color of the speaker ranging from 0 (white) to 1
#   (gray). This file is run in the loop gp_draw_loudspeakers.
#   For every added loudspeaker the global variable object_number is counted one
#   up and is accessable in your gnuplot code.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

# Checking if we have enough input parameters
if (ARGC!=6) print 'gp_set_loudspeakers needs 5 input parameters'; exit

# Getting the input parameters
x0 = ARG1
y0 = ARG2
p = ARG3
activity = ARG4
color = ARG5
lssize = ARG6

# Initialize an object number
if (!exists("object_number")) object_number = 1;

# Fixing loudspeaker size (because we draw a line around the loudspeaker
a = lssize-0.01;

# Set the loudspeaker at the given position and rotate it by a rotation matrix:
set object object_number polygon from \
-a*cos(p)+a/2*sin(p)+x0,   -a*sin(p)-a/2*cos(p)+y0    to \
-a*cos(p)-a/2*sin(p)+x0,   -a*sin(p)+a/2*cos(p)+y0    to \
-a/2*cos(p)-a/2*sin(p)+x0, -a/2*sin(p)+a/2*cos(p)+y0  to \
-a/2*cos(p)-a/6*sin(p)+x0, -a/2*sin(p)+a/6*cos(p)+y0  to \
0*cos(p)-a/2*sin(p)+x0,    0*sin(p)+a/2*cos(p)+y0     to \
0*cos(p)+a/2*sin(p)+x0,    0*sin(p)-a/2*cos(p)+y0     to \
-a/2*cos(p)+a/6*sin(p)+x0, -a/2*sin(p)-a/6*cos(p)+y0  to \
-a/2*cos(p)+a/2*sin(p)+x0, -a/2*sin(p)-a/2*cos(p)+y0  to \
-a*cos(p)+a/2*sin(p)+x0,   -a*sin(p)-a/2*cos(p)+y0
# Set the color etc.
set object object_number fc rgb color fs solid 0.5*activity border lc rgb color lw 1 front
object_number = object_number+1
