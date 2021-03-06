% Test if it is neccessary to simulate a loudspeaker array with a measurement of
% a single loudspeaker (in the presence of other speakers) or if you really need
% all other speakers

function fig4_06()

addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
head_orientation = 0; % 0deg means look directly towards the speaker
sig_noise = noise(441000,1,'white');
fs = 44100;
conf.fs = fs;
conf.N = 4096;
conf.c = 343;
conf.usefracdelay = false;
conf.fracdelay_method = '';
conf.ir.useoriglength = 0;
conf.ir.useinterpolation = 1;
conf.ir.usehcomp = 0;
conf.ir.hcompfile = '';
conf.ir.speechfile = '';
conf.ir.cellofile = '';
conf.ir.castanetsfile = '';
conf.ir.noisefile = '';
conf.ir.pinknoisefile = '';

% center array files
array_center13 = { ...
    'QU_KEMAR_array_center_ls13_src01_xs-0.900_ys+2.000.mat', ...
    'QU_KEMAR_array_center_ls13_src02_xs-0.750_ys+2.000.mat', ...
    'QU_KEMAR_array_center_ls13_src03_xs-0.600_ys+2.000.mat', ...
    'QU_KEMAR_array_center_ls13_src04_xs-0.450_ys+2.000.mat', ...
    'QU_KEMAR_array_center_ls13_src05_xs-0.300_ys+2.000.mat', ...
    'QU_KEMAR_array_center_ls13_src06_xs-0.150_ys+2.000.mat', ...
    'QU_KEMAR_array_center_ls13_src07_xs+0.000_ys+2.000.mat', ...
    'QU_KEMAR_array_center_ls13_src08_xs+0.150_ys+2.000.mat', ...
    'QU_KEMAR_array_center_ls13_src09_xs+0.300_ys+2.000.mat', ...
    'QU_KEMAR_array_center_ls13_src10_xs+0.450_ys+2.000.mat', ...
    'QU_KEMAR_array_center_ls13_src11_xs+0.600_ys+2.000.mat', ...
    'QU_KEMAR_array_center_ls13_src12_xs+0.750_ys+2.000.mat', ...
    'QU_KEMAR_array_center_ls13_src13_xs+0.900_ys+2.000.mat', ...
    };
array_left13 = { ...
    'QU_KEMAR_array_left_ls13_src01_xs-2.550_ys+2.000.mat', ...
    'QU_KEMAR_array_left_ls13_src02_xs-2.400_ys+2.000.mat', ...
    'QU_KEMAR_array_left_ls13_src03_xs-2.250_ys+2.000.mat', ...
    'QU_KEMAR_array_left_ls13_src04_xs-2.100_ys+2.000.mat', ...
    'QU_KEMAR_array_left_ls13_src05_xs-1.950_ys+2.000.mat', ...
    'QU_KEMAR_array_left_ls13_src06_xs-1.800_ys+2.000.mat', ...
    'QU_KEMAR_array_left_ls13_src07_xs-1.650_ys+2.000.mat', ...
    'QU_KEMAR_array_left_ls13_src08_xs-1.500_ys+2.000.mat', ...
    'QU_KEMAR_array_left_ls13_src09_xs-1.350_ys+2.000.mat', ...
    'QU_KEMAR_array_left_ls13_src10_xs-1.200_ys+2.000.mat', ...
    'QU_KEMAR_array_left_ls13_src11_xs-1.050_ys+2.000.mat', ...
    'QU_KEMAR_array_left_ls13_src12_xs-0.900_ys+2.000.mat', ...
    'QU_KEMAR_array_left_ls13_src13_xs-0.750_ys+2.000.mat', ...
    };
array_right13 = { ...
    'QU_KEMAR_array_right_ls13_src01_xs+0.750_ys+2.000.mat', ...
    'QU_KEMAR_array_right_ls13_src02_xs+0.900_ys+2.000.mat', ...
    'QU_KEMAR_array_right_ls13_src03_xs+1.050_ys+2.000.mat', ...
    'QU_KEMAR_array_right_ls13_src04_xs+1.200_ys+2.000.mat', ...
    'QU_KEMAR_array_right_ls13_src05_xs+1.350_ys+2.000.mat', ...
    'QU_KEMAR_array_right_ls13_src06_xs+1.500_ys+2.000.mat', ...
    'QU_KEMAR_array_right_ls13_src07_xs+1.650_ys+2.000.mat', ...
    'QU_KEMAR_array_right_ls13_src08_xs+1.800_ys+2.000.mat', ...
    'QU_KEMAR_array_right_ls13_src09_xs+1.950_ys+2.000.mat', ...
    'QU_KEMAR_array_right_ls13_src10_xs+2.100_ys+2.000.mat', ...
    'QU_KEMAR_array_right_ls13_src11_xs+2.250_ys+2.000.mat', ...
    'QU_KEMAR_array_right_ls13_src12_xs+2.400_ys+2.000.mat', ...
    'QU_KEMAR_array_right_ls13_src13_xs+2.550_ys+2.000.mat', ...
    };

%% === comparing single speakers ===
irs_single = read_irs(array_center13{7},conf);
[ldiff_c13,cf] = ...
    magnitude_diff_single(array_center13,irs_single,13,head_orientation,fs,sig_noise,conf);
[ldiff_l13,cf] = ...
    magnitude_diff_single(array_left13,irs_single,13,head_orientation,fs,sig_noise,conf);
[ldiff_r13,cf] = ...
    magnitude_diff_single(array_right13,irs_single,13,head_orientation,fs,sig_noise,conf);
% Save results
gp_save('data/array_directivity.txt',[cf'...
    ldiff_c13(:,7), ...
    (ldiff_c13(:,6)+ldiff_c13(:,8))/2, ...
    (ldiff_c13(:,5)+ldiff_c13(:,9))/2, ...
    (ldiff_c13(:,4)+ldiff_c13(:,10))/2, ...
    (ldiff_c13(:,3)+ldiff_c13(:,11))/2, ...
    (ldiff_l13(:,13)+ldiff_c13(:,2)+ldiff_c13(:,12)+ldiff_r13(:,1))/4, ...
    (ldiff_l13(:,12)+ldiff_c13(:,1)+ldiff_c13(:,13)+ldiff_r13(:,2))/4, ...
    (ldiff_l13(:,11)+ldiff_r13(:,3))/2, ...
    (ldiff_l13(:,10)+ldiff_r13(:,4))/2, ...
    (ldiff_l13(:,9)+ldiff_r13(:,5))/2, ...
    (ldiff_l13(:,8)+ldiff_r13(:,6))/2, ...
    (ldiff_l13(:,7)+ldiff_r13(:,7))/2, ...
    (ldiff_l13(:,6)+ldiff_r13(:,8))/2, ...
    (ldiff_l13(:,5)+ldiff_r13(:,9))/2, ...
    (ldiff_l13(:,4)+ldiff_r13(:,10))/2, ...
    (ldiff_l13(:,3)+ldiff_r13(:,11))/2, ...
    (ldiff_l13(:,2)+ldiff_r13(:,12))/2, ...
    (ldiff_l13(:,1)+ldiff_r13(:,13))/2, ...
    ],'cfreq delta_magnitude_loudsepaker_distance1 delta_magnitude_loudsepaker_distance2 ...');

end

%% ===== Subfunctions ====================================================
function [ldiff,cf] = magnitude_diff_single(array,irs_single,nls,head_orientation,fs,sig_noise,conf)
    %% Magnitude deviation function
    for ii = 1:nls
        % real array
        irs = read_irs(array{ii},conf);
        ir = ir_point_source([0 0 0],-pi/2, ...
            irs.source_position'-irs.head_position',irs,conf);
        % get the real amplitude
        sig_real = auralize_ir(ir,sig_noise,0,conf);
        % single loudspeaker array
        ir = ir_point_source([0 0 0],-pi/2, ...
            irs.source_position'-irs.head_position',irs_single,conf);
        sig_single = auralize_ir(ir,sig_noise,0,conf);
        [l_real,cf] = magnitude_erb(sig_real,fs);
        [l_single,cf] = magnitude_erb(sig_single,fs);
        ldiff(:,ii) = l_real-l_single;
    end
    % scale to same level at 1000 Hz due to some deviations during measurement
    % between different positions
    ldiff = bsxfun(@minus,ldiff,ldiff(13,:));
end

function [l,cfreq] = magnitude_erb(sig,fs)
    %MAGNITUDE_ERB calculates magnitude in dB in ERB bands
    %
    %   Input parameters
    %       sig - signal (the first channel is used for loudness calculation)
    %       fs  - sampling rate
    %
    %   Ouput parameters
    %       l     - magnitude / dB
    %       cfreq - corresponding frequency bands
    %
    %   MAGNITUDE_ERB(sig,fs) calculates the magnitude in dB for the given signal in every
    %   frequency band.
    [amp,cfreq] = auditoryfilterbank(sig(:,1),fs,'fhigh',20000,'basef',1000);
    l = db(mean(abs(amp)));
end
