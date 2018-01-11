Perceptual Assessment of Sound Field Synthesis
==============================================

This repository provides you the following PhD thesis, together with
[Errata](http://nbviewer.jupyter.org/github/hagenw/phd-thesis/blob/master/ERRATA.ipynb)
and all the software you need to reproduce all figures presented in the
thesis.

[Hagen Wierstorf - Perceptual Assessment of Sound Field
Synthesis](http://dx.doi.org/10.14279/depositonce-4310)

[![Titlepage](img/thesis_titlepage.png)](http://dx.doi.org/10.14279/depositonce-4310)

The software is spread in different directories named after the chapter and
figure numbers. In order to run the code you will need the external toolboxes
mentioned below and Matlab or Octave. Some of the code runs only in Octave at
the moment, but it should be easily adoptable to Matlab. A README in the
corresponding directory is indicating those cases.

## Software Requirements

### Sound Field Synthesis Toolbox

From the [Sound Field Synthesis
Toolbox](https://github.com/sfstoolbox/sfs-matlab) git repository you need to
checkout the version *commit 3730bc0*, which is identical with release 1.0.0.
Under Linux this can be done the following way:
```
$ git clone https://github.com/sfstoolbox/sfs-matlab.git
$ cd sfs-matlab
$ git checkout 3730bc0
$ cd ..
```


### Auditory Modelling Toolbox

From the [Auditory Modelling Toolbox](http://amtoolbox.sourceforge.net/) git
repository you need to checkout the version *commit aed0198*. Under Linux this
can be done the following way:
```
$ git clone https://github.com/hagenw/amtoolbox.git
$ cd amtoolbox
$ git checkout aed0198
$ cd ..
```

The [Auditory Modelling Toolbox](http://amtoolbox.sourceforge.net/) depends
further on the [Large Time-Frequency Analysis
Toolbox](https://github.com/hagenw/ltfat.git), which you can get in the same
way:
```
$ git clone https://github.com/hagenw/ltfat.git
$ cd ltfat
$ git checkout 3f9af4a
$ cd ..
```

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
simulation that is not directly included into this repository from
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
