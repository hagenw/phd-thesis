clear all;
addpath('../../../matlab');

%% ==== Configuration ====================================================
% get file names of wav files for binaural synthesis
files = get_filenames;
% listener positions
X = [ 0.00 -0.25 -0.50 -0.75 -1.00 -1.25 -1.50 -1.75  0.00 -0.25 -0.50 -0.75 -1.00 -1.25 -1.50 -1.75];
Y = [-1.50 -1.50 -1.50 -1.50 -1.50 -1.50 -1.50 -1.50 -2.00 -2.00 -2.00 -2.00 -2.00 -2.00 -2.00 -2.00];
% out file names
outfile = { ...
    '../wfs_nls3_linear_ps_model.txt'; ...
    '../wfs_nls8_linear_ps_model.txt'; ...
    '../wfs_nls15_linear_ps_model.txt'; ...
};
% listener head orientation offset
offset = [0 -35 -17.5];


%% ==== Toolbox settings =================================================
conf.fs = 44100;


%% ===== Lookup table ====================================================
% load lookup table
load('lookup.mat');
lookup = lookup_table;

% get noise signals
for nn=1:5
    noise_sig(:,nn) = localization_noise();
end


for jj=1:size(files,2)
    % open output file
    fid = fopen(outfile{jj},'w');
    fprintf(fid,'# X/m   Y/m  phi/deg phi_error/deg phi_error_ci/deg phi_std/deg phi_std_ci/deg\n');
    for ii=1:size(files,1)
        progress_bar(ii,size(files,1));
        % load binaural impulse response
        ir = wavread(['brs/' files{ii,jj}]);
        for vp=1:11
            phi_tmp = [];
            phi_tmp_std = [];
            % estiamte direction of auditory event
            for nn=1:5
                [phi_tmp(nn),phi_tmp_std(nn)] = wierstorf2013estimateazimuth(auralize_ir(ir(:,vp*2-1:vp*2),noise_sig(:,nn),1,conf),lookup);
                phi_tmp(nn) = phi_tmp(nn) + (vp-1);
            end
            phi_vp_mean(vp) = mean(phi_tmp);
            phi_vp_std(vp) = mean(phi_tmp_std);
        end
        phi(ii,jj) = mean(phi_vp_mean) + offset(jj);
        phi_ci(ii,jj) = ci(phi_vp_mean);
        phi_std(ii,jj) = mean(phi_vp_std); 
        phi_std_ci(ii,jj) = ci(phi_vp_std);
        % calculate direction of sound event
        phi_real(ii,jj) = deg(source_direction([X(ii) Y(ii) 0],[0 1 0],'ps')+pi/2);
        fprintf(fid,'% 5.2f  % 5.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
            X(ii),Y(ii),phi(ii,jj),abs(phi(ii,jj)-phi_real(ii,jj)),phi_ci(ii,jj),phi_std(ii,jj),phi_std_ci(ii,jj));
    end
    fclose(fid);
end
