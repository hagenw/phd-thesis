% create the data for the monochromatic sound field plots
clear all


%% ===== Configuration ===================================================
X = [0 0.75 0]; % / m
Y = [0 0 0.75]; % / m
Z = 0; % / m
xs = [0 -1 0];
src = 'pw';


%% ===== Toolbox settings ================================================
conf.resolution = 1000; % / samples
conf.xref = [0 0 0]; % / m
conf.dimension = '2.5D';
conf.c = 343; % / m/s
conf.driving_functions = 'default';
conf.phase = 0; % / rad
conf.usenormalisation = false;
conf.plot.useplot = false;
conf.usetapwin = false;
conf.tapwinlen = 0.3;
conf.showprogress = false;
conf.nfchoa.order = [];


%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 3; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.x0 = [];


%% ===== without aliasing ================================================
conf.secondary_sources.number = 4000;
% --- NFCHOA
for ii=1:length(X)
    [S,f] = freq_response_nfchoa([X(ii) Y(ii) Z],xs,src,conf);
    gp_save(sprintf('freq_response_nfchoa_X%1.2f_Y%1.2f.txt',X(ii),Y(ii)),[f S]);
end
% --- WFS
for ii=1:length(X)
    [S,f] = freq_response_wfs([X(ii) Y(ii) Z],xs,src,conf);
    gp_save(sprintf('freq_response_wfs_X%1.2f_Y%1.2f.txt',X(ii),Y(ii)),[f S]);
end

% ===== with aliasing ===================================================
conf.secondary_sources.number = 64;
% --- NFCHOA
conf.nfchoa.order = 256;
for ii=1:length(X)
    [S,f] = freq_response_nfchoa([X(ii) Y(ii) Z],xs,src,conf);
    gp_save(sprintf('freq_response_nfchoa_X%1.2f_Y%1.2f_nls64.txt',X(ii),Y(ii)),[f S]);
end
% --- band limited NFCHOA
conf.nfchoa.order = [];
for ii=1:length(X)
    [S,f] = freq_response_nfchoa([X(ii) Y(ii) Z],xs,src,conf);
    gp_save(sprintf('freq_response_nfchoa_X%1.2f_Y%1.2f_nls64_band_limited.txt', ...
        X(ii),Y(ii)),[f S]);
end
% --- WFS
for ii=1:length(X)
    [S,f] = freq_response_wfs([X(ii) Y(ii) Z],xs,src,conf);
    gp_save(sprintf('freq_response_wfs_X%1.2f_Y%1.2f_nls64.txt',X(ii),Y(ii)),[f S]);
end
