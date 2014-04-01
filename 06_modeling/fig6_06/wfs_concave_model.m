clear all;
addpath('../../matlab');
% load common SFS Toolbox settings
sfs_configuration;
% load HRTFs
conf.N = 2048;
hrtf = read_irs('QU_KEMAR_anechoic_3m.mat',conf);
% load lookup table
lookup = load('lookup.mat');
conf.usetapwin = false;
%conf.N = 4096;


%% ===== Configuration ===================================================
xs = [0 1.5 0];
src = 'ps';
nls = 10;

% Listening area
X = linspace(-2,2,28);
Y = linspace(0.4,-3.6,28);
[x,y] = meshgrid(X,Y);
x = x(:);
y = y(:);


%% ===== Secondary Sources ===============================================
% Create an array with convex and concave elements
% get smal circular arrays
conf.secondary_sources.size = 1; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.number = nls;
conf.secondary_sources.x0 = [];
% get secondary sources and store them, to do this calculation only once
x0 = secondary_source_positions(conf);
% first half
h1 = x0(1:nls/2+1,:);
% second half
h2 = x0(nls/2+2:nls,:);
h2(:,5) = -1*h2(:,5); % change direction of sources
% create new array
x00 = h1;                                    % center
x01 = bsxfun(@plus,h2,[1 0 0 0 0 0 0]);      % first right
x_01 = bsxfun(@plus,h2,[-1 0 0 0 0 0 0]);    % first left
x02 = bsxfun(@plus,h1,[2 0 0 0 0 0 0]);      % second right
x02 = x02(x02(:,1)<2,:);
x_02 = bsxfun(@plus,h1,[-2 0 0 0 0 0 0]);    % second left
x_02 = x_02(x_02(:,1)>-2,:);
x0 = [x_02; x_01; x00; x01; x02]; % put all together
conf.secondary_sources.x0 = x0;              % store it
gp_save_loudspeakers('concave_array.txt',x0);
x0 = secondary_source_selection(x0,xs,src);
gp_save_loudspeakers('concave_array_selected.txt',x0);


%% ===== Estimate directions ============================================
% real direction
for ii=1:length(x)
    phi_real(ii) = deg(source_direction([x(ii) y(ii) 0],xs,src)+pi/2);
end

x0 = secondary_source_positions(conf);
conf.wfs.hprefhigh = aliasing_frequency(x0,conf);
for ii=1:length(x)
    progress_bar(ii,length(x))
    conf.xref = [x(ii) y(ii) 0];
    ir(:,:,ii) = ir_wfs([x(ii) y(ii) 0],pi/2,xs,src,hrtf,conf);
end
[phi,phi_std] = estimate_direction(ir,lookup,5,conf);
phi_error = abs(phi_real-phi);
gp_save(sprintf('wfs_concave_nls%i.txt',nls),[x y phi' phi_error' phi_std'],'x/m y/m phi/deg phi_error/deg phi_std/deg');
