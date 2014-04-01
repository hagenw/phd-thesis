clear all
% show figures of all results
show_figures = true;
% get common config data
configuration;
% load VP file names
get_filenames;


% === NFC-HOA Point Source ===============================================
% get the results for every single person
for nn=1:size(files_ps,1)
    for yy=1:length(Y)
        [tmp_data14, ...
         tmp_real14, ...
         tmp_data28, ...
         tmp_real28, ...
         tmp_data56, ...
         tmp_real56] = get_pooled_data(files_ps{nn,yy},nconditions(yy));
        % store in cell
        data14(:,nn,yy) = {tmp_data14};
        real14(:,nn,yy) = {tmp_real14};
        data28(:,nn,yy) = {tmp_data28};
        real28(:,nn,yy) = {tmp_real28};
        data56(:,nn,yy) = {tmp_data56};
        real56(:,nn,yy) = {tmp_real56};
    end
end

% check for normality of the data and calculate the mean etc.
% subtract the real position of the virtual sources to get only the deviation
sfs14 = {};
sfs28 = {};
sfs56 = {};
for yy=1:length(Y)
    sfs14(yy) = cell2mat(data14(1,:,yy)') - cell2mat(real14(1,:,yy)');
    sfs28(yy) = cell2mat(data28(1,:,yy)') - cell2mat(real28(1,:,yy)');
    sfs56(yy) = cell2mat(data56(1,:,yy)') - cell2mat(real56(1,:,yy)');
end
if show_figures
    % visual inspection for normality of the data
    for yy=1:length(Y)
        for xx=1:length(X)
            if Y(yy)~=0 && X(xx)==-1.25 % handle different length of X for different Y values
                continue;
            else
                figure; hist(sfs14{yy}(:,xx),-150:10:150)
                title(sprintf('WFS ps 14 loudspeaker, X = (%1.2f,%1.2f)m',X(xx),Y(yy)));
                figure; hist(sfs28{yy}(:,xx),-150:10:150)
                title(sprintf('WFS ps 28 loudspeaker, X = (%1.2f,%1.2f)m',X(xx),Y(yy)));
                figure; hist(sfs56{yy}(:,xx),-150:10:150)
                title(sprintf('WFS ps 56 loudspeaker, X = (%1.2f,%1.2f)m',X(xx),Y(yy)));
            end
        end
    end
end


% calculate seperated means for the cases of more than one source
% use a Gaussian mixture model to find what data point belongs to what
% distribution
%iterations = 100;
%warning('off');
%fprintf('NFC-HOA point source 14 loudspeaker, 7th order\n');
%get_two_directions(sfs14,X,Y,6,2,iterations,direction_ps)
%fprintf('NFC-HOA point source 14 loudspeaker, 7th order\n');
%get_two_directions(sfs14,X,Y,5,2,iterations,direction_ps)
%fprintf('NFC-HOA point source 14 loudspeaker, 7th order\n');
%get_two_directions(sfs14,X,Y,4,2,iterations,direction_ps)
%fprintf('NFC-HOA point source 14 loudspeaker, 7th order\n');
%get_two_directions(sfs14,X,Y,5,1,iterations,direction_ps)
