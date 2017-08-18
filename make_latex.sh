#!/bin/bash
# --- C O N F I G U R A T I O N ---------
FILE=wierstorf2014-perceptual_assessment_of_sound_field_synthesis
FOLDERS="01_introduction \
02_sound_field_synthesis \
03_binaural_synthesis \
04_psychoacoustics \
05_modelling \
06_quality"
# --- M A I N ---------------------------
# check if we have to add an extra latex run
if ! [[ -f $FILE.aux ]]
then
    pdflatex $FILE
fi
if ! [[ -f $FILE.bbl ]]
then
    biber $FILE
fi
# run latex
pdflatex $FILE
# apply metadata (this has to be done after the compilation of the PDF, because
# the gnuplot figures overwrites the hyperref settings)
mv $FILE.pdf ${FILE}_tmp.pdf
pdftk ${FILE}_tmp.pdf \
    update_info metadata.txt \
    output $FILE.pdf
rm ${FILE}_tmp.pdf
