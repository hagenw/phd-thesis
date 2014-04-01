function bm = calculate_binaural_map(sig,fs,model)

if strcmp('dietz',model)
    
    % calculate ITD etc. for the fine structure below 1.4kHz
    [fine,cfreqs,ild,env] = dietz2011(sig,fs,'nolowpass','flow',124,'fhigh',15300,'basef',125);
    % unwrap ITD values
    itd(:,1:15) = dietz2011unwrapitd(fine.itd,ild(:,1:15),fine.f_inst,2.5);
    itd(:,16:36) = dietz2011unwrapitd(env.itd,ild(:,16:36),env.f_inst,2.5);
    % apply IC mask
    for nn=1:36
        if nn<16
            idx = fine.ic(:,nn)>0.98&[diff(fine.ic(:,nn))>0; 0];
        else
            idx = env.ic(:,nn-15)>0.98&[diff(env.ic(:,nn-15))>0; 0];
        end
        itd(~idx,nn) = NaN;
        % remove outlier (|ITD|>3ms)
        itd(abs(itd(:,nn))>0.003,nn) = NaN;
    end

    % reduce size of frequency bands from 36 to 6 via the mean
    bm = itd;
    %bm = zeros(size(sig,1),6)*NaN;
    %for ii=1:6
    %    bm(:,ii) = nanmean(itd(:,(ii-1)*6+1:ii*6),2);
    %end


elseif strcmp('takanen',model)

    to_be_implemented;

end
