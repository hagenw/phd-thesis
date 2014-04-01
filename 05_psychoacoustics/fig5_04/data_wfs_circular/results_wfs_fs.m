clear all;
% get common config data
configuration;
% read subject data file names
get_filenames;

% get the results for every single person
for nn=1:length(files_fs)
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
         tmp_speaker_mean, ...
         tmp_speaker_std, ...
         tmp_speaker_real] = get_single_data(files_fs{nn,yy},nconditions(yy));
        % store in cell
        sfs14_mean(:,nn,yy) = {tmp_sfs14_mean};
        sfs14_std(:,nn,yy) = {tmp_sfs14_std};
        sfs14_real(:,nn,yy) = {tmp_sfs14_real};
        sfs28_mean(:,nn,yy) = {tmp_sfs28_mean};
        sfs28_std(:,nn,yy) = {tmp_sfs28_std};
        sfs28_real(:,nn,yy) = {tmp_sfs28_real};
        sfs56_mean(:,nn,yy) = {tmp_sfs56_mean};
        sfs56_std(:,nn,yy) = {tmp_sfs56_std};
        sfs56_real(:,nn,yy) = {tmp_sfs56_real};
        speaker_mean(:,nn,yy) = {tmp_speaker_mean};
        speaker_std(:,nn,yy) = {tmp_speaker_std};
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
tmp = [tmp14; tmp28; tmp56];
std_dev14 = mean(tmp14,1);
std_dev28 = mean(tmp28,1);
std_dev56 = mean(tmp56,1);
std_y1 = mean([tmp14(1:5,:); tmp28(1:5,:); tmp56(1:5,:)],1);
std_y2 = mean([tmp14(6:11,:); tmp28(6:11,:); tmp56(6:11,:)],1);
std_y3 = mean([tmp14(12:16,:); tmp28(12:16,:); tmp56(12:16,:)],1);
std_dev = mean(tmp,1);
file = '../std_wfs_circular_fs.txt';
fid = fopen(file,'w');
fprintf(fid,'# average over all loudspeaker arrays and positions\n');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f\n\n\n',mean(std_dev),ci(std_dev));
fprintf(fid,'# 14 loudspeakers, average over positions\n');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f\n\n',mean(std_dev14),ci(std_dev14));
fprintf(fid,'# 28 loudspeakers, average over positions\n');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f\n\n',mean(std_dev28),ci(std_dev28));
fprintf(fid,'# 56 loudspeakers, average over positions\n');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f\n\n\n',mean(std_dev56),ci(std_dev56));
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
sfs14_average ={};
sfs14_ci = {};
sfs14_standard_deviation = {};
sfs14_standard_deviation_ci = {};
sfs28_average = {};
sfs28_ci = {};
sfs28_standard_deviation = {};
sfs28_standard_deviation_ci = {};
sfs56_average = {};
sfs56_ci = {};
sfs56_standard_deviation = {};
sfs56_standard_deviation_ci = {};
for yy=1:length(Y)
    sfs14_average(:,yy) = mean(cell2mat(sfs14_mean(:,:,yy)),2) - ...
        cell2mat(sfs14_real(:,1,yy));
    sfs14_ci(:,yy) = ci(cell2mat(sfs14_mean(:,:,yy)),2);
    sfs14_standard_deviation(:,yy) = mean(cell2mat(sfs14_std(:,:,yy)),2);
    sfs14_standard_deviation_ci(:,yy) = ci(cell2mat(sfs14_std(:,:,yy)),2);
    sfs14_real(:,yy) = sfs14_real(:,1,yy);
    sfs28_average(:,yy) = mean(cell2mat(sfs28_mean(:,:,yy)),2) - ...
        cell2mat(sfs28_real(:,1,yy));
    sfs28_ci(:,yy) = ci(cell2mat(sfs28_mean(:,:,yy)),2);
    sfs28_standard_deviation(:,yy) = mean(cell2mat(sfs28_std(:,:,yy)),2);
    sfs28_standard_deviation_ci(:,yy) = ci(cell2mat(sfs28_std(:,:,yy)),2);
    sfs28_real(:,yy) = sfs28_real(:,1,yy);
    sfs56_average(:,yy) = mean(cell2mat(sfs56_mean(:,:,yy)),2) - ...
        cell2mat(sfs56_real(:,1,yy));
    sfs56_ci(:,yy) = ci(cell2mat(sfs56_mean(:,:,yy)),2);
    sfs56_standard_deviation(:,yy) = mean(cell2mat(sfs56_std(:,:,yy)),2);
    sfs56_standard_deviation_ci(:,yy) = ci(cell2mat(sfs56_std(:,:,yy)),2);
    sfs56_real(:,yy) = sfs56_real(:,1,yy);
end

% correct real positions for X = (0.00,0.75)m, because it was handled wrong in
% the experiment scripts!
sfs14_average{:,3}(1) = sfs14_average{:,3}(1) + 180;
sfs28_average{:,3}(1) = sfs28_average{:,3}(1) + 180;
sfs56_average{:,3}(1) = sfs56_average{:,3}(1) + 180;

% store the results
fid = fopen('../wfs_nls14_circular_fs.txt','w');
fprintf(fid,'# X/m   Y/m  phi/deg phi_error/deg phi_ci/deg std/deg std_ci/deg\n');
for yy=1:length(Y)
    for xx=1:length(sfs14_average{:,yy})
        phi = sfs14_average{:,yy}(xx)+direction_fs(xx,yy);
        phi_error = sfs14_average{:,yy}(xx);
        phi_ci = sfs14_ci{:,yy}(xx);
        standard_deviation = sfs14_standard_deviation{:,yy}(xx);
        standard_deviation_ci = sfs14_standard_deviation_ci{:,yy}(xx);
        fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
            X(xx),Y(yy),phi,phi_error,phi_ci,standard_deviation,standard_deviation_ci);
    end
    fprintf(fid,'\n\n');
end
fclose(fid);
fid = fopen('../wfs_nls28_circular_fs.txt','w');
fprintf(fid,'# X/m   Y/m  phi/deg phi_error/deg phi_ci/deg std/deg std_ci/deg\n');
for yy=1:length(Y)
    for xx=1:length(sfs28_average{:,yy})
        phi = sfs28_average{:,yy}(xx)+direction_fs(xx,yy);
        phi_error = sfs28_average{:,yy}(xx);
        phi_ci = sfs28_ci{:,yy}(xx);
        standard_deviation = sfs28_standard_deviation{:,yy}(xx);
        standard_deviation_ci = sfs28_standard_deviation_ci{:,yy}(xx);
        fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
            X(xx),Y(yy),phi,phi_error,phi_ci,standard_deviation,standard_deviation_ci);
    end
    fprintf(fid,'\n\n');
end
fclose(fid);
fid = fopen('../wfs_nls56_circular_fs.txt','w');
fprintf(fid,'# X/m   Y/m  phi/deg phi_error/deg phi_ci/deg std/deg std_ci/deg\n');
for yy=1:length(Y)
    for xx=1:length(sfs56_average{:,yy})
        phi = sfs56_average{:,yy}(xx)+direction_fs(xx,yy);
        phi_error = sfs56_average{:,yy}(xx);
        phi_ci = sfs56_ci{:,yy}(xx);
        standard_deviation = sfs56_standard_deviation{:,yy}(xx);
        standard_deviation_ci = sfs56_standard_deviation_ci{:,yy}(xx);
        fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
            X(xx),Y(yy),phi,phi_error,phi_ci,standard_deviation,standard_deviation_ci);
    end
    fprintf(fid,'\n\n');
end
fclose(fid);
