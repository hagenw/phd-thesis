% Calculate the difference between simulation and real array using the
% recordings in Pinta
% here we are interested in the difference between simulating only one speaker
% and simulating all speakers.

fs = 44100;

positions = {'front','left','back','right'};
%% Noise
for ii = 1:4
    
    % read wav files
    % simulated
    wavfile = sprintf('2_brir_ls_noise_%s.wav',positions{ii});
    n_mono_sim = wavread(wavfile);
    % real
    wavfile = sprintf('2_array+akg_ls_noise_%s.wav',positions{ii});
    n_mono_real = wavread(wavfile);
    % simulated
    wavfile = sprintf('2_brir_wfs_ls56_noise_%s.wav',positions{ii});
    n_wfs56_sim = wavread(wavfile);
    wavfile = sprintf('2_brir_wfs_ls28_noise_%s.wav',positions{ii});
    n_wfs28_sim = wavread(wavfile);
    wavfile = sprintf('2_brir_wfs_ls14_noise_%s.wav',positions{ii});
    n_wfs14_sim = wavread(wavfile);
    % real
    wavfile = sprintf('2_array+akg_wfs_ls56_noise_%s.wav',positions{ii});
    n_wfs56_real = wavread(wavfile);
    wavfile = sprintf('2_array+akg_wfs_ls28_noise_%s.wav',positions{ii});
    n_wfs28_real = wavread(wavfile);
    wavfile = sprintf('2_array+akg_wfs_ls14_noise_%s.wav',positions{ii});
    n_wfs14_real = wavread(wavfile);

    % calculate differences in magnitude
    [l_mono_sim(:,ii),cf] = magnitude(n_mono_sim(100:end,1),fs);
    [l_mono_real(:,ii),cf] = magnitude(n_mono_real(100:end,1),fs);
    [l_wfs56_sim(:,ii),cf] = magnitude(n_wfs56_sim(100:end,1),fs);
    [l_wfs56_real(:,ii),cf] = magnitude(n_wfs56_real(100:end,1),fs);
    [l_wfs28_sim(:,ii),cf] = magnitude(n_wfs28_sim(100:end,1),fs);
    [l_wfs28_real(:,ii),cf] = magnitude(n_wfs28_real(100:end,1),fs);
    [l_wfs14_sim(:,ii),cf] = magnitude(n_wfs14_sim(100:end,1),fs);
    [l_wfs14_real(:,ii),cf] = magnitude(n_wfs14_real(100:end,1),fs);
    ldiff_mono(:,ii) = l_mono_real(:,ii)-l_mono_sim(:,ii);
    ldiff_wfs56(:,ii) = l_wfs56_real(:,ii)-l_wfs56_sim(:,ii);
    ldiff_wfs28(:,ii) = l_wfs28_real(:,ii)-l_wfs28_sim(:,ii);
    ldiff_wfs14(:,ii) = l_wfs14_real(:,ii)-l_wfs14_sim(:,ii);
    % Remove mean dB offset
    ldiff_mono(:,ii) = ldiff_mono(:,ii) - mean(ldiff_mono(:,ii));
    ldiff_wfs56(:,ii) = ldiff_wfs56(:,ii) - mean(ldiff_wfs56(:,ii));
    ldiff_wfs28(:,ii) = ldiff_wfs28(:,ii) - mean(ldiff_wfs28(:,ii));
    ldiff_wfs14(:,ii) = ldiff_wfs14(:,ii) - mean(ldiff_wfs14(:,ii));
    % save
    gp_save(sprintf('pinta_recordings_%i.txt',ii),[cf' ldiff_mono(:,ii) ldiff_wfs14(:,ii) ...
        ldiff_wfs28(:,ii) ldiff_wfs56(:,ii)],'cf mono wfs14 wfs28 wfs56');
end

% Weight for loudspeakers in WFS
w56 = [6.7393e-04 0.029917 0.097947 0.14415 0.18970 0.23065 0.26140 ...
       27782 0.28209 0.27782 0.26140 0.23065 0.18970 0.14415 0.097947 ... 
       0.029917 6.7393e-04];
w28 = [0.0026957 0.097947 0.18970 0.26140 0.28209 0.26140 0.18970 ...
       0.097947 0.0026957];
w14 = [0.097947 0.26140 0.26140 0.097947];

gp_save('pinta_recordings_mean.txt',[cf' mean(ldiff_mono,2) mean(ldiff_wfs14,2) ...
    mean(ldiff_wfs28,2) mean(ldiff_wfs56,2)],'# cf mono wfs14 wfs28 wfs56');
