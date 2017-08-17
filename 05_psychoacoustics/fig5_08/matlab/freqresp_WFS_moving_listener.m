%%
%	Script to create reference, anchor, stereo and WFS impulse responses at
%	different listening positions
%
%   WFS size is 56 speaker, output is written as 720 Channel .wav
%	First to channel will contain computed impulse responses for both ears
%
%   Christoph Hohnerlein, 03.11.13
%   Hagen Wierstorf, 27.01.14
%
%%

clear all
addpath('sfs-master-0.2.2');
SFS_start;
conf=SFS_config_example;
conf.array='circle';
L=3;
no_of_speaker=56;
conf.dx0 = pi*L/no_of_speaker;
conf.useplot =1;
conf.N = 2^13;

conf.usehcomp = false;
irs=dummy_irs;
conf.usehpre=1;
conf.hpreflow  = findhprelow(no_of_speaker,L);
conf.hprefhigh = findhprehigh(no_of_speaker,L,conf.hpreflow);


norm=1;


list_pos = [[0 0];[-0.25 0];[-0.5 0];[-0.75 0];[-1 0];[-1.25 0]; ...
    [-0.25 -0.5];[-0.5 -0.5];[-0.75 -0.5];[-1 -0.5];[-1.25 -0.5]];
list_pos = bsxfun(@minus,list_pos,[0.1 0]);

% WFS
ffts=zeros(4096,size(list_pos,1));
for ii=1:size(list_pos,1)
    ir_wfs = ir_wfs_25d(list_pos(ii,:), pi/2, [0 2.5], 'ps',L,irs,conf);
    if norm==1
        ir_wfs = ir_wfs./max(max(abs(ir_wfs)));
    end
    [a,pf,f]=easyfft(ir_wfs(:,1),conf);
    ffts(:,ii)=a;
end

gp_save('../../fig5_09/data/coloration_wfs_freq_resp_moving.txt',f',ffts);
SFS_stop;
