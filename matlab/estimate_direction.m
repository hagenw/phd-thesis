function [phi,phi_std] = estimate_direction(ir,lookup,nruns,conf)

% get noise signals
for nn=1:nruns
    noise_sig(:,nn) = localization_noise();
end

for ii=1:size(ir,3)
    if conf.showprogress, progress_bar(ii,size(ir,3)); end;
    for nn=1:nruns
        phi_tmp(nn) = wierstorf2013estimateazimuth(auralize_ir(ir(:,:,ii),noise_sig(:,nn),1,conf),lookup);
    end
    phi(ii) = mean(phi_tmp);
    phi_std(ii) = std(phi_tmp);
end
