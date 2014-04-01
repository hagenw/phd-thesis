clear all
fs = 16276;
impulse = [1, zeros(1,8191)]';
impulse_response = auditoryfilterbank(impulse,fs,'basef',1000,'flow',200,'fhigh',5000);
frequency_response = fft(real(impulse_response));
frequency = [0:8191] * fs / 8192;
gp_save('gammatonefilterbank.txt',[frequency' 20*log10(frequency_response)]);
