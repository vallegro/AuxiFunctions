% pilot estimation by second order classic kernel regression
ksize = 9; % the kernel size
h1=0.5;
[zc, zx1c, zx2c] = ckr2_irregular(y_noise, I, h1, ksize);
% root mean square error
% error = img - zc;
% rmse_ckr = sqrt(mymse(error(:)));

% obtain orientation information
wsize = 9;   % the size of local analysis window
lambda = 1;  % the regularization for the elongation parameter
alpha = 0.1; % the structure sensitive parameter
C = steering(zx1c, zx2c, I, wsize, lambda, alpha);

% applying steering kernel regression for the irregularly sampled image
h = 2.3;
[zs, zx1s, zx2s] = skr2_irregular(y_noise, I, h, C, ksize);
% root mean square error
% error = img - zs;
% rmse_skr = sqrt(mymse(error(:)));

