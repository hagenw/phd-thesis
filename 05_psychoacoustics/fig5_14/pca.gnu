#!/usr/bin/gnuplot
# Generate a biplot for subject 09 (castanets) and a biplot for subject 21
# (speech)
# PCA has been calculated by Ina with SPSS (see mail from 19.05.2010)
reset
set macros
set loadpath '../../gnuplot'

set terminal epslatex size 15cm,8cm color colortext
set output 'pca.tex'

load 'border.cfg'
load 'moreland.pal'

# Styling
set linetype 1 lt 1 lc rgb '#3b4cc0' #
set linetype 2 lt 1 lc rgb '#688aef' #
set linetype 3 lt 1 lc rgb '#99baff' #
set linetype 4 lt 1 lc rgb '#c9d8ef' #
set linetype 5 lt 1 lc rgb '#edd1c2' #
set linetype 6 lt 1 lc rgb '#f7a789' #
set linetype 7 lt 1 lc rgb '#e36a53' #
set linetype 8 lt 1 lc rgb '#b40426' #
set linetype 11  lc rgb '#a6a6a6' pt 65 lt 1 lw 1
set linetype 12 lc rgb '#000000' pt 7 lt 1 lw 2 # black
set linetype 13 lc rgb '#d6d7d9' lt 4 lw 1 # lightgrey
set linetype 12 lc rgb '#000000'

set size ratio -1
unset key

set xtics ('' -1.5,-1,'' -0.5,0,'' 0.5,1,'' 1.5)
set ytics ('' -1.5,-1,'' -0.5,0,'' 0.5,1,'' 1.5)

set multiplot layout 1,2 rowsfirst

## --- Plot 1: PCA for castanets, subject 9 ---
# Set x- yrange as variables, because they were needed below for the pseudo 
# grid
xmin=-1.8; xmax=1.8
ymin=-1.7; ymax=1.7
set xrange[xmin:xmax]
set yrange[ymin:ymax]

set ylabel offset 1,0
set xlabel 'principal component $C_1$'
set ylabel 'principal component $C_2$'

# Pseudo grid (because the real grid is using the major xtics)
# Deltas to fix the covering of the axis by the grid
dx = 0.04; dy = 0.05
set arrow 1 from 0,ymin+dy to 0,ymax-dy nohead back ls 13
set arrow 2 from xmin+dx,0 to xmax-dx,0 nohead back ls 13

# Labels for the negative attributes
# Fontsize for text in the graph
set label  1 '\scs narrow panorama'   at  0.250,-1.110 front tc ls 11
set label  2 '\scs \shortstack{many \\ artifacts}' at -1.600, 0.550 front tc ls 11
set label  3 '\scs colored'           at -1.500, 0.150 front tc ls 11
set label  4 '\scs off-center'        at -0.250,-1.450 front tc ls 11
set label  5 '\scs hard'              at  0.730, 1.150 front tc ls 11
set label  6 '\scs far'               at -1.310,-0.640 front tc ls 11
set label  7 '\scs thin'              at -1.240,-0.900 front tc ls 11
set label  8 '\scs narrow'            at  0.900,-0.820 front tc ls 11
# Labels for the positive attributes
set label 11 '\scs wide'              at -1.200, 0.850 front tc ls 11
set label 12 '\scs few artifacts'     at  0.950,-0.470 front tc ls 11
set label 13 '\scs non-colored'       at  1.000,-0.140 front tc ls 11
set label 14 '\scs center'            at -0.150, 1.500 front tc ls 11
set label 15 '\scs soft'              at -0.950,-1.150 front tc ls 11
set label 16 '\scs close'             at  1.020, 0.700 front tc ls 11
set label 17 '\scs full'              at  0.950, 0.860 front tc ls 11
set label 18 '\scs wide panorama'     at -1.500, 1.130 front tc ls 11

# Labels for the conditions
set label 21 '\scs ref'                      at  0.950, 0.400 front
set label 22 '\scs $0\degree_{4\,\text{m}}$'   at  1.100, 0.200 front tc ls 8
set label 23 '\scs $30\degree_{4\,\text{m}}$'  at  0.500,-0.190 front tc ls 7
set label 24 '\scs $60\degree_{4\,\text{m}}$'  at -0.590,-1.490 front tc ls 6
set label 25 '\scs $0\degree_{10\,\text{m}}$'  at -0.330, 0.400 front tc ls 1
set label 26 '\scs $30\degree_{10\,\text{m}}$' at -0.650, 0.900 front tc ls 2
set label 27 '\scs $60\degree_{10\,\text{m}}$' at -1.750, 0.350 front tc ls 3

set label 28 '\ft castanets' at 0,1.9 center front

plot 'pca_k9_attr.txt' u 2:3 w points ls 11, \
     ''                      u (-$2):(-$3) w points ls 11, \
     ''                      u (-$2):(-$3):(2*$2):(2*$3) w vectors nohead ls 11,\
     'pca_k9_stim.txt' i 0 u 2:3:4 w p pt 7 lc variable

# --- Plot 2: PCA for speech, subject 21 ---
xmin=-1.9; xmax=1.9
ymin=-1.8; ymax=1.8
set xrange[xmin:xmax]
set yrange[ymin:ymax]

set xlabel 'principal component $S_1$'
set ylabel 'principal component $S_2$'

# Pseudo grid (because the real grid is using the major xtics)
# Deltas to fix the covering of the axis by the grid
dx = 0.04; dy = 0.05
set arrow 1 from 0,ymin+dy to 0,ymax-dy nohead back ls 13
set arrow 2 from xmin+dx,0 to xmax-dx,0 nohead back ls 13

unset label

set label  1 '\scs additive whispering'      at -1.500,-0.880 tc ls 11
set label  2 '\scs thin'                     at -1.400,-0.600 tc ls 11
set label  3 '\scs far'                      at -1.220, 0.830 tc ls 11
set label  4 '\scs off-center'               at -0.850, 1.300 tc ls 11
# Labels for the positive attributes
set label 11 '\scs no additive whispering'   at  0.400, 0.930 tc ls 11
set label 12 '\scs full'                     at  1.070, 0.650 tc ls 11
set label 13 '\scs close'                    at  0.970,-0.770 tc ls 11
set label 14 '\scs center'                   at  0.350,-1.250 tc ls 11
# Labels for the conditions
set label 21 '\scs ref'                      at  0.550,-0.290 front tc ls 12
set label 22 '\scs $0\degree_{4\,\text{m}}$'   at  0.750,-0.189 front tc ls 8
set label 23 '\scs $30\degree_{4\,\text{m}}$'  at  0.010, 0.460 front tc ls 7
set label 24 '\scs $60\degree_{4\,\text{m}}$'  at -0.850, 1.670 front tc ls 6
set label 25 '\scs $0\degree_{10\,\text{m}}$'  at  0.500,-0.000 front tc ls 1
set label 26 '\scs $30\degree_{10\,\text{m}}$' at  0.220,-0.480 front tc ls 2
set label 27 '\scs $60\degree_{10\,\text{m}}$' at -1.720,-1.080 front tc ls 3

set label 28 '\ft speech' at 0,2.0 center front

plot 'pca_s21_attr.txt' u (-$2):(-$3):(2*$2):(2*$3) w vectors nohead ls 11,\
     ''                 u 2:3 w p ls 11,\
     ''                 u (-$2):(-$3) w p ls 11, \
     'pca_s21_stim.txt' u 2:3:4 w p pt 7 lc variable

unset multiplot
