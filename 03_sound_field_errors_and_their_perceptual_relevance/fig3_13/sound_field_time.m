% create sound field simulations for a linear array and WFS with and without
% tapering window to show the edge waves
clear all;


%% ===== Configuration ===================================================
X = [-1.75 1.75]; % / m
Y = [-1.75 1.75]; % / m
Z = 0; % / m
t = 205; % / samples
xs = [0 -1 0];
src = 'pw';


%% ===== Toolbox settings ================================================
conf.debug = false;
conf.resolution = 1000; % / samples
conf.xref = [0 0 0]; % / m
conf.dimension = '2.5D';
conf.c = 343; % / m/s
conf.fs = 44100; % / Hz
conf.N = 1024;
conf.wfs.usehpre = true;
conf.wfs.hprefhigh = 20000;
conf.wfs.hpreflow = 50;
conf.wfs.hpretype = 'FIR';
conf.nfchoa.order = [];
conf.usebandpass = true;
conf.bandpassflow = 10;
conf.bandpassfhigh = 20000;
conf.usefracdelay = true;
conf.fracdelay_method = 'resample';
conf.driving_functions = 'default';
conf.phase = 0; % / rad
conf.usenormalisation = true;
conf.plot.useplot = false;
conf.usetapwin = false;
conf.tapwinlen = 0.3;
conf.showprogress = true;


%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 3;
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.center = [0 0 0];
conf.secondary_sources.x0 = [];


%% ===== Time signal ======================================================
% get time signal to visualize driving signals
pulse = hann_window(5,5,10);

%% ===== Continuous secondary sources =====================================
conf.secondary_sources.number = 500;
x0 = secondary_source_positions(conf);
% --- NFCHOA
d = driving_function_imp_nfchoa(x0,xs,src,conf);
d = convolution(d,pulse);
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t,conf);
gp_save_loudspeakers('array.txt',x0);
gp_save_matrix('nfchoa.dat',x,y,p);
% --- WFS
x0 = secondary_source_selection(x0,xs,src);
x0 = secondary_source_tapering(x0,conf);
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t+64,conf);
gp_save_loudspeakers('array_wfs.txt',x0);
gp_save_matrix('wfs.dat',x,y,p);

%% ===== Sampled swecondary sources ======================================
conf.secondary_sources.number = 64;
x0 = secondary_source_positions(conf);
% --- NFCHOA
conf.nfchoa.order = 256;
d = driving_function_imp_nfchoa(x0,xs,src,conf);
d = convolution(d,pulse);
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t,conf);
gp_save_loudspeakers('array_nls64.txt',x0);
gp_save_matrix('nfchoa_nls64.dat',x,y,p);
% --- NFCHOA band limited
conf.nfchoa.order = [];
d = driving_function_imp_nfchoa(x0,xs,src,conf);
d = convolution(d,pulse);
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t,conf);
gp_save_matrix('nfchoa_nls64_band_limited.dat',x,y,p);
% --- WFS
x0 = secondary_source_selection(x0,xs,src);
x0 = secondary_source_tapering(x0,conf);
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t+64,conf);
gp_save_loudspeakers('array_wfs_nls64.txt',x0);
gp_save_matrix('wfs_nls64.dat',x,y,p);
