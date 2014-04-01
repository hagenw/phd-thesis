function [l,cfreq] = magnitude(sig,fs)
%MAGNITUDE calculates the magnitude in ERB bands
%
%   Input parameters
%       sig - signal (the first channel is used for loudness calculation)
%       fs  - sampling rate
%
%   Ouput parameters
%       l     - magnitude
%       cfreq - corresponding frequency bands
%
%   MAGNITUDE(sig,fs) calculates the magnitude in dB for the given signal in every
%   frequency band.

% AUTHOR: Hagen Wierstorf


%% ===== Main ============================================================
[amp,cfreq] = auditoryfilterbank(sig(:,1),fs,'fhigh',20000,'basef',1000);
%l = db(rms(amp)));
l = 20*log10(sqrt(mean(amp.^2)));
