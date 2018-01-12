# Perceptual Assessment of Sound Field Synthesis #

This repository provides the following PhD thesis, together with
[errata](#errata-and-updates) and the [software](#software-requirements) you
need to reproduce the thesis.

**Hagen Wierstorf - Perceptual Assessment of Sound Field
Synthesis, PhD thesis, TU Berlin, 2014,
[(doi)](http://dx.doi.org/10.14279/depositonce-4310),
[(pdf)](https://hagenw.github.io/pubs/wierstorf-2014-perceptual_assessment_of_sound_field_synthesis.pdf).**

The software is spread in different directories named after the chapter and
figure numbers. In order to run the code you will need the external toolboxes
mentioned below and Matlab or Octave. Some of the code runs only in Octave at
the moment, but it should be easily adoptable to Matlab. Those cases are
indicated in the README in the corresponding figure directories.


## Errata and Updates

### Updates of Figures

With [release 2.4] of the Sound Field Synthesis Toolbox for Matlab many
numerical issues of the time-domain NFC-HOA have been solved.

The following table provides links to all figures, for which essential updates
are available. On the figure pages itself you will see thumbnails of the
original version as well as of the corrected one.

| Updated Figure | Description                                                |
|:---------------|:-----------------------------------------------------------|
| [Fig. 3.13]    | Improved numerical stability for NFC-HOA                   |
| [Fig. 3.14]    | Improved numerical stability for NFC-HOA                   |
| [Fig. 3.15]    | Improved numerical stability for NFC-HOA                   |
| [Fig. 3.17]    | Improved numerical stability for NFC-HOA                   |
| [Fig. 5.8]     | Corrected frequency response by fractional delay filter    |
| [Fig. 5.9]     | Corrected frequency response by fractional delay filter    |
| [Fig. 5.10]    | Coloration listening test with corrected stimuli           |

[release 2.4]: http://dx.doi.org/10.5281/zenodo.846583
[Fig. 3.13]: 03_sound_field_errors_and_their_perceptual_relevance/fig3_13
[Fig. 3.14]: 03_sound_field_errors_and_their_perceptual_relevance/fig3_14
[Fig. 3.15]: 03_sound_field_errors_and_their_perceptual_relevance/fig3_15
[Fig. 3.17]: 03_sound_field_errors_and_their_perceptual_relevance/fig3_17
[Fig. 5.8]: 05_psychoacoustics/fig5_08
[Fig. 5.9]: 05_psychoacoustics/fig5_09
[Fig. 5.10]: 05_psychoacoustics/fig5_10

### 2. Theory of Sound Field Synthesis

Chapter 2 was transferred to an online version at **http://sfstoolbox.org/**
and is further developed and corrected there. This errata mentions only
important changes and corrections to the content as presented in the thesis.

#### 2.1 Solution for Special Geometries: Near-Field Compensated Higher Order Ambisonics and Spectral Division Method

The expansion in basis functions was sloppy formulated as (2.2), (2.3),
(2.4) are only correct for compact spaces and their summation is infinite and
does not stop at a particular `N`. Changed accordingly they should read

![`
G(\mathbf{x}-\mathbf{x}_0,\omega) =
  \sum_n \tilde{G}_n(\omega)\Psi^*_n(\mathfb{x}_0)\Psi_n(\mathbf{x})
`](img/errata_eq2.2_part1.png "Eq. (2.2a)")

![`
D(\mathbf{x}_0,\omega) = \sum_n \tilde{D}_n(\omega)\Psi_n(\mathbf{x}_0)
`](img/errata_eq2.3_part1.png "Eq. (2.3a)")

![`
S(\mathbf{x},\omega) = \sum_n \tilde{S}_n(\omega)\Psi_n(\mathbf{x})
`](img/errata_eq2.4_part1.png "Eq. (2.4a)")

and are accompanied for non-compact spaces with these equations

![
`G(\mathbf{x}-\mathbf{x}_0,\omega) =
  \int \tilde{G}(\mu,\omega)\Psi^*(\mu,\mathbf{x}_0)\Psi_n(\mu,\mathbf{x}) d\mu
`](img/errata_eq2.2_part2.png "Eq. (2.2b)")

![`
D(\mathbf{x}_0,\omega) = \int \tilde{D}(\mu,\omega)\Psi(\mu,\mathbf{x}_0) d\mu
`](img/errata_eq2.3_part2.png "Eq. (2.3b)")

![`
S(\mathbf{x},\omega) = \int \tilde{S}(\mu,\omega)\Psi(\mu,\mathbf{x}) d\mu
`](img/errata_eq2.4_part2.png "Eq. (2.4b)")

where `μ` is the measure in the underlying space.

For a discussion see: https://github.com/sfstoolbox/sfs-documentation/issues/9

#### 2.5 Driving functions

Several of the driving functions for WFS presented in 2.5.2 are now updated
after the discussion presented in [Schultz (2016)], see the [WFS driving
function chapter on http://sfstoolbox.org] for more details. The remaining
discussion in this section focusses only on corrections of the driving functions
as presented in the thesis.

[Schultz (2016)]:http://rosdok.uni-rostock.de/resolve/urn/urn:nbn:de:gbv:28-diss2016-0078-1
[WFS driving function chapter on http://sfstoolbox.org]: http://sfstoolbox.org/en/latest/#driving-functions-for-wfs

The WFS driving functions for a focused source (2.71) and (2.72) have the wrong
direction in time. The equations should read

![`
D(\mathbf{x}_0,\omega) = \frac{1}{2\pi} A(\omega) w(\mathbf{x}_0)
  \left(i\frac{\omega}{c} + \frac{1}{|\mathbf{x}_0-\mathbf{x}_\text{s}|} \right)
  \frac{(\mathbf{x}_0-\mathbf{x}_\text{s})\mathbf{n}_{\mathbf{x}_0}}
       {|\mathbf{x}_0-\mathbf{x}_\text{s}|^2}
  e^{i\frac{\omega}{c} |\mathbf{x}_0-\mathbf{x}_\text{s}|}
`](img/errata_eq2.71.png "Eq. (2.71)")

![`
D_\text{2.5D}(\mathbf{x}_0,\omega) = \frac{g_0}{2\pi} A(\omega) w(\mathbf{x}_0)
  \sqrt{i\frac{\omega}{c}} \left(1 + \frac{c}{i\omega}
  \frac{1}{|\mathbf{x}_0-\mathbf{x}_\text{s}|} \right)
  \frac{(\mathbf{x}_0-\mathbf{x}_\text{s}) \mathbf{n}_{\mathbf{x}_0}}
       {|\mathbf{x}_0-\mathbf{x}_\text{s}|^2}
  e^{i\frac{\omega}{c} |\mathbf{x}_0-\mathbf{x}_\text{s}|}
`](img/errata_eq2.72.png "Eq. (2.72)")

### 3. Sound Field Errors and their Perceptual Relevance

#### 3.3 Spatial Aliasing and Discrete Secondary Source Distributions

Equation (3.5) for the selection of the maximum order of band-limited NFC-HOA
has to be slightly changed to

![`
M \le
\begin{cases}
  \frac{N_\text{s}}{2} - 1 & \text{for even } N_\text{s} \\
  \frac{(N_\text{s}-1)}{2} & \text{for odd } N_\text{s}
\end{cases}
`](img/errata_eq3.5.png "Eq. (3.5)")

### 5. Psychoacoustics of Sound Field Synthesis

The impulse responses representing the different WFS systems in the coloration
experiment were all created using integer delays. This added a few distortions
for high frequencies, which are observable in [Fig. 5.8] as the slight ripples
in the spectra for the conditions with an inter-loudspeaker distance of 0.5 cm
and 0.3 cm. We repeated the experiment by using a fractional delay method and a
sampling rate of 48 kHz which ensured that the delay line had a flat frequency
response in the region up to 44.1 kHz. Now the frequency response for the WFS
system with an inter-loudspeaker distance of 1 cm showed a flat frequency
response. The same holds for the results of the listening test presented in
[Fig. 5.10]. In the repeated listening test, the conditions for 1 cm and 2 cm
are no longer different from the reference condition. The results of the new
listening test are available at: https://doi.org/10.5281/zenodo.164592


## Software Requirements

If you want to reproduce the corrected and most up-to-date version of the
figures, please have a look at the [requirements of the sfs-2.4 branch] instead.

[requirements of the sfs-2.4 branch]: https://github.com/hagenw/phd-thesis/tree/sfs-2.4#software-requirements

### Sound Field Synthesis Toolbox for Matlab

From the [Sound Field Synthesis Toolbox for Matlab] git repository you need to
checkout commit 3730bc0, which is identical with the release 1.0.0.
Under Linux this can be done the following way:
```
$ git clone https://github.com/sfstoolbox/sfs-matlab.git
$ cd sfs-matlab
$ git checkout 3730bc0
$ cd ..
```

[Sound Field Synthesis Toolbox for Matlab]: https://github.com/sfstoolbox/sfs-matlab

### Auditory Modelling Toolbox

From my copy of the [Auditory Modelling Toolbox] git repository you need to
checkout commit aed0198. Under Linux this can be done the following way:
```
$ git clone https://github.com/hagenw/amtoolbox.git
$ cd amtoolbox
$ git checkout aed0198
$ cd ..
```

The [Auditory Modelling Toolbox] depends
further on the [Large Time-Frequency Analysis Toolbox], which you can get in
the same way:
```
$ git clone https://github.com/hagenw/ltfat.git
$ cd ltfat
$ git checkout 3f9af4a
$ cd ..
```

[Auditory Modelling Toolbox]: http://amtoolbox.sourceforge.net/
[Large Time-Frequency Analysis Toolbox]: http://ltfat.github.io

### Setting up Toolboxes in Matlab

After installing both toolboxes you have to start them first in Matlab/Octave in
oder to run the scripts provided with this PhD thesis.
This can be done by running the following commands from the `sfs-matlab/` and
`amtoolbox/` directory, respectively.
```Matlab
>> cd sfs-matlab
>> SFS_start;
>> cd ../ltfat
>> ltfatstart;
>> cd ../amtoolbox
>> amtstart;
```

### Get additional data

If you don't want to rerun all the numerical simulation, but just want to rerun
some of the plotting routines, you can download all the results of the numerical
simulations that is not directly included into this repository from
http://doi.org/10.5281/zenodo.846561

Now everything is prepared and you can start to reproduce any figure in the
thesis.

The scripts presented here were tested with Matlab 8.1.0.604 (R2013a), Octave
4.0.0, gnuplot 5.0 patchlevel 3.


## License

Copyright 2015-2018 Hagen Wierstorf

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
