function delta = correct_elevation(delta)
%CORRECT_ELEVATION ensures correct values for elevation angles
%
%   Usage: delta = correct_elevation(delta)
%
%   Input parameters:
%       delta     - elevation (rad). Can be a single value or a matrix.
%
%   Output paramteres:
%       delta     - angle between -pi/2 and +pi/2
%
%   CORRECT_ELEVATION(delta) returns a value for elevation delta between
%   -pi/2 and pi/2.
%
%   see also: correct_azimuth, read_irs, get_ir

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


%% ===== Checking of input  parameters ==================================
nargmin = 1;
nargmax = 1;
narginchk(nargmin,nargmax);


%% ===== Computation ====================================================
% Ensure -pi <= delta <= pi
delta = correct_azimuth(delta);
% Ensure -pi/2 <= delta <= pi/2
delta(delta<-pi/2) = -delta(delta<-pi/2) - pi;
delta(delta>pi/2) = -delta(delta>pi/2) + pi;
