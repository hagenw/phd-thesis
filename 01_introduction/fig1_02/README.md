![Fig. 1.2](fig1_02.png)

**Figure 1.2**: Interaural differences occur between both ear signals for
sources to the side of the listener. For low frequencies ITDs are the dominant
cue, for high frequencies ILDs are more reliable.  The figure is based on B.
Grothe, M.  Pecka, and D. McAlpine. “Mechanisms of Sound Localization in
Mammals”.  Physiological Reviews 90 (2010), pp. 983–1012

## Steps for reproduction

The actual text is rendered into the figure using tikz. You can recreate the
final figure from the sketch file `src/itd_ild_sketch.pdf` and the
LaTeX file `src/fig1_02.tex` by running the following in a bash:

```Bash
$ gnuplot fig1_02.plt
```
