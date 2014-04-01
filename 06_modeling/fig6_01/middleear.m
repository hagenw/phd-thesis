clear all
conf.fs = 44100;
conf.plot.useplot = false;
impulse = [1, zeros(1,8191)];
[b,a] = butter(2,2000/(conf.fs/2),'low');
sig = filter(b,a,impulse);
[b,a] = butter(2,500/(conf.fs/2),'high');
sig = filter(b,a,sig);
[a,~,f] = easyfft(sig,conf);
gp_save('middleear.txt',[f 20*log10(a)]);
