function [ldiff,cf] = magnitude_diff_single(array,irs_single,nls,head_orientation,fs,sig_noise,conf)
%% Magnitude deviation function
    for ii = 1:nls
        % real array
        irs = read_irs(array{ii},conf);
        ir = ir_point_source([0 0 0],-pi/2, ...
            irs.source_position'-irs.head_position',irs,conf);
        % get the real amplitude
        sig_real = auralize_ir(ir,sig_noise,0,conf);
        % single loudspeaker array
        ir = ir_point_source([0 0 0],-pi/2, ...
            irs.source_position'-irs.head_position',irs_single,conf);
        sig_single = auralize_ir(ir,sig_noise,0,conf);
        [l_real,cf] = magnitude_erb(sig_real,fs);
        [l_single,cf] = magnitude_erb(sig_single,fs);
        ldiff(:,ii) = l_real-l_single;
    end
    % scale to same level at 1000 Hz due to some deviations during measurement
    % between different positions
    ldiff = bsxfun(@minus,ldiff,ldiff(13,:));
end


