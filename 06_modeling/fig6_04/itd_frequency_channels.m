clear all;
addpath('../../matlab');

% load common SFS Toolbox settings
sfs_configuration;
conf.secondary_sources.size = 3;
conf.secondary_sources.geometry = 'circular';

% load HRTFs
hrtf = read_irs('QU_KEMAR_anechoic_3m.mat',conf);

% listener position
X = [-0.75 0 0];
phi = pi/2;

sig_noise = localization_noise();

% === WFS focused source ===
xs = [0 0.5 0 0 -1 0];
src = 'fs';
nls = [14 28 56];
for nn=1:length(nls)
    % loudspeaker array
    conf.secondary_sources.number = nls(nn);
    % calculate upper limit of pre-equalization filter
    x0 = secondary_source_positions(conf);
    conf.wfs.hprefhigh = aliasing_frequency(x0,conf);
    conf.xref = X;
    ir = ir_wfs(X,phi,xs,src,hrtf,conf);
    sig = auralize_ir(ir,sig_noise,1,conf);
    binaural_map = calculate_binaural_map(sig(1:length(sig_noise),:),conf.fs,'dietz');
    [signal_strength,fc] = calculate_signal_strength(sig(1:length(sig_noise),:),conf.fs);
    % store data
    filename = sprintf('wfs_nls%i_X%.2f_Y%.2f_%s.txt',conf.secondary_sources.number,X(1),X(2),src);
    gp_save(filename,[binaural_map signal_strength]);
end

% === WFS point source ===
xs = [0 2.5 0];
src = 'ps';
nls = [14 28 56];
for nn=1:length(nls)
    % loudspeaker array
    conf.secondary_sources.number = nls(nn);
    % calculate upper limit of pre-equalization filter
    x0 = secondary_source_positions(conf);
    conf.wfs.hprefhigh = aliasing_frequency(x0,conf);
    conf.xref = X;
    ir = ir_wfs(X,phi,xs,src,hrtf,conf);
    sig = auralize_ir(ir,sig_noise,1,conf);
    binaural_map = calculate_binaural_map(sig(1:length(sig_noise),:),conf.fs,'dietz');
    [signal_strength,fc] = calculate_signal_strength(sig(1:length(sig_noise),:),conf.fs);
    % store data
    filename = sprintf('wfs_nls%i_X%.2f_Y%.2f_%s.txt',conf.secondary_sources.number,X(1),X(2),src);
    gp_save(filename,[binaural_map signal_strength]);
end

% === NFC-HOA point source ===
nls = [14 28 56 14];
for nn=1:length(nls)
    if nn<4
        conf.nfchoa.order = nls(nn)/2;
    else
        conf.nfchoa.order = 28;
    end
    % loudspeaker array
    conf.secondary_sources.number = nls(nn);
    % calculate upper limit of pre-equalization filter
    x0 = secondary_source_positions(conf);
    conf.wfs.hprefhigh = aliasing_frequency(x0,conf);
    conf.xref = X;
    ir = ir_nfchoa(X,phi,xs,src,hrtf,conf);
    sig = auralize_ir(ir,sig_noise,1,conf);
    binaural_map = calculate_binaural_map(sig(1:length(sig_noise),:),conf.fs,'dietz');
    [signal_strength,fc] = calculate_signal_strength(sig(1:length(sig_noise),:),conf.fs);
    % store data
    filename = sprintf('nfchoa_nls%i_order%i_X%.2f_Y%.2f_%s.txt',conf.secondary_sources.number,conf.nfchoa.order,X(1),X(2),src);
    gp_save(filename,[binaural_map signal_strength]);
end
