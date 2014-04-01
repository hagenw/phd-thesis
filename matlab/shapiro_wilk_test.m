function [W] = shapiro_wilk_test(x)
%SHAPIRO_WILK_TEST Shapiro-Wilk' W statistic for assessing a sample normality.
% This m-file is generating from the Fortran Algorithm AS R94 (Royston,
% 1995) [URL address http://lib.stat.cmu.edu/apstat/181]. Here we take only
% the procedure to generate the Shapiro-Wilk's W statistic, needed to feed
% the Royston's test for multivariate normality. Here, we present both the
% options for the sample kurtosis type: 1) Shapiro-Francia for leptokurtic,
% and 2) Shapiro-Wilk for the platykurtic ones. Do not assume that the
% result of the Shapiro-Wilk test is clear evidence of normality or non-
% normality, it is just one piece of evidence that can be helpful.
%
% Input:
%      x - data vector (3 < n < 5000)
%
% Output:
%      W - Shapiro-Wilk's W statistic
%
% Example: From the example given by Scholtz and Stephens (1987, p.922). We
% only take the data set from laboratory 1 of eight measurements of the
% smoothness of a certain type of paper:38.7,41.5,43.8,44.5,45.5,46.0,47.7,
% 58.0
%
% Data vector is:
%  x=[38.7,41.5,43.8,44.5,45.5,46.0,47.7,58.0];
%
% Calling on Matlab the function: 
%          W = ShaWilstat(x)
%
% Answer is:
%
% W = 0.8476
%
% Created by A. Trujillo-Ortiz, R. Hernandez-Walls, K. Barba-Rojo, 
%             and L. Cupul-Magana
%             Facultad de Ciencias Marinas
%             Universidad Autonoma de Baja California
%             Apdo. Postal 453
%             Ensenada, Baja California
%             Mexico.
%             atrujo@uabc.mx
%
% Copyright. November 18, 2007.
%
% Reference:
% Scholz, F.W. and Stephens, M.A. (1987), K-Sample Anderson-Darling Tests.
%     Journal of the American Statistical Association, 82:918-924.
%

x  =  x(:); %put data in a column vector
n = length(x); %sample size

if n < 3,
   error('Sample vector must have at least 3 valid observations.');
end

if n > 5000,
    warning('Shapiro-Wilk statistic might be inaccurate due to large sample size ( > 5000).');
end

x = sort(x); %sorting of data vector in ascending order
m = norminv(((1:n)' - 3/8) / (n + 0.25));
w = zeros(n,1); %preallocating weights

if kurtosis(x) > 3, %Shapiro-Francia test is better for leptokurtic samples
    w = 1/sqrt(m'*m) * m;
    W = (w' * x) ^2 / ((x - mean(x))' * (x - mean(x)));
else %Shapiro-Wilk test is better for platykurtic samples
    c = 1/sqrt(m' * m) * m;
    u = 1/sqrt(n);
    p1 = [-2.706056,4.434685,-2.071190,-0.147981,0.221157,c(n)];
    p2 = [-3.582633,5.682633,-1.752461,-0.293762,0.042981,c(n-1)];

    w(n) = polyval(p1,u);
    w(1) = -w(n);

    if n == 3,
        w(1) = 0.707106781;
        w(n) = -w(1);
    end

    if n >= 6,
        w(n-1) = polyval(p2,u);
        w(2) = -w(n-1);
    
        ct =  3;
        phi = (m'*m - 2 * m(n)^2 - 2 * m(n-1)^2) / ...
                (1 - 2 * w(n)^2 - 2 * w(n-1)^2);
    else
        ct = 2;
        phi = (m'*m - 2 * m(n)^2) / (1 - 2 * w(n)^2);
    end

    w(ct:n-ct+1) = m(ct:n-ct+1) / sqrt(phi);

    W = (w' * x) ^2 / ((x - mean(x))' * (x - mean(x)));
end

return; 
