function matlab_version_missing(mfile)
%MATLAB_VERSION_MISSING indicates a function that is not implemented yet
%
%   Usage: matlab_version_missing([mfilename])
%
%   Input parameters
%       mfile   - string containing the name of the calling m file.
%                 NOTE: this variable is already avaiable in all m files as
%                 mfilename!
%
%   MATLAB_VERSION_MISSING(mfile) results in an error that indicates that the
%   desired plot functionality has to be implemented in Matlab. This is the
%   case for a some heavier plotting functions that are first implemented using
%   Gnuplot.

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


%% ===== Checking of input parameters ====================================
nargmin = 0;
nargmax = 1;
narginchk(nargmin,nargmax);
if exist('mfile','var')
    if ~ischar(mfile)
        error('%s: mfile has to be a string.',upper(mfilename));
    end
    filename = true;
else
    filename = false;
end


%% ===== Main ============================================================
if(filename)
    error(['%s: The Matlab version of the movie function has to be ', ...
        'implemented yet. You can use the Gnuplot version by setting ', ...
        'conf.gnuplot = 1. If you need the Matlab version, please feel ', ...
        'free to implement it ;)'],upper(mfile));
else
    error(['The Matlab version of the movie function has to be ', ...
        'implemented yet. You can use the Gnuplot version by setting ', ...
        'conf.gnuplot = 1. If you need the Matlab version, please feel ', ...
        'free to implement it ;)']);
end
