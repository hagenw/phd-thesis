% X,Y points
X = 0:-0.25:-1.25;
Y = [-0.75 0 0.75];
% number of conditions for the different Y positions
nconditions = [5 6 5];
% add additional functions
addpath('../../../matlab');

% calculate real direction of virtual sources
% point source
for xx=1:length(X)
    for yy=1:length(Y)
        direction_ps(xx,yy) = deg(source_direction([X(xx) Y(yy) 0],[0 2.5 0],'ps')+pi/2);
    end
end
% plane wave
for xx=1:length(X)
    for yy=1:length(Y)
        direction_pw(xx,yy) = deg(source_direction([X(xx) Y(yy) 0],[0 -1 0],'pw')+pi/2);
    end
end
% focused source
for xx=1:length(X)
    for yy=1:length(Y)
        direction_fs(xx,yy) = deg(source_direction([X(xx) Y(yy) 0],[0 0.5 0],'fs')+pi/2);
    end
end
