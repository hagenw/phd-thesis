clear all;
addpath('../../matlab');
% load common SFS Toolbox settings
sfs_configuration;
% load HRTFs
hrtf = read_irs('QU_KEMAR_anechoic_3m.mat',conf);
% load lookup table
lookup = load('lookup.mat');

% settings for all loudspeaker arrays
conf.secondary_sources.size = 2.85;
conf.secondary_sources.geometry = 'linear';
nls = [3 8 15];
xs = [0 1 0];
src = 'ps';
% Listening area
X = linspace(-2,2,28);
Y = linspace(-3.1,-0.1,21);
[x,y] = meshgrid(X,Y);
x = x(:);
y = y(:);

% real direction
for ii=1:length(x)
    phi_real(ii) = deg(source_direction([x(ii) y(ii) 0],xs,src)+pi/2);
end

for nn=1:length(nls)
    conf.secondary_sources.number = nls(nn);
    x0 = secondary_source_positions(conf);
    conf.wfs.hprefhigh = aliasing_frequency(x0,conf);
    for ii=1:length(x)
        progress_bar(ii,length(x))
        conf.xref = [x(ii) y(ii) 0];
        ir(:,:,ii) = ir_wfs([x(ii) y(ii) 0],pi/2,xs,src,hrtf,conf);
    end
    [phi,phi_std] = estimate_direction(ir,lookup,5,conf);
    phi_error = abs(phi_real-phi);
    gp_save(sprintf('wfs_linear_nls%i.txt',nls(nn)),[x y phi' phi_error' phi_std'],'x/m y/m phi/deg phi_error/deg phi_std/deg');
end
