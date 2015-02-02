clear all;
addpath('../../matlab');
% load common SFS Toolbox settings
sfs_configuration;
% load HRTFs
hrtf = read_irs('QU_KEMAR_anechoic_3m.mat',conf);
% load lookup table
load('lookup.mat');
lookup = lookup_table;

% settings for all loudspeaker arrays
conf.secondary_sources.size = 3.2;
conf.secondary_sources.geometry = 'box';
nls = 40;
xs = [-1 -1 0];
src = 'pw';
% Listening area
X = linspace(-1.8,1.8,28);
Y = linspace(-1.8,1.8,28);
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
    gp_save(sprintf('wfs_box_nls%i.txt',nls(nn)),[x y phi' phi_error' phi_std'],'x/m y/m phi/deg phi_error/deg phi_std/deg');
    gp_save_loudspeakers(sprintf('array_box_nls%i.txt',nls(nn)),x0);
    x0 = secondary_source_selection(x0,xs,src);
    gp_save_loudspeakers(sprintf('array_box_nls%i_wfs.txt',nls(nn)),x0);
end
