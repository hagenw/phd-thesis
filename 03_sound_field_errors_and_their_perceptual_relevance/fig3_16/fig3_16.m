% create sound field simulations for a linear array and WFS with and without
% tapering window to show the edge waves
clear all;
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
X = [0 0.75 0]; % / m
Y = [0 0 -0.75]; % / m
Z = [0 0 0]; % / m
t = (1:500)'; % / samples
xs = [0 0.5 0 0 -1 0];
src = 'fs';

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
conf.wfs.hpreflow = 1;
conf.wfs.hpretype = 'FIR';
conf.nfchoa.order = [];
conf.usebandpass = true;
conf.bandpassflow = 10;
conf.bandpassfhigh = 20000;
conf.usefracdelay = true;
conf.fracdelay_method = 'resample';
conf.driving_functions = 'default';
conf.phase = 0; % / rad
conf.usenormalisation = false;
conf.plot.useplot = false;
conf.usetapwin = false;
conf.tapwinlen = 0.3;
conf.showprogress = false;

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
% --- WFS
x0 = secondary_source_selection(x0,xs,src);
x0 = secondary_source_tapering(x0,conf);
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        progress_bar(ii,length(t))
        % add 64 samples offset to the time because of the pre-equalization
        % filter
        p(ii) = sound_field_imp(X(jj),Y(jj),Z(jj),x0,'ps',d,t(ii)+64,conf);
    end
    gp_save(sprintf('data/wfs_X%.2f_Y%.2f.txt',X(jj),Y(jj)),[t/conf.fs p]);
end

%% ===== Sampled swecondary sources ======================================
conf.secondary_sources.number = 64;
x0 = secondary_source_positions(conf);
% --- WFS
x0 = secondary_source_selection(x0,xs,src);
x0 = secondary_source_tapering(x0,conf);
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        progress_bar(ii,length(t))
        % add 64 samples offset to the time because of the pre-equalization
        % filter
        p(ii) = sound_field_imp(X(jj),Y(jj),Z(jj),x0,'ps',d,t(ii)+64,conf);
    end
    gp_save(sprintf('data/wfs_X%.2f_Y%.2f_nls64.txt',X(jj),Y(jj)), ...
            [t/conf.fs p]);
end
