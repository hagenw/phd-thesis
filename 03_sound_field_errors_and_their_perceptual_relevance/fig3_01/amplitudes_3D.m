clear all

%% ===== Configuration ===================================================
X = -2; % / m
Y = [-4.75 1.75]; % / m
Z = 0; % / m
f = 1000; % / Hz


%% ===== Toolbox settings ================================================
conf.resolution = 1000; % / samples
conf.xref = [0 -2 0]; % / m
conf.dimension = '3D';
conf.c = 343; % / m/s
conf.driving_functions = 'default';
conf.phase = 0; % / rad
conf.usenormalisation = true;
conf.plot.useplot = false;
conf.usetapwin = false;
conf.tapwinlen = 0.3;
conf.showprogress = true;


%% ===== Secondary Sources ===============================================
% Create planar array
conf.secondary_sources.size = 100; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'sphere';
conf.secondary_sources.grid = 'equally_spaced_points';
conf.secondary_sources.number = 6561;
conf.secondary_sources.x0 = [];
x0 = secondary_source_positions(conf);
%% get distance between sources
%dx0 = secondary_source_distance(x0,1);
%% create matrix
%nls = conf.secondary_sources.number;
%x0 = repmat(x0,[nls 1]);
%for ii=1:nls-1
%    x0(ii*nls+1:(ii+1)*nls,:) = ...
%        bsxfun(@plus,x0(ii*nls+1:(ii+1)*nls,:),[0 0 dx0 0 0 0 0]);
%end
conf.secondary_sources.x0 = x0;


%% ===== Reference Sources ===============================================
% --- point source ---
[P1,~,y] = sound_field_mono_point_source(X,Y,Z,[0 51 0],f,conf);
% --- line source ---
[P2,~,y] = sound_field_mono_line_source(X,Y,Z,[0 51 0],f,conf);
% --- plane wave ---
[P3,~,y] = sound_field_mono_plane_wave(X,Y,Z,[0 -1 0],f,conf);
% --- focused source ---
[P4,~,y] = sound_field_mono_point_source(X,Y,Z,[0 -1 0],f,conf);


%% ===== Wave Field Synthesis ============================================
% --- point source ---
xs = [0 51 0];
src = 'ps';
[P5,~,y] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
% --- line source ---
xs = [0 51 0];
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


%% ===== Save to File ====================================================
M = [y db(abs([P1 P2 P3 P4 P5 P6 P7 P8]))];
header = ['y point_source line_source plane_wave focused_source WFS_3D_point_source ', ...
    'WFS_3D_line_source WFS_3D_plane_wave WFS_3D_focused_source'];
gp_save('amplitudes_3D.txt',M,header);
