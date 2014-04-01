% Randomization vector to ensure an even distribution of the perceived
% directions
rand_vec = zeros(16,3);
rand_vec(:,1) = [-19  -17    1    3   12  -13    4   -2    4   -8  -10 -12  -7  -11   -2    6]';
rand_vec(:,2) = [  0   -5   -6    7    5    9    1   -6   16    2   -4 -20  17   13    5  -16]';
rand_vec(:,3) = [ 11   19   14  -18   -9    6    2   -3   -4   18    7   3  10  -14   -1    8]';

offset_fs = zeros(16,3);
offset_ps = zeros(16,3);
offset_pw = zeros(16,3);
offset_fs(:,1) = [  0  34  50  45 100   0 -15  15  15  12   0   0  10  15  12   8]' + rand_vec(:,1);
offset_fs(:,2) = [  0  34  50  60  45   0 -10 -15   8   5  -3   0   5   0   0 -10]' + rand_vec(:,2);
offset_fs(:,3) = [  0  34  50  50  45   0 -15 -30 -40 -50 -55   0  -8 -10 -15 -25]' + rand_vec(:,3);
offset_ps(:,1) = [  0   3  -3 -16 -15   0   3  -2  -4  -8 -10   0  -2   0  -5  -8]' + rand_vec(:,1);
offset_ps(:,2) = [  0  -2  -4  -6 -14   0  -2  -4  -5  -7 -10   0 -10  -3  -5  -8]' + rand_vec(:,2);
offset_ps(:,3) = [  0  -2  -4 -13 -15   0  -1  -4  -6  -9 -11   0 -10  -3  -4  -5]' + rand_vec(:,3);
offset_pw(:,1) = [  0   2  -2   4  -3   0   0   0   0   0   1   0   0   2   0   1]' + rand_vec(:,1);
offset_pw(:,2) = [  0   0   1   2   3   0   0   0   1   2   0   0   1   0   0   0]' + rand_vec(:,2);
offset_pw(:,3) = [  0   1   2   2   4   0   0   0   1   2   0   0   0   1   0   1]' + rand_vec(:,3);
