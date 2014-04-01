%%
%	Script to create reference, anchor, stereo and WFS impulse responses at
%	different listening positions
%
%   WFS size is 56 speaker, output is written as 720 Channel .wav
%	First to channel will contain computed impulse responses for both ears
%
%   Christoph Hohnerlein, 03.11.13
%   Hagen Wierstorf, 27.01.14
%%

clear all
addpath('sfs-master-0.2.2');
SFS_start;
conf=SFS_config;
conf.array='circle';
L=3;
no_of_speaker=2*14;
conf.dx0 = pi*L/no_of_speaker;
conf.useplot =1;
conf.N = 2^13;

conf.usehcomp = false;
irs=dummy_irs;

norm=1;

list_pos=[-0.1 0];


ffts=zeros(4096,10);

% stereo    
ir_1_l= ir_point_source(list_pos, pi/2, [1.4434 2.5],irs,conf);
ir_2_l= ir_point_source(list_pos, pi/2, [-1.4434 2.5],irs,conf);
ir_stereo=ir_1_l+ir_2_l;
if norm==1
    ir_stereo = ir_stereo./max(abs(ir_stereo(:)));
end
[a,pf,f]=easyfft(ir_stereo(:,1),conf);
ffts(:,1) = a;

% WFS
for i=2:10
    i
    no_of_speaker=14*2^(i-2);
    conf.dx0 = pi*L/no_of_speaker;
    conf.usehpre=1;
    conf.hpreflow  = findhprelow(no_of_speaker,L);
    conf.hprefhigh = findhprehigh(no_of_speaker,L,conf.hpreflow);
    ir_wfs = ir_wfs_25d(list_pos, pi/2, [0 2.5], 'ps',L,irs,conf);
    if norm==1
        ir_wfs = ir_wfs./max(abs(ir_wfs(:)));
    end
    [a,pf,f]=easyfft(ir_wfs(:,1),conf);
    ffts(:,i)=a;
end

gp_save('../coloration_wfs_freq_response_center.txt',f',ffts);
SFS_stop;
