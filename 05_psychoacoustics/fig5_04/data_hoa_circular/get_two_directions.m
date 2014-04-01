function get_two_directions(sfs,X,Y,xx,yy,iterations,direction)
for nn=1:iterations
    label(nn,:) = emgm(sfs{yy}(:,xx)',2);
    % switch 1 and 2 if the emgm algorithm switched the numbering
    if label(nn,1)==2
        idx1 = (( label(nn,:)==1 ));
        idx2 = (( label(nn,:)==2 ));
        label(nn,idx1) = 2;
        label(nn,idx2) = 1;
    end
end
label = round(mean(label,1));
g1 = mean(sfs{yy}(label==1,xx));
g2 = mean(sfs{yy}(label==2,xx));
g1 = g1(~isnan(g1)); % remove NaN entries
g2 = g2(~isnan(g2));

figure; hist(sfs{yy}(label==1,xx)+direction(xx,yy),-100:4:100); hold on
hist(sfs{yy}(label==2,xx)+direction(xx,yy),-100:4:100);

fprintf(1,'Means for X = (%1.2f,%1.2f)m: %.2fdeg +- %.2fdeg and %.2fdeg +- %.2fdeg\n', ...
    X(xx),Y(yy),mean(g1),ci(g1),mean(g2),ci(g2));
fprintf(1,'% 4.2f  % 4.2f   % 6.2f   %6.2f\n', ...
    X(xx),Y(yy),mean(g1)+direction(xx,yy),mean(g1));
fprintf(1,'% 4.2f  % 4.2f   % 6.2f   %6.2f\n', ...
    X(xx),Y(yy),mean(g2)+direction(xx,yy),mean(g2));
