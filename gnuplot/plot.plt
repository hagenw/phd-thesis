# Call this script together with a file base name to run pdflatex on it
#
# AUTHOR: Hagen Wierstorf
unset output
!pdflatex @ARG1.tex
if (ARG2==2) { !pdflatex @ARG1.tex } # run LaTeX two times if requested
!rm @ARG1.tex \
    @ARG1.aux \
    @ARG1-inc.eps \
    @ARG1-inc-eps-converted-to.pdf \
    @ARG1.log \
    @ARG1.out
