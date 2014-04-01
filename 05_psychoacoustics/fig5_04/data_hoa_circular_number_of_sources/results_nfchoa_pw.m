clear all
% get common config data
configuration;
% get subject data file names
get_filenames;

% get the results for every single person
for nn=1:size(files_pw,1)
    for yy=1:length(Y)
        [tmp_sfs14_mean, ...
         tmp_sfs14_std, ...
         tmp_sfs28_mean, ...
         tmp_sfs28_std, ...
         tmp_sfs56_mean, ...
         tmp_sfs56_std, ...
         tmp_sfs1456_mean, ...
         tmp_sfs1456_std, ...
         tmp_speaker_mean, ...
         tmp_speaker_std] = get_single_data(files_pw{nn,yy},nconditions(yy));
        % store in cell
        sfs14_mean(:,nn,yy) = {tmp_sfs14_mean};
        sfs14_std(:,nn,yy) = {tmp_sfs14_std};
        sfs28_mean(:,nn,yy) = {tmp_sfs28_mean};
        sfs28_std(:,nn,yy) = {tmp_sfs28_std};
        sfs56_mean(:,nn,yy) = {tmp_sfs56_mean};
        sfs56_std(:,nn,yy) = {tmp_sfs56_std};
        sfs1456_mean(:,nn,yy) = {tmp_sfs1456_mean};
        sfs1456_std(:,nn,yy) = {tmp_sfs1456_std};
        speaker_mean(:,nn,yy) = {tmp_speaker_mean};
        speaker_std(:,nn,yy) = {tmp_speaker_std};
    end
end

% calculate the mean about the subjects.
% subtract the real position of the virtual sources to get only the deviation
sfs14_average ={};
sfs14_ci = {};
sfs28_average = {};
sfs28_ci = {};
sfs56_average = {};
sfs56_ci = {};
sfs1456_average = {};
sfs1456_ci = {};
for yy=1:length(Y)
    sfs14_average(:,yy) = mean(cell2mat(sfs14_mean(:,:,yy)),2);
    sfs14_ci(:,yy) = ci(cell2mat(sfs14_mean(:,:,yy)),2);
    sfs28_average(:,yy) = mean(cell2mat(sfs28_mean(:,:,yy)),2);
    sfs28_ci(:,yy) = ci(cell2mat(sfs28_mean(:,:,yy)),2);
    sfs56_average(:,yy) = mean(cell2mat(sfs56_mean(:,:,yy)),2);
    sfs56_ci(:,yy) = ci(cell2mat(sfs56_mean(:,:,yy)),2);
    sfs1456_average(:,yy) = mean(cell2mat(sfs1456_mean(:,:,yy)),2);
    sfs1456_ci(:,yy) = ci(cell2mat(sfs1456_mean(:,:,yy)),2);
end

% store the results
fid = fopen('../hoa_number_of_sources_nls14_order7_pw.txt','w');
fprintf(fid,'# X/m   Y/m  number_of_sources   number_of_sources_ci\n');
for yy=1:length(Y)
    for xx=1:length(sfs14_average{:,yy})
        n = sfs14_average{:,yy}(xx);
        n_ci = sfs14_ci{:,yy}(xx);
        fprintf(fid,'% 4.2f  % 4.2f  % 1.2f  %1.2f\n',X(xx),Y(yy),n,n_ci);
    end
    fprintf(fid,'\n\n');
end
fclose(fid);
fid = fopen('../hoa_number_of_sources_nls28_order14_pw.txt','w');
fprintf(fid,'# X/m   Y/m  number_of_sources   number_of_sources_ci\n');
for yy=1:length(Y)
    for xx=1:length(sfs28_average{:,yy})
        n = sfs28_average{:,yy}(xx);
        n_ci = sfs28_ci{:,yy}(xx);
        fprintf(fid,'% 4.2f  % 4.2f  % 1.2f  % 1.2f\n',X(xx),Y(yy),n,n_ci);
    end
    fprintf(fid,'\n\n');
end
fclose(fid);
fid = fopen('../hoa_number_of_sources_nls56_order28_pw.txt','w');
fprintf(fid,'# X/m   Y/m  number_of_sources   number_of_sources_ci\n');
for yy=1:length(Y)
    for xx=1:length(sfs56_average{:,yy})
        n = sfs56_average{:,yy}(xx);
        n_ci = sfs56_ci{:,yy}(xx);
        fprintf(fid,'% 4.2f  % 4.2f  % 1.2f  % 1.2f\n',X(xx),Y(yy),n,n_ci);
    end
    fprintf(fid,'\n\n');
end
fclose(fid);
fid = fopen('../hoa_number_of_sources_nls14_order28_pw.txt','w');
fprintf(fid,'# X/m   Y/m  number_of_sources   number_of_sources_ci\n');
for yy=1:length(Y)
    for xx=1:length(sfs1456_average{:,yy})
        n = sfs1456_average{:,yy}(xx);
        n_ci = sfs1456_ci{:,yy}(xx);
        fprintf(fid,'% 4.2f  % 4.2f  % 1.2f  % 1.2f\n',X(xx),Y(yy),n,n_ci);
    end
    fprintf(fid,'\n\n');
end
fclose(fid);
