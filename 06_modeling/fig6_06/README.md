![Fig 6.6](fig6_06.png)

**Figure 6.6**: Model predictions of the
perceived direction for a synthesized
sources in the audience area. Both
secondary source distributions were
driven by WFS with (2.57) for the plane
wave and (2.64) for the point source.

## Steps for reproduction

Matlab/Octave:
```Matlab
>> wfs_box_model
>> wfs_concave_model
```

Bash:
```Bash
$ gnuplot wfs_model.gnu
```
