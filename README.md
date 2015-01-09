Perceptual Assessment of Sound Field Synthesis
==========

This repository provides you the following PhD thesis, together with all the
software you need to reproduce all figures presented in the thesis.

[Hagen Wierstorf - Perceptual Assessment of Sound Field
Synthesis](wierstorf2014-perceptual_assessment_of_sound_field_synthesis.pdf)

[![Titlepage](img/thesis_titlepage.png)](wierstorf2014-perceptual_assessment_of_sound_field_synthesis.pdf)

The software is spread in different directories named after the chapter and
figure numbers. In order to run the code you will need the external toolboxes
mentioned below and Matlab or Octave. Some of the code runs only in Octave at
the moment, but it should be easily adoptable to Matlab. A README in the
corresponding directory is indicating those cases.

## Requirements

### Sound Field Synthesis Toolbox

From the [Sound Field Synthesis Toolbox](https://github.com/sfstoolbox/sfs) git
repository you need to checkout the version *commit 3730bc0*, which is identical
with release 1.0.0. Under Linux this can be done the following way:
```Bash
$ git clone https://github.com/sfstoolbox/sfs.git
$ cd sfs
$ git checkout 3730bc0
```

After that you have to start the toolbox under Matlab/Octave by
```Matlab
>> SFS_start
```
which can be found in the main `sfs` dir.


### Auditory Modelling Toolbox

From the [Auditory Modelling Toolbox](http://amtoolbox.sourceforge.net/) git
repository you need to checkout the version *commit aed0198*. Under Linux this
can be done the following way:
```Bash
$ git clone https://github.com/hagenw/amtoolbox.git
$ cd amtoolbox
$ git checkout aed0198
```

The [Auditory Modelling Toolbox](http://amtoolbox.sourceforge.net/) depends
further on the [Large Time-Frequency Analysis
Toolbox](https://github.com/hagenw/ltfat.git), which you can get in the same
way:
```Bash
$ git clone https://github.com/hagenw/ltfat.git
$ cd ltfat
$ git checkout 3f9af4a
```

### Setting up Toolboxes in Matlab

After installing both toolboxes you have to start them first in Matlab/Octave in
oder to run the scripts provided with this PhD thesis.
This can be done by running the following commands from the `sfs/` and
`amtoolbox` directory, respectively.
```Matlab
>> cd sfs
>> SFS_start;
>> cd ../amtoolbox
>> amtstart;
```

Now everything is prepared and you can start to reproduce any figure in the
thesis.
