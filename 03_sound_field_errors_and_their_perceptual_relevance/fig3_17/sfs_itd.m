% calculate ITD values for different SFS setups
clear all
addpath('../../matlab');


%% ===== Configuration ===================================================
X = [0 0.5 1.0]; % / m
Y = [0 0 0]; % / m
Z = 0; % / m
phi = pi/2;
xs = [0 2.5 0];
src = 'ps';


%% ===== Toolbox settings ================================================
conf.xref = [0 0 0]; % / m
conf.dimension = '2.5D';
conf.c = 343; % / m/s
conf.fs = 44100; % / Hz
conf.driving_functions = 'default';
%conf.usenormalisation = false;
conf.plot.useplot = false;
conf.usetapwin = false;
conf.tapwinlen = 0.3;
conf.showprogress = false;
conf.debug = false;
conf.usefracdelay = false;
conf.fracdelay_method = 'resample';
conf.nfchoa.order = [];
conf.wfs.usehpre = true;
conf.wfs.hpretype = 'FIR';
conf.wfs.hpreflow =  10;
conf.N = 2048;
conf.ir.useinterpolation = true;
conf.ir.usehcomp = false;
conf.ir.hcompfile = '';
conf.ir.useoriglength = false;


%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 3; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.x0 = [];


%% ===== Main ============================================================
hrtf = read_irs('QU_KEMAR_anechoic_3m.mat',conf);
lookup_table = load('lookup.mat');
noise_sig = noise(44100,1,'pink');

% ----- without aliasing -------------------------------------------------
conf.secondary_sources.number = 2000;
%% --- NFCHOA
% NOTE: this will give you false results, due to numerical problems (have a look
% at the amplitude of the impulse response)
%for ii=1:length(X)
%    ir = ir_nfchoa([X(ii) Y(ii) Z],phi,xs,src,hrtf,conf);
%    [~,~,itd,~,fc] = estimate_azimuth(auralize_ir(ir,noise_sig,1,conf),lookup_table,'include_outlier');
%    gp_save(sprintf('nfchoa_X%1.2f_Y%1.2f.txt',X(ii),Y(ii)),[fc' itd']);
%end
% --- WFS
conf.wfs.hprefhigh = 20000;
for ii=1:length(X)
    ir = ir_wfs([X(ii) Y(ii) Z],phi,xs,src,hrtf,conf);
    [~,~,itd,~,fc] = estimate_azimuth(auralize_ir(ir,noise_sig,1,conf),lookup_table,'include_outlier');
    gp_save(sprintf('wfs_X%1.2f_Y%1.2f.txt',X(ii),Y(ii)),[fc' itd']);
end

% ----- with aliasing ----------------------------------------------------
conf.secondary_sources.number = 22;
% --- NFCHOA
conf.nfchoa.order = 220;
for ii=1:length(X)
    ir = ir_nfchoa([X(ii) Y(ii) Z],phi,xs,src,hrtf,conf);
    [~,~,itd,~,fc] = estimate_azimuth(auralize_ir(ir,noise_sig,1,conf),lookup_table,'include_outlier');
    gp_save(sprintf('nfchoa_X%1.2f_Y%1.2f_nls22.txt',X(ii),Y(ii)),[fc' itd']);
end
% --- band limited NFCHOA
conf.nfchoa.order = [];
for ii=1:length(X)
    ir = ir_nfchoa([X(ii) Y(ii) Z],phi,xs,src,hrtf,conf);
    [~,~,itd,~,fc] = estimate_azimuth(auralize_ir(ir,noise_sig,1,conf),lookup_table,'include_outlier');
    gp_save(sprintf('nfchoa_X%1.2f_Y%1.2f_nls22_band_limited.txt',X(ii),Y(ii)),[fc' itd']);
end 
% --- WFS
conf.wfs.hprefhigh = 1500;
for ii=1:length(X)
    ir = ir_wfs([X(ii) Y(ii) Z],phi,xs,src,hrtf,conf);
    [~,~,itd,~,fc] = estimate_azimuth(auralize_ir(ir,noise_sig,1,conf),lookup_table,'include_outlier');
    gp_save(sprintf('wfs_X%1.2f_Y%1.2f_nls22.txt',X(ii),Y(ii)),[fc' itd']);
end

