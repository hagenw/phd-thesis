function [ hpref_low ] = findhprelow(no_of_speaker,L)
%FINDHPRELOW Finds a suitable starting frequency of the WFS pre-equalization
%
%   This method runs a quick simulation of a circular WFS array with
%   adjustable secondary speaker placement.
%
%   no_of_speaker: Total number of speaker in the array
%   L: Length of the array
%
% Christoph Hohnerlein, BA thesis, 03.11.2013
% Hagen Wierstorf, 27.01.14

if no_of_speaker <15   % fixed starting frequency for very small WFS arrays
    hpref_low=50;
    break;
end

conf=SFS_config;
conf.dx0 = pi*L/no_of_speaker;
conf.useplot =0;
conf.N = 2^13;
conf.usehcomp = false;
conf.usehpre=0;

irs=dummy_irs;                  % Dummy IRS with linear frequency response
ir = ir_wfs_25d([0 0], pi/2, [0 2.5], 'ps',L,irs,conf);
[a,pf,f]=easyfft(ir(:,1),conf);	% Fourier transform

normalizedamplitude=db(a)/abs(max(db(a(1:50))))+1; % Normalize
hpref_low=find(abs(normalizedamplitude)>0.1,1,'first'); % Find starting point

end
