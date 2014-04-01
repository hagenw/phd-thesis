% standard error
function v = std_error(x,dim)
    if nargin==1
        v = nanstd(x)/sqrt(length(x));
    elseif dim==1
        for ii=1:size(x,2)
            for jj=1:size(x,3)
                v(ii,jj) = nanstd(x(:,ii,jj))./sqrt(length(x(:,ii,jj)));
            end
        end
    elseif dim==2
        for ii=1:size(x,1)
            for jj=1:size(x,3)
                v(ii,jj) = nanstd(x(ii,:,jj))./sqrt(length(x(ii,:,jj)));
            end
        end
    end
end
