function [sfs14_mean,sfs14_std,sfs28_mean,sfs28_std,sfs56_mean,sfs56_std,sfs1456_mean,sfs1456_std,speaker_mean,speaker_std] = get_single_data(filename,nconditions)

%% ==== Main =============================================================
% get all data
data = csvread(filename);
% get experiment data
experiment = data(6:end,:);

% Calibration speaker
speaker = experiment(experiment(:,2)==0,:);
% SFS, different array sizes
sfs14 = experiment(experiment(:,2)==14,:);
sfs28 = experiment(experiment(:,2)==28,:);
sfs56 = experiment(experiment(:,2)==56,:);
sfs1456 = experiment(experiment(:,2)==1456,:);

% calculate the mean for the calibration speaker
speaker_mean = mean(speaker(:,5));
speaker_std = std(speaker(:,5));
% calculate mean and std for WFS
n = zeros(nconditions,1);
sfs14_mean = n;
sfs14_std = n;
sfs28_mean = n;
sfs28_std = n;
sfs56_mean = n;
sfs56_std = n;
sfs1456_mean = n;
sfs1456_std = n;

for ii = 1:nconditions
    sfs14_mean(ii) = mean(sfs14(sfs14(:,3)==ii,5));
    sfs14_std(ii) = std(sfs14(sfs14(:,3)==ii,5));
    sfs28_mean(ii) = mean(sfs28(sfs28(:,3)==ii+nconditions,5));
    sfs28_std(ii) = std(sfs28(sfs28(:,3)==ii+nconditions,5));
    sfs56_mean(ii) = mean(sfs56(sfs56(:,3)==ii+2*nconditions,5));
    sfs56_std(ii) = std(sfs56(sfs56(:,3)==ii+2*nconditions,5));
    sfs1456_mean(ii) = mean(sfs1456(sfs1456(:,3)==ii+3*nconditions,5));
    sfs1456_std(ii) = std(sfs1456(sfs1456(:,3)==ii+3*nconditions,5));
end
