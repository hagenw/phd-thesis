clear all
addpath('../../../matlab');
show_figures = 0;

%% ==== Configuration ====================================================
% get file names of wav files for binaural synthesis
get_filenames;
% listener positions
X = [ 0.00 -0.25 -0.50 -0.75 -1.00  0.00 -0.25 -0.50 -0.75 -1.00 -1.25  0.00 -0.25 -0.50 -0.75 -1.00];
Y = [ 0.75  0.75  0.75  0.75  0.75  0.00  0.00  0.00  0.00  0.00  0.00 -0.75 -0.75 -0.75 -0.75 -0.75];
% listener head orientation offset
get_listener_offset;


%% ==== Toolbox settings =================================================
conf.fs = 44100;


%% ===== Lookup table ====================================================
% load lookup table
lookup = load('lookup.mat');

% get noise signals
for nn=1:5
    noise_sig(:,nn) = localization_noise();
end

% --- point source ---
for jj=1:size(files_fs,2)
    for ii=1:size(files_fs,1)
        progress_bar(ii,size(files_fs,1));
        % load binaural impulse response
        ir = wavread(['brs/' files_fs{ii,jj}]);
        for vp=1:11
            % estiamte direction of auditory event
            for nn=1:5
                phi(ii,jj,vp,nn) = ...
                    estimate_azimuth(auralize_ir(ir(:,vp*2-1:vp*2),noise_sig(:,nn),1,conf),lookup) + ...
                    (vp-1) + offset_fs(ii,jj);
            end
        end
        % calculate direction of sound event
        phi_real(ii,jj) = deg(source_direction([X(ii) Y(ii) 0],[0 0.5 0],'fs')+pi/2);
    end
end

if show_figures
    % visual inspection for normality of the data
    for ii=1:size(files_fs,1)
        if Y(ii)~=0 && X(ii)==-1.25 % handle different length of X for different Y values
            continue;
        else
            figure; hist(phi(ii,1,:,:),-150:10:150)
            title(sprintf('WFS fs 14 loudspeaker, X = (%1.2f,%1.2f)m',X(ii),Y(ii)));
            figure; hist(phi(ii,2,:,:),-150:10:150)
            title(sprintf('WFS fs 28 loudspeaker, X = (%1.2f,%1.2f)m',X(ii),Y(ii)));
            figure; hist(phi(ii,3,:,:),-150:10:150)
            title(sprintf('WFS fs 56 loudspeaker, X = (%1.2f,%1.2f)m',X(ii),Y(ii)));
        end
    end
end

% calculate seperated means for the cases of more than one source
% use a Gaussian mixture model to find what data point belongs to what
% distribution
iterations = 100;
warning('off');
fprintf('WFS focused source 28 loudspeaker\n');
get_two_directions(phi,X,Y,10,2,iterations,phi_real);
fprintf('WFS focused source 14 loudspeaker\n');
get_two_directions(phi,X,Y,10,1,iterations,phi_real);
fprintf('WFS focused source 28 loudspeaker\n');
get_two_directions(phi,X,Y,9,2,iterations,phi_real);
fprintf('WFS focused source 14 loudspeaker\n');
get_two_directions(phi,X,Y,9,1,iterations,phi_real);
fprintf('WFS focused source 14 loudspeaker\n');
get_two_directions(phi,X,Y,8,1,iterations,phi_real);
fprintf('WFS focused source 14 loudspeaker\n');
get_two_directions(phi,X,Y,3,1,iterations,phi_real);
