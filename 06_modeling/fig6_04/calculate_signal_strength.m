function [l,fc] = calculate_signal_strength(sig,fs)

[sig,fc] = auditoryfilterbank(sig,fs,'flow',124,'fhigh',15300,'basef',125);
l = 20*log10(abs(mean(sig,3)));
% scale maximum to 0
l = l - max(l(:));
