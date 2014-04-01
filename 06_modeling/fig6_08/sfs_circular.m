clear all;
addpath('../../matlab');
% load common SFS Toolbox settings
sfs_configuration;
% load HRTFs
hrtf = read_irs('QU_KEMAR_anechoic_3m.mat',conf);
% load lookup table
lookup = load('lookup.mat');
% resolution
resolution = 100; % has to be even

% settings for all loudspeaker arrays
conf.secondary_sources.size = 3;
conf.secondary_sources.geometry = 'circular';
nls = [14 28 56];
xs = [0 2.5 0];
src = 'ps';
% Listening area
X = linspace(-2,2,resolution);
Y = linspace(-2,2,resolution);
[x,y] = meshgrid(X,Y);
x = x(:);
y = y(:);
phi = pi/2;

% limit for circular array. outside of this radius no points will be calculated
limit = 1.4;

% repetitions of the model at each position
model_repetitions = 5;

% real direction
for ii=1:length(x)
    phi_real(ii) = deg(source_direction([x(ii) y(ii) 0],xs,src)+pi/2);
end

% === Stereo ===
x0 = [ 1.4434 2.5 0 0 -1 0 1; ...
      -1.4434 2.5 0 0 -1 0 1];
for ii=1:length(x)
    progress_bar(ii,length(x))
    ir(:,:,ii) = ir_generic([x(ii) y(ii) 0],pi/2,x0,[1 1],hrtf,conf);
end
[phi,phi_std] = estimate_direction(ir,lookup,model_repetitions,conf);
phi_error = abs(phi_real-phi);
gp_save_matrix('stereo.dat',X,Y,reshape(phi_error,resolution,resolution));


% === WFS ===
for nn=1:length(nls)
    conf.secondary_sources.number = nls(nn);
    x0 = secondary_source_positions(conf);
    conf.wfs.hprefhigh = aliasing_frequency(x0,conf);
    for ii=1:length(x)
        progress_bar(ii,length(x))
        pos = [x(ii) y(ii) 0];
        if norm(pos)>=limit
            phi(ii) = 90;
        else
            conf.xref = pos;
            phi(ii) = estimate_direction(ir_wfs(pos,pi/2,xs,src,hrtf,conf),lookup,model_repetitions,conf);
        end
    end
    phi_error = abs(phi_real-phi);
    gp_save_matrix(sprintf('wfs_circular_nls%i.dat',nls(nn)),X,Y,reshape(phi_error,resolution,resolution));
end

% === band-limited NFC-HOA ===
conf.nfchoa.order = [];
for nn=1:length(nls)
    conf.secondary_sources.number = nls(nn);
    x0 = secondary_source_positions(conf);
    conf.wfs.hprefhigh = aliasing_frequency(x0,conf);
    for ii=1:length(x)
        progress_bar(ii,length(x))
        pos = [x(ii) y(ii) 0];
        if norm(pos)>=limit
            phi(ii) = 90;
        else
            conf.xref = pos;
            phi(ii) = estimate_direction(ir_nfchoa(pos,pi/2,xs,src,hrtf,conf),lookup,model_repetitions,conf);
        end
    end
    phi_error = abs(phi_real-phi);
    gp_save_matrix(sprintf('nfchoa_band-limited_nls%i.dat',nls(nn)),X,Y,reshape(phi_error,resolution,resolution));
end

% === NFC-HOA ===
conf.nfchoa.order = 28;
nls = 14;
conf.secondary_sources.number = nls;
x0 = secondary_source_positions(conf);
conf.wfs.hprefhigh = aliasing_frequency(x0,conf);
for ii=1:length(x)
    progress_bar(ii,length(x))
    pos = [x(ii) y(ii) 0];
    if norm(pos)>=limit
        phi(ii) = 90;
    else
        conf.xref = [x(ii) y(ii) 0];
        phi(ii) = estimate_direction(ir_wfs([x(ii) y(ii) 0],pi/2,xs,src,hrtf,conf),lookup,model_repetitions,conf);
    end
end
phi_error = abs(phi_real-phi);
gp_save_matrix('nfchoa_order28_nls14.dat',X,Y,reshape(phi_error,resolution,resolution));

% vim: set textwidth=200:
