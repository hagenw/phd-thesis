% confidence interval
function v = ci(x,dim)
    if nargin==1
        v = 2*std_error(x);
    else
        v = 2*std_error(x,dim);
    end
end
