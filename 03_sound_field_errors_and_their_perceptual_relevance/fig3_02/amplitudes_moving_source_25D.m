clear all;
create_dir('data');

%% ===== Configuration ===================================================
X = [0 0 2]; % / m
Y = [-4 -2 -2]; % / m
Z = 0; % / m
f = 1000; % / Hz
xsy{1} = [8:-0.01:-3.9];
xsy{2} = [8:-0.01:-1.9];
xsy{3} = [8:-0.01:-1.9];

%% ===== Toolbox settings ================================================
conf.resolution = 1000; % / samples
conf.xref = [0 -2 0]; % / m
conf.dimension = '2.5D';
conf.c = 343; % / m/s
conf.driving_functions = 'default';
conf.phase = 0; % / rad
conf.usenormalisation = false;
conf.plot.useplot = false;
conf.usetapwin = false;
conf.tapwinlen = 0.3;
conf.showprogress = false;

%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 100; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'line';
conf.secondary_sources.number = 1000;
conf.secondary_sources.x0 = [];
% get secondary sources and store them, to do this calculation only once
x0 = secondary_source_positions(conf);
conf.secondary_sources.x0 = x0;

for jj=1:length(Y)

    P1 = [];
    P2 = [];

    %% ===== Reference Sources ===============================================
    for ii=1:length(xsy{jj})
        xs = [0 xsy{jj}(ii) 0];
        % --- point source ---
        P1(ii) = sound_field_mono_point_source(X(jj),Y(jj),Z,xs,f,conf);
    end

    %% ===== Wave Field Synthesis ============================================
    for ii=1:length(xsy{jj})
        if xsy{jj}(ii)>conf.secondary_sources.center(2)+0.1
            % --- point source ---
            xs = [0 xsy{jj}(ii) 0];
            src = 'ps';
        elseif xsy{jj}(ii)<conf.secondary_sources.center(2)-0.1
            % --- focused source ---
            xs = [0 xsy{jj}(ii) 0 0 -1 0];
            src = 'fs';
        else
            P2(ii) = NaN;
            continue;
        end
        progress_bar(ii,length(xsy{jj}))
        P2(ii) = sound_field_mono_wfs(X(jj),Y(jj),Z,xs,src,f,conf);
    end

    % --- smooth focused source ---
    % find index of first focused source entry
    idx = find(xsy{jj}<-0.1,1,'first');
    [b,a] = butter(4,700/22050,'low');
    P3 = db(abs(P2));
    P3(idx:end) = filtfilt(b,a,db(abs(P2(idx:end)')));

    %% ===== Save to File ====================================================
    M = [xsy{jj}' db(abs(P1')) db(abs(P2')) P3'];
    header = 'y point_source WFS_25D_point_source';
    file = sprintf('data/amplitudes_moving_source_25D_X%.1f_Y%.1f.txt', ...
                   X(jj),Y(jj));
    gp_save(file,M,header);
end
