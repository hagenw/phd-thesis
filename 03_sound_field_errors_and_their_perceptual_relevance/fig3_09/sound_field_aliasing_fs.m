% create the data for the monochromatic sound field plots
clear all

%% ===== Configuration ===================================================
X = [-1.75 1.75]; % / m
Y = [-1.75 1.75]; % / m
Z = 0; % / m
xs = [0 0.5 0 0 -1 0];
src = 'fs';


%% ===== Toolbox settings ================================================
conf.resolution = 1000; % / samples
conf.xref = [0 0 0]; % / m
conf.dimension = '2.5D';
conf.c = 343; % / m/s
conf.driving_functions = 'default';
conf.phase = 0; % / rad
conf.usenormalisation = true;
conf.plot.useplot = false;
conf.usetapwin = false;
conf.tapwinlen = 0.3;
conf.showprogress = true;


%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 3; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.number = 64;
conf.secondary_sources.x0 = [];
x0 = secondary_source_positions(conf);
gp_save_loudspeakers('array.txt',x0);


%% ===== without aliasing ================================================
f = 1000; % / Hz
[P,x,y,~,x0] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
gp_save_matrix('sound_field_fs_1000Hz.dat',x,y,real(P));
gp_save_loudspeakers('array_wfs.txt',x0);


%% ===== with aliasing ===================================================
f = 2000; % / Hz
[P,x,y] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
gp_save_matrix('sound_field_fs_2000Hz.dat',x,y,real(P));
f = 5000; % / Hz
[P,x,y] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
gp_save_matrix('sound_field_fs_5000Hz.dat',x,y,real(P));
