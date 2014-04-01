clear all;
%addpath('~/svn/audio/matlab_general/nansuite');
addpath('../../../matlab');
% Files to analyze
files = { ...
    'VP01_Y1.50_2012-05-08_11-32-29.csv'; ...
    'VP01_Y2.00_2012-05-08_11-51-44.csv'; ...
    'VP02_Y1.50_2012-05-07_12-58-36.csv'; ...
    'VP02_Y2.00_2012-05-07_12-48-29.csv'; ...
    'VP03_Y1.50_2012-05-07_15-04-40.csv'; ...
    'VP03_Y2.00_2012-05-07_15-16-31.csv'; ...
    'VP04_Y1.50_2012-05-07_16-19-44.csv'; ...
    'VP04_Y2.00_2012-05-07_16-08-09.csv'; ...
    'VP05_Y1.50_2012-05-14_14-27-18.csv'; ...
    'VP05_Y2.00_2012-05-14_14-44-43.csv'; ...
    'VP06_Y1.50_2012-05-08_15-16-02.csv'; ...
    'VP06_Y2.00_2012-05-08_15-07-20.csv'; ...
    %'VP07_Y1.50_2012-05-14_15-39-13.csv'; ...  % removed as outlier
    %'VP07_Y2.00_2012-05-14_15-50-09.csv'; ...
    'VP08_Y1.50_2012-05-08_10-10-57.csv'; ...
    'VP08_Y2.00_2012-05-08_10-01-50.csv'; ...
    'VP09_Y1.50_2012-05-09_15-18-33.csv'; ...
    'VP09_Y2.00_2012-05-09_15-52-11.csv'; ...
    'VP10_Y1.50_2012-05-09_16-24-35.csv'; ...
    'VP10_Y2.00_2012-05-09_16-14-22.csv'; ...
    'VP11_Y1.50_2012-05-09_14-14-10.csv'; ...
    'VP11_Y2.00_2012-05-09_14-28-34.csv'; ...
    };

for ii = 1:length(files)
    [m3(:,ii),s3(:,ii),r3(:,ii), ...
     m8(:,ii),s8(:,ii),r8(:,ii), ...
     m15(:,ii),s15(:,ii),r15(:,ii), ...
     ms(ii),ss(ii),rs(ii)] = get_single_data(files{ii});
end


% Set 0deg to the mean 0deg.
% doing this by using only the value for the loudspeaker at 0deg
% NOTE: in this experiment a real speaker (generic renderer) is used for
% this calibration, in the other experiments a binaural simulated speaker (BRS
% renderer) is used, which should be an even better approach.
for ii=1:size(m3,2)
    rs(ii)-ms(ii);
    m3(:,ii) = m3(:,ii)+(rs(ii)-ms(ii));
    m8(:,ii) = m8(:,ii)+(rs(ii)-ms(ii));
    m15(:,ii) = m15(:,ii)+(rs(ii)-ms(ii));
end

% Calculate the average standard deviation over all loudspeaker setups for every
% listener. Afterwards build the mean and confidence interval over all listeners
std_dev = [];
for ii=1:size(s3,2)/2
    tmp = [s3(:,2*ii-1:2*ii) s8(:,2*ii-1:2*ii) s15(:,2*ii-1:2*ii)];
    std_dev(ii) = mean(tmp(:));
end
file = '../std_wfs_linear_ps.txt';
fid = fopen(file,'w');
fprintf(fid,'# std/deg ci/deg\n');
fprintf(fid,'%.2f   %.2f',mean(std_dev),ci(std_dev));
fclose(fid);


% Get the mean error for every VP independent of the loudspeaker position
% directions
M3_Y15 = mean(m3(:,1:2:end)-r3(:,1:2:end),2);
M8_Y15 = mean(m8(:,1:2:end)-r8(:,1:2:end),2);
M15_Y15 = mean(m15(:,1:2:end)-r15(:,1:2:end),2);
M3_Y20 = mean(m3(:,2:2:end)-r3(:,2:2:end),2);
M8_Y20 = mean(m8(:,2:2:end)-r8(:,2:2:end),2);
M15_Y20 = mean(m15(:,2:2:end)-r15(:,2:2:end),2);
CM3_Y15 = ci(m3(:,1:2:end)-r3(:,1:2:end),2);
CM8_Y15 = ci(m8(:,1:2:end)-r8(:,1:2:end),2);
CM15_Y15 = ci(m15(:,1:2:end)-r15(:,1:2:end),2);
CM3_Y20 = ci(m3(:,2:2:end)-r3(:,2:2:end),2);
CM8_Y20 = ci(m8(:,2:2:end)-r8(:,2:2:end),2);
CM15_Y20 = ci(m15(:,2:2:end)-r15(:,2:2:end),2);
% standard deviations
S3_Y15 = mean(s3(:,1:2:end),2);
S8_Y15 = mean(s8(:,1:2:end),2);
S15_Y15 = mean(s15(:,1:2:end),2);
S3_Y20 = mean(s3(:,2:2:end),2);
S8_Y20 = mean(s8(:,2:2:end),2);
S15_Y20 = mean(s15(:,2:2:end),2);
CS3_Y15 = ci(s3(:,1:2:end),2);
CS8_Y15 = ci(s8(:,1:2:end),2);
CS15_Y15 = ci(s15(:,1:2:end),2);
CS3_Y20 = ci(s3(:,2:2:end),2);
CS8_Y20 = ci(s8(:,2:2:end),2);
CS15_Y20 = ci(s15(:,2:2:end),2);

X = 0:-0.25:-1.75;
Y = [-1.5 -2];
file = '../wfs_nls3_linear_ps.txt';
fid = fopen(file,'w');
fprintf(fid,'# X/m   Y/m  phi/deg phi_error/deg phi_ci/deg std/deg std_ci/deg\n');
for xx=1:length(X)
    phi = M3_Y15(xx)+r3(xx,1);
    phi_error = M3_Y15(xx);
    phi_ci = CM3_Y15(xx);
    standard_deviation = S3_Y15(xx);
    standard_deviation_ci = CS3_Y15(xx);
    fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
        X(xx),Y(1),phi,phi_error,phi_ci,standard_deviation,standard_deviation_ci);
end
fprintf(fid,'\n\n');
for xx=1:length(X)
    phi = M3_Y20(xx)+r3(xx,2);
    phi_error = M3_Y20(xx);
    phi_ci = CM3_Y20(xx);
    standard_deviation = S3_Y20(xx);
    standard_deviation_ci = CS3_Y20(xx);
    fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
        X(xx),Y(2),phi,phi_error,phi_ci,standard_deviation,standard_deviation_ci);
end
fclose(fid);
file = '../wfs_nls8_linear_ps.txt';
fid = fopen(file,'w');
fprintf(fid,'# X/m   Y/m  phi/deg phi_error/deg phi_ci/deg std/deg std_ci/deg\n');
for xx=1:length(X)
    phi = M8_Y15(xx)+r8(xx,1)-35;
    phi_error = M8_Y15(xx);
    phi_ci = CM8_Y15(xx);
    standard_deviation = S8_Y15(xx);
    standard_deviation_ci = CS8_Y15(xx);
    fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
        X(xx),Y(1),phi,phi_error,phi_ci,standard_deviation,standard_deviation_ci);
end
fprintf(fid,'\n\n');
for xx=1:length(X)
    phi = M8_Y20(xx)+r8(xx,2)-35;
    phi_error = M8_Y20(xx);
    phi_ci = CM8_Y20(xx);
    standard_deviation = S8_Y20(xx);
    standard_deviation_ci = CS8_Y20(xx);
    fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
        X(xx),Y(2),phi,phi_error,phi_ci,standard_deviation,standard_deviation_ci);
end
fclose(fid);
file = '../wfs_nls15_linear_ps.txt';
fid = fopen(file,'w');
fprintf(fid,'# X/m   Y/m  phi/deg phi_error/deg phi_ci/deg std/deg std_ci/deg\n');
for xx=1:length(X)
    phi = M15_Y15(xx)+r15(xx,1)-17.5;
    phi_error = M15_Y15(xx);
    phi_ci = CM15_Y15(xx);
    standard_deviation = S15_Y15(xx);
    standard_deviation_ci = CS15_Y15(xx);
    fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
        X(xx),Y(1),phi,phi_error,phi_ci,standard_deviation,standard_deviation_ci);
end
fprintf(fid,'\n\n');
for xx=1:length(X)
    phi = M15_Y20(xx)+r15(xx,2)-17.5;
    phi_error = M15_Y20(xx);
    phi_ci = CM15_Y20(xx);
    standard_deviation = S15_Y20(xx);
    standard_deviation_ci = CS15_Y20(xx);
    fprintf(fid,'% 4.2f  % 4.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f  % 7.2f\n', ...
        X(xx),Y(2),phi,phi_error,phi_ci,standard_deviation,standard_deviation_ci);
end
fclose(fid);
