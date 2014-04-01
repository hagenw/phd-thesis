clear all


%% ===== Configuration ===================================================
X = [-1.75 1.75]; % / m
Y = [-3 0.25]; % / m
Z = 0; % / m
xs = [0 -1 0 0 -1 0];
src = 'fs';
f = 2000; % / Hz

%% ===== Toolbox settings ================================================
conf.resolution = 1000; % / samples
conf.xref = [0 -2 0]; % / m
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
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'line';
conf.secondary_sources.number = 100;
conf.secondary_sources.x0 = [];


%% ===== Wave Field Synthesis ============================================
conf.secondary_sources.size = 10; % / m
[P,x,y,~,x0] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
gp_save_matrix('focal_point_10m.dat',x,y,real(P));
gp_save_loudspeakers('array_10m.txt',x0);
conf.secondary_sources.size = 1.8; % / m
[P,x,y,~,x0] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
gp_save_matrix('focal_point_1.8m.dat',x,y,real(P));
gp_save_loudspeakers('array_1.8m.txt',x0);
conf.secondary_sources.size = 0.75; % / m
[P,x,y,~,x0] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
gp_save_matrix('focal_point_0.75m.dat',x,y,real(P));
gp_save_loudspeakers('array_0.75m.txt',x0);
