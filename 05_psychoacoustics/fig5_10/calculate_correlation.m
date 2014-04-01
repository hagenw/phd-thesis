% scale everything to lie between [0..1]
% Note, that the low anchor was excluded from the calculation
center_speech_ratings = -1*[0.4517537893 0.8203879423 0.8931140813 0.5766021608 0.5985092224 0.7759043862 0.335106395 0.4218260041 -0.0952912968 -0.2852259973];
center_speech_ratings = center_speech_ratings-min(center_speech_ratings);
center_speech_ratings = center_speech_ratings/max(center_speech_ratings);
center_noise_ratings  = -1*[0.0001468104 0.6495697718 0.6395685248 0.3406761215 0.2987081817 0.2302967951 -0.48161072 -0.303088687 -0.5657024793 -0.4860909884];
center_noise_ratings  = center_noise_ratings-min(center_noise_ratings);
center_noise_ratings  = center_noise_ratings/max(center_noise_ratings);
center_speech_magnitude = abs([0.77300 -0.23800 -0.24800 -0.1080 -0.23700 -0.68200 2.57000 1.71100 1.47100 0.85200]);
center_speech_magnitude = center_speech_magnitude/max(center_speech_magnitude);
center_noise_magnitude  = abs([0.93300 -0.28700 -0.32600 0.05100 -0.32200 -0.89200 1.21400 1.07600 0.31200 1.57600]);
center_noise_magnitude  = center_noise_magnitude/max(center_noise_magnitude);

offcenter_speech_ratings = -1*[-0.4712716389 0.8661157025 0.5573002755 0.6349862259 0.8391762745 0.8914600551 0.4325250258 0.030321169 -0.0836671995 -0.0222494303];
offcenter_speech_ratings = offcenter_speech_ratings-min(offcenter_speech_ratings);
offcenter_speech_ratings = offcenter_speech_ratings/max(offcenter_speech_ratings);
offcenter_noise_ratings  = -1*[-0.7437143602 0.6080037184 0.6932512555 0.3580859096 0.5581709349 0.3119477604 -0.0359974606 -0.0272625242 -0.3404958678 -0.2800893333];
offcenter_noise_ratings  = offcenter_noise_ratings-min(offcenter_noise_ratings);
offcenter_noise_ratings  = offcenter_noise_ratings/max(offcenter_noise_ratings);
offcenter_speech_magnitude = abs([3.45700 0.10700 0.11600 0.47500 0.14900 0.75900 1.48700 0.83300 2.58700 2.29800]);
offcenter_speech_magnitude = offcenter_speech_magnitude/max(offcenter_speech_magnitude);
offcenter_noise_magnitude  = abs([2.46600 -0.5790 -0.5560 0.09000 -0.5030 0.02700 0.19100 0.01600 1.72700 1.28200]);
offcenter_noise_magnitude  = offcenter_noise_magnitude/max(offcenter_noise_magnitude);

movinglistener_speech_ratings = -1*[0.3872711401 0.4127855434 0.4763300797 0.3956058906 0.1732929746 0.0112675577 -0.056171139 0.4069596073 0.3666349239 0.4841886882 0.2049722817];
movinglistener_speech_ratings = movinglistener_speech_ratings-min(movinglistener_speech_ratings);
movinglistener_speech_ratings = movinglistener_speech_ratings/max(movinglistener_speech_ratings);
movinglistener_noise_ratings  = -1*[0.087154372 0.158094979 0.1065832285 0.1919849448 -0.0823237992 -0.348458774 -0.517296421 0.1645206271 0.0980217438 0.1653448061 0.131662302];
movinglistener_noise_ratings  = movinglistener_noise_ratings-min(movinglistener_noise_ratings);
movinglistener_noise_ratings  = movinglistener_noise_ratings/max(movinglistener_noise_ratings);
movinglistener_speech_magnitude = abs([0.41900 -1.3300 -0.6230 -1.5880 -0.3020 1.52000 1.87900 -1.3470 0.09000 -0.3690 -0.9920]);
movinglistener_speech_magnitude = movinglistener_speech_magnitude/max(movinglistener_speech_magnitude);
movinglistener_noise_magnitude  = abs([0.86280 -1.4255 -0.4201 -1.7862 0.14260 2.01310 1.10660 -0.7339 -0.6663 -0.1630 -1.1697]);
movinglistener_noise_magnitude  = movinglistener_noise_magnitude/max(movinglistener_noise_magnitude);


% Calculate Pearson Coefficient
disp('center, speech')
corr(center_speech_ratings,center_speech_magnitude)
disp('center, noise')
corr(center_noise_ratings,center_noise_magnitude)
disp('offcenter, speech')
corr(offcenter_speech_ratings,offcenter_speech_magnitude)
disp('offcenter, noise')
corr(offcenter_noise_ratings,offcenter_noise_magnitude)
disp('movinglistener, speech')
corr(movinglistener_speech_ratings,movinglistener_speech_magnitude)
disp('movinglistener, noise')
corr(movinglistener_noise_ratings,movinglistener_noise_magnitude)

% vim: set textwidth=300:
