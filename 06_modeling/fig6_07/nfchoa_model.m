clear all;
addpath('../../matlab');
% load common SFS Toolbox settings
sfs_configuration;
% load HRTFs
conf.N = 2048;
hrtf = read_irs('QU_KEMAR_anechoic_3m.mat',conf);
% load lookup table
load('lookup.mat');
lookup = lookup_table;


%% ===== Configuration ===================================================
xs = [0 2.5 0];
src = 'ps';
nls = 28;
conf.nfchoa.order = 14;

% Listening area
X = linspace(-2,2,28);
Y = linspace(-2,2,28);
[x,y] = meshgrid(X,Y);
x = x(:);
y = y(:);


%% ===== Secondary Sources ===============================================
% Create an array with convex and concave elements
% get smal circular arrays
conf.secondary_sources.size = 3; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.number = nls;


%% ===== Estimate directions ============================================
% normal setup
x0 = secondary_source_positions(conf);
conf.secondary_sources.x0 = x0;
gp_save_loudspeakers('array_nfchoa_circle.txt',x0);
% real direction
for ii=1:length(x)
    phi_real(ii) = deg(source_direction([x(ii) y(ii) 0],xs,src)+pi/2);
end
for ii=1:length(x)
    progress_bar(ii,length(x))
    conf.xref = [x(ii) y(ii) 0];
    ir(:,:,ii) = ir_nfchoa([x(ii) y(ii) 0],pi/2,xs,src,hrtf,conf);
end
[phi,phi_std] = estimate_direction(ir,lookup,5,conf);
phi_error = abs(phi_real-phi);
gp_save(sprintf('nfchoa_circle_nls%i_order%i.txt',nls,conf.nfchoa.order),[x y phi' phi_error' phi_std'],'x/m y/m phi/deg phi_error/deg phi_std/deg');

% jitter loudspeaker angle
conf.secondary_sources.x0 = [];
conf.secondary_sources.number = 2*28;
x0 = secondary_source_positions(conf);
idx = randperm(size(x0,1));
x0 = x0(idx(1:nls),:);
% resort angles, because the single loudspeaker have to be adjacent to each
% other for NFC-HOA
angles = cart2pol(x0(:,1),x0(:,2),zeros(28,1));
[~,idxs] = sort(angles(:,1));
% NOTE: the following will not always work due to the random process!!!
% Then you have to rearrange the source positions by yourself
tmp = x0(1:14,:);
x0(1:14,:) = x0(15:end,:);
x0(15:end,:) = tmp;

conf.secondary_sources.x0 = x0;
gp_save_loudspeakers('array_nfchoa_random_circle.txt',x0);
% real direction
for ii=1:length(x)
    phi_real(ii) = deg(source_direction([x(ii) y(ii) 0],xs,src)+pi/2);
end
for ii=1:length(x)
    progress_bar(ii,length(x))
    conf.xref = [x(ii) y(ii) 0];
    ir(:,:,ii) = ir_nfchoa([x(ii) y(ii) 0],pi/2,xs,src,hrtf,conf);
end
[phi,phi_std] = estimate_direction(ir,lookup,5,conf);
phi_error = abs(phi_real-phi);
gp_save(sprintf('nfchoa_random_circle_nls%i_order%i.txt',nls,conf.nfchoa.order),[x y phi' phi_error' phi_std'],'x/m y/m phi/deg phi_error/deg phi_std/deg');

% jitter positions
conf.secondary_sources.x0 = [];
conf.secondary_sources.number = 28;
x0 = secondary_source_positions(conf);
xoffsets = 0.05*(randn(28,1)-0.5);
yoffsets = 0.05*(randn(28,1)-0.5);
x0(:,1) = x0(:,1) + xoffsets;
x0(:,2) = x0(:,2) + yoffsets;
conf.secondary_sources.x0 = x0;
gp_save_loudspeakers('array_nfchoa_jitter.txt',x0);
% real direction
for ii=1:length(x)
    phi_real(ii) = deg(source_direction([x(ii) y(ii) 0],xs,src)+pi/2);
end
for ii=1:length(x)
    progress_bar(ii,length(x))
    conf.xref = [x(ii) y(ii) 0];
    ir(:,:,ii) = ir_nfchoa([x(ii) y(ii) 0],pi/2,xs,src,hrtf,conf);
end
[phi,phi_std] = estimate_direction(ir,lookup,5,conf);
phi_error = abs(phi_real-phi);
gp_save(sprintf('nfchoa_jitter_nls%i_order%i.txt',nls,conf.nfchoa.order),[x y phi' phi_error' phi_std'],'x/m y/m phi/deg phi_error/deg phi_std/deg');
