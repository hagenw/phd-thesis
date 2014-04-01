clear all
addpath('../../matlab');


% SFS configuration
conf.debug = 0;
conf.c = 343;
conf.fs = 44100;
conf.secondary_sources.number = 34;
conf.secondary_sources.size = 20;
conf.secondary_sources.center = [0 0 0];
conf.secondary_sources.geometry = 'linear';
conf.secondary_sources.x0 = [];
conf.usenormalisation = true;
conf.usetapwin = false;
conf.tapwinlen = 0.3;
conf.xref = [4 -4 0];
conf.N = 2*4096;
conf.driving_functions = 'default';
conf.dimension = '2.5D';
conf.usebandpass = false;
conf.usefracdelay = false;
conf.fracdelay_method = '';
conf.wfs.usehpre = false;
conf.wfs.hpretype = 'FIR';
conf.ir.useoriglength = false;
conf.ir.useinterpolation = true;
conf.ir.usehcomp = true;
conf.ir.hcompfile = 'QU_KEMAR_AKGK601_hcomp.wav';
conf.speechfile = 'speech.wav';
conf.plot.useplot = false;


irs = read_irs('QU_KEMAR_anechoic_3m.mat',conf);

X = [4 -4 0];
phi = pi/2;
% calculate the time response of a point source in WFS
xs = [0 1 0];
src = 'ps';
ir = ir_wfs(X,phi,xs,src,irs,conf);
% shorten the impulse response
ir = ir(2000:6000,:);
% calculate the spectrum
[a,p,f] = easyfft(ir(:,1),conf);
% save time signal and spectrum
gp_save('wfs_point_source.txt',norm_signal(ir(:,1)),'magnitude');
gp_save('wfs_point_source_time_reversed.txt',norm_signal(ir(end:-1:1,1)),'magnitude');
gp_save('wfs_point_source_spectrum.txt',[f 20*log10(abs(a))+90],'F/Hz magnitude');
% generate audio files
sig1 = auralize_ir(ir,'speech',1,conf);
sig2 = auralize_ir(ir(end:-1:1,:),'speech',1,conf);
wavwrite(ir,44100,16,'ir_wfs_point_source.wav');
wavwrite(ir(end:-1:1,:),44100,16,'ir_wfs_point_source_time_reversed.wav');
wavwrite(sig1,44100,16,'wfs_point_source.wav');
wavwrite(sig2,44100,16,'wfs_point_source_time_reversed.wav');
