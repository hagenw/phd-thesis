function [ hprefhigh ] = findhprehigh( no_of_speaker,L,hpreflow )
%FINDHPREHIGH Finds a suitable limiting frequency for the WFS pre-equalization
%
%   This method runs a quick simulation of a circular WFS array with
%   adjustable secondary speaker placement. 
%
%   no_of_speaker: Total number of speaker in the array
%   L: Length of the array
%   hpreflow: Starting frequency of pre-equalization filter
%
% Christoph Hohnerlein, BA thesis, 03.11.2013
% Hagen Wierstorf, 27.01.14


conf=SFS_config;
conf.array='circle';
conf.dx0 = pi*L/no_of_speaker;
conf.useplot =0;

conf.usehcomp = false;
irs=dummy_irs;              % Dummy IRS with linear frequency response
conf.hpreflow=hpreflow;             
conf.hprefhigh=5000;        %Set upper limit reasonably high to ensure reaching f_aliasing
conf.usehpre=1;

ir_wfs = ir_wfs_25d([0 0], pi/2, [0 2.5], 'ps',L,irs,conf);
[a,pf,f]=easyfft(ir_wfs(:,1),conf); % Fourier transform

normalizedamplitude=db(a)/abs(max(db(a(1:50))))+1;  %Normalize
max_linear=find(abs(normalizedamplitude)>0.02,1,'first'); % Find limit of filter
hprefhigh=round(f(max_linear));         %Round to nearest integer

end

