% pilot estimation by second order classic kernel regression
h = 2.3;    % the global smoothing parameter
ksize = 15; % the kernel size
[zc, zx1c, zx2c] = ckr2_irregular(y_noise, I, h, ksize);
% root mean square error
error = img - zc;
rmse_ckr = sqrt(mymse(error(:)));

% obtain orientation information
wsize = 9;   % the size of local analysis window
lambda = 1;  % the regularization for the elongation parameter
alpha = 0.1; % the structure sensitive parameter
C = steering(zx1c, zx2c, I, wsize, lambda, alpha);

% applying steering kernel regression for the irregularly sampled image
h = 2.3;
[zs, zx1s, zx2s] = skr2_irregular(y, I, h, C, ksize);
% root mean square error
error = img - zs;
rmse_skr = sqrt(mymse(error(:)));
[N, M] = size(y);
IT=15;r=1;
z = zeros(N, M, IT+1);
zx1 = zeros(N, M, IT+1);
zx2 = zeros(N, M, IT+1);
rmse = zeros(IT+1, 1);
z(:,:,1) = y;
zx1(:,:,1) = zx1c;
zx2(:,:,1) = zx2c;
error = img - y;
rmse(1) = sqrt(mymse(error(:)));

for i = 2 : IT+1
    % compute steering matrix
    C = steering(zx1(:,:,i-1), zx2(:,:,i-1), ones(size(img)), wsize, lambda, alpha);
    % steering kernel regression
    [zs, zx1s, zx2s] = skr2_regular(z(:,:,i-1), h, C, r, ksize);
    z(:,:,i) = zs;
    %imtool(uint8(zs));
    zx1(:,:,i) = zx1s;
    zx2(:,:,i) = zx2s;
    % root mean square error
    error = img - zs;
    rmse(i) = sqrt(mymse(error(:)));
    rmse(i)
    %figure(99); imagesc(zs); colormap(gray); axis image; pause(1);
end