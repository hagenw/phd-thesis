function phi = source_direction(X,xs,src)
%SOURCE_DIRECTION returns the direction of the sound event for the given source
%
%   Usage: phi = source_direction(X,xs,src) 
%
%   Input parameters:
%       X       - position of the listener
%       xs      - position of the source
%       src     - source type of the virtual source
%                     'pw' - plane wave (xs is the direction of the
%                            plane wave in this case)
%                     'ps' - point source
%                     'fs' - focused source
%
%   Output parameters:
%       phi     - azimuth angle of source
%
%   SOURCE_DIRECTION(X,xs,src) calculates the azimuth angle for the direction of
%   the virtual source of type "src" positioned at xs for a listener placed at
%   X.
%
%   see also: estimate_azimuth, localization_map_wfs_25d

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


%% ===== Checking input parameters =======================================
nargmin = 3;
nargmax = 3;
narginchk(nargmin,nargmax);
isargchar(src);
isargxs(xs);
isargposition(X);


%% ===== Computation =====================================================
if strcmp('pw',src)
    [phi,~,~] = cart2sph(xs(1),xs(2),xs(3));
elseif strcmp('ps',src)
    x = xs-X;
    [tmp,~,~] = cart2sph(x(1),x(2),x(3));
    phi = tmp-pi;
elseif strcmp('fs',src)
    x = xs-X;
    [tmp,~,~] = cart2sph(x(1),x(2),x(3));
    phi = tmp-pi;
else
    error('%s: src has to be one of "pw", "ps", "fs"!',upper(mfilename));
end
