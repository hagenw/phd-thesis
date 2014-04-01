clear all
% show figures of all results
show_figures = false;
% get common config data
configuration;
% load VP file names
get_filenames;


% === NFC-HOA Plane Wave =================================================
% get the results for every single person
for nn=1:size(files_pw,1)
    for yy=1:length(Y)
        [tmp_data14, ...
         tmp_real14, ...
         tmp_data28, ...
         tmp_real28, ...
         tmp_data56, ...
         tmp_real56, ...
         tmp_data1456, ...
         tmp_real1456] = get_pooled_data(files_pw{nn,yy},nconditions(yy));
        % store in cell
        data14(:,nn,yy) = {tmp_data14};
        real14(:,nn,yy) = {tmp_real14};
        data28(:,nn,yy) = {tmp_data28};
        real28(:,nn,yy) = {tmp_real28};
        data56(:,nn,yy) = {tmp_data56};
        real56(:,nn,yy) = {tmp_real56};
        data1456(:,nn,yy) = {tmp_data1456};
        real1456(:,nn,yy) = {tmp_real1456};
    end
end

% check for normality of the data and calculate the mean etc.
% subtract the real position of the virtual sources to get only the deviation
sfs14 = {};
sfs28 = {};
sfs56 = {};
sfs1456 = {};
for yy=1:length(Y)
    sfs14(yy) = cell2mat(data14(1,:,yy)') - cell2mat(real14(1,:,yy)');
    sfs28(yy) = cell2mat(data28(1,:,yy)') - cell2mat(real28(1,:,yy)');
    sfs56(yy) = cell2mat(data56(1,:,yy)') - cell2mat(real56(1,:,yy)');
    sfs1456(yy) = cell2mat(data1456(1,:,yy)') - cell2mat(real1456(1,:,yy)');
end
if show_figures
    % visual inspection for normality of the data
    for yy=1:length(Y)
        for xx=1:length(X)
            if Y(yy)~=0 && X(xx)==-1.25 % handle different length of X for different Y values
                continue;
            else
                figure; hist(sfs14{yy}(:,xx),-150:10:150)
                title(sprintf('NFC-HOA pw 14 loudspeaker, 7th order, X = (%1.2f,%1.2f)m',X(xx),Y(yy)));
                figure; hist(sfs28{yy}(:,xx),-150:10:150)
                title(sprintf('NFC-HOA pw 28 loudspeaker, 14th order, X = (%1.2f,%1.2f)m',X(xx),Y(yy)));
                figure; hist(sfs56{yy}(:,xx),-150:10:150)
                title(sprintf('NFC-HOA pw 56 loudspeaker, 28th order, X = (%1.2f,%1.2f)m',X(xx),Y(yy)));
                figure; hist(sfs1456{yy}(:,xx),-150:10:150)
                title(sprintf('NFC-HOA pw 14 loudspeaker, 28th order, X = (%1.2f,%1.2f)m',X(xx),Y(yy)));
            end
        end
    end
end


% calculate seperated means for the cases of more than one source
% use a Gaussian mixture model to find what data point belongs to what
% distribution
iterations = 100;
warning('off');
fprintf('NFC-HOA plane wave 28 loudspeaker, 14th order\n');
get_two_directions(sfs28,X,Y,5,3,iterations,direction_pw)
fprintf('NFC-HOA plane wave 28 loudspeaker, 14th order\n');
get_two_directions(sfs28,X,Y,6,2,iterations,direction_pw)
fprintf('NFC-HOA plane wave 14 loudspeaker, 7th order\n');
get_two_directions(sfs14,X,Y,6,2,iterations,direction_pw)
fprintf('NFC-HOA plane wave 14 loudspeaker, 7th order\n');
get_two_directions(sfs14,X,Y,5,2,iterations,direction_pw)
fprintf('NFC-HOA plane wave 14 loudspeaker, 7th order\n');
get_two_directions(sfs14,X,Y,5,1,iterations,direction_pw)
fprintf('NFC-HOA plane wave 14 loudspeaker, 7th order\n');
get_two_directions(sfs14,X,Y,4,1,iterations,direction_pw)
