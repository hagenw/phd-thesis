![Fig 4.1](fig4_01.png)

**Figure 4.1**: Functional principle of dynamic binaural synthesis. The listener
is wearing headphones and a head tracker. The audio material is convolved with
the HRTF that incorporates all simulated loudspeakers for the corresponding
listener orientation.

## Steps for reproduction

The actual text is rendered into the figure using tikz. You can recreate the
final figure from the sketch file `src/dynamic_binaural_synthesis.pdf` and the
LaTeX file `src/fig4_01.tex` by running the following in a bash:

```Bash
$ gnuplot fig4_01.plt
```
