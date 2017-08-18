# 165 Hz
set palette defined (0 '#ffffff',1 '#0025ad')  # blue
plot for [ii=1:3] datafile.'.txt' every 20 u (column(ii)*1000):(limity($0*20/FS)):(column(ii+36)) w p pt 7 ps PS lc palette
load 'noborder.cfg'
unset grid
unset label
unset arrow
# 316 Hz
set palette defined (0 '#ffffff',1 '#00ada4')  # cyan
plot for [ii=4:6] datafile.'.txt' every 20 u (column(ii)*1000):(limity($0*20/FS)):(column(ii+36)) w p pt 7 ps PS lc palette
# 524 Hz
set palette defined (0 '#ffffff',1 '#5fad00')
plot for [ii=7:9] datafile.'.txt' every 20 u (column(ii)*1000):(limity($0*20/FS)):(column(ii+36)) w p pt 7 ps PS lc palette
# 812 Hz
set palette defined (0 '#ffffff',1 '#ad8800')
plot for [ii=10:12] datafile.'.txt' every 20 u (column(ii)*1000):(limity($0*20/FS)):(column(ii+36)) w p pt 7 ps PS lc palette
# 1210 Hz
set palette defined (0 '#ffffff',2 '#ad1400')  # red
plot for [ii=13:15] datafile.'.txt' every 20 u (column(ii)*1000):(limity($0*20/FS)):(column(ii+36)) w p pt 7 ps PS lc palette
