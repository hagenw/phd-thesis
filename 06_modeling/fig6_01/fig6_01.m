addpath('../../matlab');
create_dir('data');

% Gammatonefilterbank
clear all
fs = 16276;
impulse = [1, zeros(1,8191)]';
impulse_response = auditoryfilterbank(impulse,fs,'basef',1000,'flow',200,'fhigh',5000);
frequency_response = fft(real(impulse_response));
frequency = [0:8191] * fs / 8192;
gp_save('data/gammatonefilterbank.txt',[frequency' 20*log10(frequency_response)]);

% Middle ear
clear all
conf.fs = 44100;
conf.plot.useplot = false;
impulse = [1, zeros(1,8191)];
[b,a] = butter(2,2000/(conf.fs/2),'low');
sig = filter(b,a,impulse);
[b,a] = butter(2,500/(conf.fs/2),'high');
sig = filter(b,a,sig);
[a,~,f] = easyfft(sig,conf);
gp_save('data/middleear.txt',[f 20*log10(a)]);

% Innerhair cells
clear all
conf.fs = 44100;
conf.plot.useplot = false;
impulse = [1, zeros(1,8191)];
[b, a] = butter(1, 2000*2/conf.fs);
for ii=1:5
    impulse = filter(b,a, impulse);
end
[a,~,f] = easyfft(impulse,conf);
gp_save('data/innerhaircell.txt',[f 20*log10(a)]);

% Modulation filter bank
clear all
fs = 16276;
impulse = [1, zeros(1,8191)]';
[~,fc] = auditoryfilterbank(impulse,fs,'basef',1000,'flow',200,'fhigh',5000);
% -- fine structure
for ii=1:length(fc)
    gammatone_filter = gfb_filter_new(fs,fc(ii),fc(ii)/3,10,2);
    fine(:,ii) = gfb_filter_process(gammatone_filter,impulse');
end
fine = fft(real(fine));
% -- modulation filter
gammatone_filter = gfb_filter_new(fs,135,135/8,10,2);
env = gfb_filter_process(gammatone_filter,impulse');
env = fft(real(env));
% -- ILD filter
[b,a] = butter(2,30/(fs/2),'low');
ild = filter(b,a,impulse);
ild = fft(real(ild));
frequency = [0:8191] * fs / 8192;
gp_save('data/modulationfilterbank.txt',[frequency' 20*log10(fine) 20*log10(env') 20*log(ild)]);
