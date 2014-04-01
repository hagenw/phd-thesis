function [wfs3_mean,wfs3_std,wfs3_real,wfs8_mean,wfs8_std,wfs8_real,wfs15_mean,wfs15_std,wfs15_real,speaker_mean,speaker_std,speaker_real] = get_single_data(filename)

%% ==== Configuration ====================================================
xlength = 8;

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
wfs3 = experiment(experiment(:,2)==3,:);
wfs8 = experiment(experiment(:,2)==8,:);
wfs15 = experiment(experiment(:,2)==15,:);

% calculate the mean for the calibration speaker
speaker_mean = mean(speaker(:,8));
speaker_std = std(speaker(:,8));
speaker_real = mean(speaker(:,9));
% calculate mean and std for WFS
n = zeros(xlength,1);
wfs3_mean = n;
wfs3_std = n;
wfs8_mean = n;
wfs8_std = n;
wfs15_mean = n;
wfs15_std = n;
wfs3_real = n;
wfs8_real = n;
wfs15_real = n;
for ii = 1:xlength
    wfs3_mean(ii) = mean(wfs3(wfs3(:,3)==ii,8));
    wfs3_std(ii) = std(wfs3(wfs3(:,3)==ii,8));
    wfs8_mean(ii) = mean(wfs8(wfs8(:,3)==ii+8,8));
    wfs8_std(ii) = std(wfs8(wfs8(:,3)==ii+8,8));
    wfs15_mean(ii) = mean(wfs15(wfs15(:,3)==ii+16,8));
    wfs15_std(ii) = std(wfs15(wfs15(:,3)==ii+16,8));
    wfs3_real(ii) = mean(wfs3(wfs3(:,3)==ii,9));
    wfs8_real(ii) = mean(wfs8(wfs8(:,3)==ii+8,9));
    wfs15_real(ii) = mean(wfs15(wfs15(:,3)==ii+16,9));
end
