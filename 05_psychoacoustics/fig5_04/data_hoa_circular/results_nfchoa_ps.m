clear all
% get common config data
configuration;
% get subject data file names
get_filenames;


% === NFC-HOA Point Source ===============================================
% get the results for every single person
for nn=1:size(files_ps,1)
    for yy=1:length(Y)
        [tmp_sfs14_mean, ...
         tmp_sfs14_std, ...
         tmp_sfs14_real, ...
         tmp_sfs28_mean, ...
         tmp_sfs28_std, ...
         tmp_sfs28_real, ...
         tmp_sfs56_mean, ...
         tmp_sfs56_std, ...
         tmp_sfs56_real, ...
         tmp_sfs1456_mean, ...
         tmp_sfs1456_std, ...
         tmp_sfs1456_real, ...
         tmp_speaker_mean, ...
         tmp_speaker_std, ...
         tmp_speaker_real] = get_single_data(files_ps{nn,yy},nconditions(yy));
        % store in cell
        sfs14_mean(:,nn,yy)   = {tmp_sfs14_mean};
        sfs14_std(:,nn,yy)    = {tmp_sfs14_std};
        sfs14_real(:,nn,yy)   = {tmp_sfs14_real};
        sfs28_mean(:,nn,yy)   = {tmp_sfs28_mean};
        sfs28_std(:,nn,yy)    = {tmp_sfs28_std};
        sfs28_real(:,nn,yy)   = {tmp_sfs28_real};
        sfs56_mean(:,nn,yy)   = {tmp_sfs56_mean};
        sfs56_std(:,nn,yy)    = {tmp_sfs56_std};
        sfs56_real(:,nn,yy)   = {tmp_sfs56_real};
        sfs1456_mean(:,nn,yy) = {tmp_sfs1456_mean};
        sfs1456_std(:,nn,yy)  = {tmp_sfs1456_std};
        sfs1456_real(:,nn,yy) = {tmp_sfs1456_real};
        speaker_mean(:,nn,yy) = {tmp_speaker_mean};
        speaker_std(:,nn,yy)  = {tmp_speaker_std};
        speaker_real(:,nn,yy) = {tmp_speaker_real};
    end
end

% Calculate the average standard deviation over all loudspeaker setups for every
% listener. Afterwards build the mean and confidence interval over all listeners
tmp14 = [cell2mat(sfs14_std(1,:,1)); cell2mat(sfs14_std(1,:,2)); ...
             cell2mat(sfs14_std(1,:,3))];
tmp28 = [cell2mat(sfs28_std(1,:,1)); cell2mat(sfs28_std(1,:,2)); ...
             cell2mat(sfs28_std(1,:,3))];
tmp56 = [cell2mat(sfs56_std(1,:,1)); cell2mat(sfs56_std(1,:,2)); ...
             cell2mat(sfs56_std(1,:,3))];
tmp1456 = [cell2mat(sfs1456_std(1,:,1)); cell2mat(sfs1456_std(1,:,2)); ...
             cell2mat(sfs1456_std(1,:,3))];
% Remove the results for the positions with more than one auditory event
tmp14([4:5 9:11],:) = NaN;
tmp = [tmp14; tmp28; tmp56; tmp1456];
std_dev14 = nanmean(tmp14,1);
std_dev28 = nanmean(tmp28,1);
std_dev56 = nanmean(tmp56,1);
std_dev1456 = mean(tmp1456,1);
std_y1 = mean([tmp14(1:3,:); tmp28(1:5,:); tmp56(1:5,:); tmp1456(1:5,:)],1);
std_y2 = mean([tmp14(6:8,:); tmp28(6:11,:); tmp56(6:11,:); tmp1456(6:11,:)],1);
std_y3 = mean([tmp14(12:16,:); tmp28(12:16,:); tmp56(12:16,:); tmp1456(12:16,:)],1);
std_dev = nanmean(tmp,1);
file = '../std_hoa_circular_ps.txt';
fid = fopen(file,'w');
fprintf(fid,'# average over all loudspeaker arrays and positions\n');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f\n\n\n',mean(std_dev),ci(std_dev));
fprintf(fid,'# 14 loudspeakers, order 7, average over positions\n');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f\n\n',mean(std_dev14),ci(std_dev14));
fprintf(fid,'# 28 loudspeakers, order 14, average over positions\n');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f\n\n',mean(std_dev28),ci(std_dev28));
fprintf(fid,'# 56 loudspeakers, order 28, average over positions\n');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f\n\n',mean(std_dev56),ci(std_dev56));
fprintf(fid,'# 14 loudspeakers, order 28, average over positions\n');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f\n\n\n',mean(std_dev1456),ci(std_dev1456));
fprintf(fid,'# Y = 0.75m, average over loudspeaker arrays\n');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f\n\n',mean(std_y3),ci(std_y3));
fprintf(fid,'# Y = 0.00m, average over loudspeaker arrays\n');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f\n\n',mean(std_y2),ci(std_y2));
fprintf(fid,'# Y = -0.75m, average over loudspeaker arrays\n');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f',mean(std_y1),ci(std_y1));
fclose(fid);
% calculate the mean about the subjects.
% subtract the real position of the virtual sources to get only the deviation
sfs14_phi ={};
sfs14_phi_ci = {};
sfs14_phi_std = {};
sfs14_phi_std_ci = {};
sfs28_phi = {};
sfs28_phi_ci = {};
sfs28_phi_std = {};
sfs28_phi_std_ci = {};
sfs56_phi = {};
sfs56_phi_ci = {};
sfs56_phi_std = {};
sfs56_phi_std_ci = {};
sfs1456_phi = {};
sfs1456_phi_ci = {};
sfs1456_phi_std = {};
sfs1456_phi_std_ci = {};
for yy=1:length(Y)
    sfs14_phi(:,yy) = mean(cell2mat(sfs14_mean(:,:,yy)),2) - cell2mat(sfs14_real(:,1,yy));
    sfs14_phi_ci(:,yy) = ci(cell2mat(sfs14_mean(:,:,yy)),2);
    sfs14_phi_std(:,yy) = mean(cell2mat(sfs14_std(:,:,yy)),2);
    sfs14_phi_std_ci(:,yy) = ci(cell2mat(sfs14_std(:,:,yy)),2);
    sfs28_phi(:,yy) = mean(cell2mat(sfs28_mean(:,:,yy)),2) - cell2mat(sfs28_real(:,1,yy));
    sfs28_phi_ci(:,yy) = ci(cell2mat(sfs28_mean(:,:,yy)),2);
    sfs28_phi_std(:,yy) = mean(cell2mat(sfs28_std(:,:,yy)),2);
    sfs28_phi_std_ci(:,yy) = ci(cell2mat(sfs28_std(:,:,yy)),2);
    sfs56_phi(:,yy) = mean(cell2mat(sfs56_mean(:,:,yy)),2) - cell2mat(sfs56_real(:,1,yy));
    sfs56_phi_ci(:,yy) = ci(cell2mat(sfs56_mean(:,:,yy)),2);
    sfs56_phi_std(:,yy) = mean(cell2mat(sfs56_std(:,:,yy)),2);
    sfs56_phi_std_ci(:,yy) = ci(cell2mat(sfs56_std(:,:,yy)),2);
    sfs1456_phi(:,yy) = mean(cell2mat(sfs1456_mean(:,:,yy)),2) - cell2mat(sfs1456_real(:,1,yy));
    sfs1456_phi_ci(:,yy) = ci(cell2mat(sfs1456_mean(:,:,yy)),2);
    sfs1456_phi_std(:,yy) = mean(cell2mat(sfs1456_std(:,:,yy)),2);
    sfs1456_phi_std_ci(:,yy) = ci(cell2mat(sfs1456_std(:,:,yy)),2);
end

% store the results
fid = fopen('../hoa_nls14_order7_ps.txt','w');
fprintf(fid,'# X/m   Y/m  phi/deg phi_error/deg phi_ci/deg std/deg std_ci/deg\n');
for yy=1:length(Y)
    for xx=1:length(sfs14_phi{:,yy})
        phi = sfs14_phi{:,yy}(xx)+direction_ps(xx,yy);
        phi_error = sfs14_phi{:,yy}(xx);
        phi_ci = sfs14_phi_ci{:,yy}(xx);
        phi_std = sfs14_phi_std{:,yy}(xx);
        phi_std_ci = sfs14_phi_std_ci{:,yy}(xx);
        fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
            X(xx),Y(yy),phi,phi_error,phi_ci,phi_std,phi_std_ci);
    end
    fprintf(fid,'\n\n');
end
fclose(fid);
fid = fopen('../hoa_nls28_order14_ps.txt','w');
fprintf(fid,'# X/m   Y/m  phi/deg phi_error/deg phi_ci/deg std/deg std_ci/deg\n');
for yy=1:length(Y)
    for xx=1:length(sfs28_phi{:,yy})
        phi = sfs28_phi{:,yy}(xx)+direction_ps(xx,yy);
        phi_error = sfs28_phi{:,yy}(xx);
        phi_ci = sfs28_phi_ci{:,yy}(xx);
        phi_std = sfs28_phi_std{:,yy}(xx);
        phi_std_ci = sfs28_phi_std_ci{:,yy}(xx);
        fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
            X(xx),Y(yy),phi,phi_error,phi_ci,phi_std,phi_std_ci);
    end
    fprintf(fid,'\n\n');
end
fclose(fid);
fid = fopen('../hoa_nls56_order28_ps.txt','w');
fprintf(fid,'# X/m   Y/m  phi/deg phi_error/deg phi_ci/deg std/deg std_ci/deg\n');
for yy=1:length(Y)
    for xx=1:length(sfs56_phi{:,yy})
        phi = sfs56_phi{:,yy}(xx)+direction_ps(xx,yy);
        phi_error = sfs56_phi{:,yy}(xx);
        phi_ci = sfs56_phi_ci{:,yy}(xx);
        phi_std = sfs56_phi_std{:,yy}(xx);
        phi_std_ci = sfs56_phi_std_ci{:,yy}(xx);
        fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
            X(xx),Y(yy),phi,phi_error,phi_ci,phi_std,phi_std_ci);
    end
    fprintf(fid,'\n\n');
end
fclose(fid);
fid = fopen('../hoa_nls14_order28_ps.txt','w');
fprintf(fid,'# X/m   Y/m  phi/deg phi_error/deg phi_ci/deg std/deg std_ci/deg\n');
for yy=1:length(Y)
    for xx=1:length(sfs1456_phi{:,yy})
        phi = sfs1456_phi{:,yy}(xx)+direction_ps(xx,yy);
        phi_error = sfs1456_phi{:,yy}(xx);
        phi_ci = sfs1456_phi_ci{:,yy}(xx);
        phi_std = sfs1456_phi_std{:,yy}(xx);
        phi_std_ci = sfs1456_phi_std_ci{:,yy}(xx);
        fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
            X(xx),Y(yy),phi,phi_error,phi_ci,phi_std,phi_std_ci);
    end
    fprintf(fid,'\n\n');
end
fclose(fid);
