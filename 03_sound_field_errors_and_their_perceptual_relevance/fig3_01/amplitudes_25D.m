clear all

%% ===== Configuration ===================================================
X = 0; % / m
Y = [-5.5 1.5]; % / m
Z = 0; % / m
f = 1000; % / Hz


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
conf.secondary_sources.size = 100000; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'line';
conf.secondary_sources.number = 1000000;
conf.secondary_sources.x0 = [];
% get secondary sources and store them, to do this calculation only once
x0 = secondary_source_positions(conf);
conf.secondary_sources.x0 = x0;


%% ===== Reference Sources ===============================================
% --- point source ---
[P1,~,y] = sound_field_mono_point_source(X,Y,Z,[0 1 0],f,conf);
% --- line source ---
[P2,~,y] = sound_field_mono_line_source(X,Y,Z,[0 1 0],f,conf);
% --- plane wave ---
[P3,~,y] = sound_field_mono_plane_wave(X,Y,Z,[0 -1 0],f,conf);
% --- focused source ---
[P4,~,y] = sound_field_mono_point_source(X,Y,Z,[0 -1 0],f,conf);


%% ===== Wave Field Synthesis ============================================
% --- point source ---
xs = [0 1 0];
src = 'ps';
[P5,~,y] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
conf.driving_functions = 'point_source';
[P5_ps,~,y] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
conf.driving_functions = 'default';
% --- line source ---
xs = [0 1 0];
src = 'ls';
[P6,~,y] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
% --- plane wave ---
xs = [0 -1 0];
src = 'pw';
[P7,~,y] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
% --- focused source ---
xs = [0 -1 0 0 -1 0];
src = 'fs';
[P8,~,y] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);

% apply low pass filter to focused source to get rid of diffraction effects
[b,a] = butter(4,2000/22050,'low');
P9 = filtfilt(b,a,db(abs(P8)));


%% ===== Save to File ====================================================
M = [y db(abs([P1 P2 P3 P4 P5 P6 P7 P8])) P9 db(abs(P5_ps))];
header = ['y point_source line_source plane_wave focused_source WFS_25D_point_source ', ...
    'WFS_25D_line_source WFS_25D_plane_wave WFS_25D_focused_source ', ...
    'WFS_25D_focused_source_low_pass WFS_25D_point_source_wo_approx'];
gp_save('amplitudes_25D.txt',M,header);
