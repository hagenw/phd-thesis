function [sfs14_mean,sfs14_std,sfs14_real,sfs28_mean,sfs28_std,sfs28_real,sfs56_mean,sfs56_std,sfs56_real,sfs1456_mean,sfs1456_std,sfs1456_real,speaker_mean,speaker_std,speaker_real] = get_single_data(filename,nconditions)

%% ==== Main =============================================================
% get all data
data = csvread(filename);
% get calibration data
calibration = data(5,1:6);
% get experiment data
experiment = data(9:end,:);

% Calibration speaker
speaker = experiment(experiment(:,2)==0,:);
% WFS, different array sizes
sfs14 = experiment(experiment(:,2)==14,:);
sfs28 = experiment(experiment(:,2)==28,:);
sfs56 = experiment(experiment(:,2)==56,:);
sfs1456 = experiment(experiment(:,2)==1456,:);

% calculate the mean for the calibration speaker
speaker_mean = mean(speaker(:,8));
speaker_std = std(speaker(:,8));
speaker_real = mean(speaker(:,9));
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
sfs14_real = n;
sfs28_real = n;
sfs56_real = n;
sfs1456_real = n;

for ii = 1:nconditions
    sfs14_mean(ii) = mean(sfs14(sfs14(:,3)==ii,8));
    sfs14_std(ii) = std(sfs14(sfs14(:,3)==ii,8));
    sfs28_mean(ii) = mean(sfs28(sfs28(:,3)==ii+nconditions,8));
    sfs28_std(ii) = std(sfs28(sfs28(:,3)==ii+nconditions,8));
    sfs56_mean(ii) = mean(sfs56(sfs56(:,3)==ii+2*nconditions,8));
    sfs56_std(ii) = std(sfs56(sfs56(:,3)==ii+2*nconditions,8));
    sfs1456_mean(ii) = mean(sfs1456(sfs1456(:,3)==ii+3*nconditions,8));
    %size(std(sfs1456(sfs1456(:,3)==ii+3*nconditions,8)))
    sfs1456_std(ii) = std(sfs1456(sfs1456(:,3)==ii+3*nconditions,8));
    sfs14_real(ii) = mean(sfs14(sfs14(:,3)==ii,9));
    sfs28_real(ii) = mean(sfs28(sfs28(:,3)==ii+nconditions,9));
    sfs56_real(ii) = mean(sfs56(sfs56(:,3)==ii+2*nconditions,9));
    sfs1456_real(ii) = mean(sfs1456(sfs1456(:,3)==ii+3*nconditions,9));
end

% Correct for the 0deg looking direction
offset = speaker_real-speaker_mean;
sfs14_mean = sfs14_mean + offset;
sfs28_mean = sfs28_mean + offset;
sfs56_mean = sfs56_mean + offset;
sfs1456_mean = sfs1456_mean + offset;
