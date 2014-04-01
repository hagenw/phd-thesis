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

% --- plane wave ---
for jj=1:size(files_pw,2)
    for ii=1:size(files_pw,1)
        progress_bar(ii,size(files_pw,1));
        % load binaural impulse response
        ir = wavread(['brs/' files_pw{ii,jj}]);
        for vp=1:11
            % estiamte direction of auditory event
            for nn=1:5
                phi(ii,jj,vp,nn) = ...
                    estimate_azimuth(auralize_ir(ir(:,vp*2-1:vp*2),noise_sig(:,nn),1,conf),lookup) + ...
                    (vp-1) + offset_pw(ii,jj);
            end
        end
        % calculate direction of sound event
        phi_real(ii,jj) = deg(source_direction([X(ii) Y(ii) 0],[0 -1 0],'pw')+pi/2);
    end
end

if show_figures
    % visual inspection for normality of the data
    for ii=1:size(files_ps,1)
        if Y(ii)~=0 && X(ii)==-1.25 % handle different length of X for different Y values
            continue;
        else
            figure; hist(phi(ii,1,:,:),-150:10:150)
            title(sprintf('NFC-HOA pw 14 loudspeaker, 7th order, X = (%1.2f,%1.2f)m',X(ii),Y(ii)));
            figure; hist(phi(ii,2,:,:),-150:10:150)
            title(sprintf('NFC-HOA pw 28 loudspeaker, 14th order, X = (%1.2f,%1.2f)m',X(ii),Y(ii)));
            figure; hist(phi(ii,3,:,:),-150:10:150)
            title(sprintf('NFC-HOA pw 56 loudspeaker, 28th order, X = (%1.2f,%1.2f)m',X(ii),Y(ii)));
            figure; hist(phi(ii,4,:,:),-150:10:150)
            title(sprintf('NFC-HOA pw 14 loudspeaker, 28th order, X = (%1.2f,%1.2f)m',X(ii),Y(ii)));
        end
    end
end

return

% calculate seperated means for the cases of more than one source
% use a Gaussian mixture model to find what data point belongs to what
% distribution
iterations = 100;
warning('off');
fprintf('NFC-HOA plane wave 14 loudspeaker, 7th order\n');
get_two_directions(phi,X,Y,16,1,iterations,phi_real);
fprintf('NFC-HOA plane wave 14 loudspeaker, 7th order\n');
get_two_directions(phi,X,Y,4,1,iterations,phi_real);
