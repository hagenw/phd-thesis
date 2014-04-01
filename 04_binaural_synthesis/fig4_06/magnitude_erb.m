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

% AUTHOR: Hagen Wierstorf


%% ===== Main ============================================================
[amp,cfreq] = auditoryfilterbank(sig(:,1),fs,'fhigh',20000,'basef',1000);
l = db(mean(abs(amp)));
