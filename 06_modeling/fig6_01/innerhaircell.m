clear all
conf.fs = 44100;
conf.plot.useplot = false;
impulse = [1, zeros(1,8191)];
[b, a] = butter(1, 2000*2/conf.fs);
for ii=1:5
    impulse = filter(b,a, impulse);
end
[a,~,f] = easyfft(impulse,conf);
gp_save('innerhaircell.txt',[f 20*log10(a)]);
