function [amplitude,phase,f] = easyfft(sig,conf)
%EASYFFT calculates the FFT of a signal and returns the corresponding frequency
%   axis
%
%   Usage: [amplitude,phase,f] = easyfft(sig,[conf])
%
%   Input parameters:
%       sig         - one channel audio waveform
%       conf        - optional configuration struct (see SFS_config)
%
%   Output parameters:
%       amplitude   - amplitude spectrum of the input signal
%       phase       - phase spectrum of the input signal
%       f           - corresponding frequency axis for the amplitude
%                     spectrum (=> plot(f,amplitude) (Hz)
%
%   EASYFFT(sig) calculates the amplitude and phase of the sig spectrum by using
%   the fast Fourier transformation. In addition to the amplitude and phase, the
%   corresponding frequency axis for a plot is returned.
%
%   see also: easyifft, fft

%*****************************************************************************
% Copyright (c) 2010-2012 Quality & Usability Lab                            *
%                         Deutsche Telekom Laboratories, TU Berlin           *
%                         Ernst-Reuter-Platz 7, 10587 Berlin, Germany        *
%                                                                            *
% This file is part of the Sound Field Synthesis-Toolbox (SFS).              *
%                                                                            *
% The SFS is free software:  you can redistribute it and/or modify it  under *
% the terms of the  GNU  General  Public  License  as published by the  Free *
% Software Foundation, either version 3 of the License,  or (at your option) *
% any later version.                                                         *
%                                                                            *
% The SFS is distributed in the hope that it will be useful, but WITHOUT ANY *
% WARRANTY;  without even the implied warranty of MERCHANTABILITY or FITNESS *
% FOR A PARTICULAR PURPOSE.                                                  *
% See the GNU General Public License for more details.                       *
%                                                                            *
% You should  have received a copy  of the GNU General Public License  along *
% with this program.  If not, see <http://www.gnu.org/licenses/>.            *
%                                                                            *
% The SFS is a toolbox for Matlab/Octave to  simulate and  investigate sound *
% field  synthesis  methods  like  wave  field  synthesis  or  higher  order *
% ambisonics.                                                                *
%                                                                            *
% http://dev.qu.tu-berlin.de/projects/sfs-toolbox       sfstoolbox@gmail.com *
%*****************************************************************************


%% ===== Check input arguments ===========================================
nargmin = 1;
nargmax = 2;
narginchk(nargmin,nargmax);
sig = column_vector(sig);
if nargin<nargmax
    conf = SFS_config;
else
    isargstruct(conf);
end


%% ===== Configuration ===================================================
fs = conf.fs;


%% ===== Calcualate spectrum =============================================
% Generate fast fourier transformation (=> complex output)
compspec = fft(sig);

% Length of the signal => number of points of fft
samples = length(sig);

% Get amplitude and phase spectra (and use only the first half of the
%>spectrum (Nyquist))
amplitude = abs(compspec(1:ceil(samples/2)));
phase = angle(compspec(1:ceil(samples/2)));

% Scale the amplitude (factor two, because we have cut off one half and
%>divide by number of samples)
amplitude = 2*amplitude / samples;

% Calculate corresponding frequency axis
f = fs*(0:ceil(samples/2)-1)/samples;
