function [data14,real14,data28,real28,data56,real56] = get_pooled_data(filename,nconditions)

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

% calculate the mean for the calibration speaker
speaker_mean = mean(speaker(:,8));
speaker_real = mean(speaker(:,9));

% calculate mean and std for WFS
n = zeros(5,nconditions);
data14 = n;
data28 = n;
data56 = n;
data14 = n;
data28 = n;
data56 = n;

for ii = 1:nconditions
    data14(:,ii) = sfs14(sfs14(:,3)==ii,8);
    data28(:,ii) = sfs28(sfs28(:,3)==ii+nconditions,8);
    data56(:,ii) = sfs56(sfs56(:,3)==ii+2*nconditions,8);
    real14(:,ii) = sfs14(sfs14(:,3)==ii,9);
    real28(:,ii) = sfs28(sfs28(:,3)==ii+nconditions,9);
    real56(:,ii) = sfs56(sfs56(:,3)==ii+2*nconditions,9);
end

% Correct for the 0deg looking direction
offset = speaker_real-speaker_mean;
data14 = data14 + offset;
data28 = data28 + offset;
data56 = data56 + offset;
