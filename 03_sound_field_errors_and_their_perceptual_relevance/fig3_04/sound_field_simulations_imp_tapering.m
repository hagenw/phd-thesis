% create sound field simulations for a linear array and WFS with and without
% tapering window to show the edge waves
clear all;


%% ===== Configuration ===================================================
X = [-1.25 1.25]; % / m
Y = [-2.25 0.25]; % / m
Z = 0; % / m
t = 205; % / samples
xs = [0 -1 0];
src = 'pw';


%% ===== Toolbox settings ================================================
conf.debug = false;
conf.resolution = 1000; % / samples
conf.xref = [4.5 -2 0]; % / m
conf.dimension = '2.5D';
conf.c = 343; % / m/s
conf.fs = 44100; % / Hz
conf.N = 1024;
conf.wfs.usehpre = true;
conf.wfs.hprefhigh = 20000;
conf.wfs.hpreflow = 50;
conf.wfs.hpretype = 'FIR';
conf.usebandpass = true;
conf.bandpassflow = 10;
conf.bandpassfhigh = 20000;
conf.usefracdelay = true;
conf.fracdelay_method = 'resample';
conf.driving_functions = 'default';
conf.phase = 0; % / rad
conf.usenormalisation = false;
conf.plot.useplot = false;
conf.tapwinlen = 0.06;
conf.showprogress = true;


%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 10;
conf.secondary_sources.number = 1000;
conf.secondary_sources.geometry = 'line';
conf.secondary_sources.center = [4.5 0 0];
conf.secondary_sources.x0 = [];
x0 = secondary_source_positions(conf);
x0 = secondary_source_selection(x0,xs,src);
gp_save_loudspeakers('array.txt',x0);


%% ===== Time signal ======================================================
% get time signal to visualize driving signals
pulse = [hann_window(5,5,10); zeros(50,1); hann_window(5,5,10); ...
    zeros(50,1); hann_window(5,5,10)];

%% ===== Get driving signals =============================================
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);

%% Without tapering ======================================================
conf.usetapwin = false;
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t,conf);
gp_save_matrix('wfs_notapering.dat',x,y,p);


%% With tapering =========================================================
conf.usetapwin = true;
x0 = secondary_source_tapering(x0,conf);
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t,conf);
gp_save_matrix('wfs_tapering.dat',x,y,p);
