function get_two_directions(sfs,X,Y,ii,jj,iterations,direction)
phi = sfs(ii,jj,:,:);
phi = phi(:)';
for nn=1:iterations
    label(nn,:) = emgm(phi,2);
    % switch 1 and 2 if the emgm algorithm switched the numbering
    if label(nn,1)==2
        idx1 = (( label(nn,:)==1 ));
        idx2 = (( label(nn,:)==2 ));
        label(nn,idx1) = 2;
        label(nn,idx2) = 1;
    end
end
label = round(mean(label,1));
g1 = mean(phi(label==1));
g2 = mean(phi(label==2));
g1 = g1(~isnan(g1)); % remove NaN entries
g2 = g2(~isnan(g2));

figure; hist(phi(label==1)-direction(ii,jj),-100:4:100); hold on
hist(phi(label==2)-direction(ii,jj),-100:4:100);

fprintf(1,'Means for X = (%1.2f,%1.2f)m: %.2fdeg +- %.2fdeg and %.2fdeg +- %.2fdeg\n', ...
    X(ii),Y(ii),mean(g1),ci(g1),mean(g2),ci(g2));
fprintf(1,'% 4.2f  % 4.2f   % 6.2f   %6.2f\n', ...
    X(ii),Y(ii),mean(g1),mean(g1)-direction(ii,jj));
fprintf(1,'% 4.2f  % 4.2f   % 6.2f   %6.2f\n', ...
    X(ii),Y(ii),mean(g2),mean(g2)-direction(ii,jj));
