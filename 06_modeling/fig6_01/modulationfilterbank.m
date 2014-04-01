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
gp_save('modulationfilterbank.txt',[frequency' 20*log10(fine) 20*log10(env') 20*log(ild)]);
