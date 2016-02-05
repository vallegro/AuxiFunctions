function [z, zx1, zx2] = ckr2_irregular(y, I, h, ksize)
% [CKR2_IRREGULAR]
% The second order classic kernel regression function for irregularly
% sampled data.
%
% [USAGE]
% [z, zx1, zx2] = ckr2_irregular(y, I, h, r, ksize)
%
% [RETURNS]
% z     : the estimated image
% zx1   : the estimated gradient image along the x1 direction (vertical
%        direction)
% zx2   : the estimated gradient image along the x2 direction (horizontal
%        direction)
%
% [PARAMETERS]
% y     : the input image
% I     : The sampling position map (I(n,m) == 0 for no sample at (n,m))
% h     : the global smoothing parameter
% ksize : the size of the kernel (ksize x ksize, and "ksize" must be
%         an odd number)
%
% [HISTORY]
% June 16, 2007 : created by Hiro
% Apr  14, 2008 : the transpose operator is fixed by Hiro

% Get the oritinal image size
[N, M] = size(y);

% Initialize the return parameters
z = zeros(N, M);
zx1 = zeros(N, M);
zx2 = zeros(N, M);

% Pixel sampling positions
radius = (ksize - 1) / 2;
[x2, x1] = meshgrid(-radius:radius, -radius:radius);

% The feture matrix
Xx = [ones(ksize^2,1), x1(:), x2(:), x1(:).^2, x1(:).*x2(:), x2(:).^2];

% compute the weight matrix
tt = x1.^2 + x2.^2;
W = exp(-(0.5/h^2) * tt);

% Mirroring
y = EdgeMirror(y, [radius, radius]);
I = EdgeMirror(I, [radius, radius]);

% Estimate an image and its first gradients with pixel-by-pixel        
for n = 1 : N
    for m = 1 : M
            
        % Neighboring samples to be taken account into the estimation
        yp = y(n:n+ksize-1, m:m+ksize-1);
            
        % Zero weights where there is no sample
        WI = W .* I(n:n+ksize-1, m:m+ksize-1);
                
        % Equivalent kernel
        Xw = [Xx(:,1).*WI(:), Xx(:,2).*WI(:), Xx(:,3).*WI(:),...
                Xx(:,4).*WI(:), Xx(:,5).*WI(:), Xx(:,6).*WI(:)];
        A = inv(Xx' * Xw + eye(6)*0.00001) * (Xw');
                
        % Estimate the pixel values at (nn,mm)
        z(n,m)   = A(1,:) * yp(:);
        zx1(n,m) = A(2,:) * yp(:);
        zx2(n,m) = A(3,:) * yp(:);
        
    end
end
