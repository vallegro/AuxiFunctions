function [ psnr ] = CalPSNRMask( a,b,mask )
%CALPSNRMASK Summary of this function goes here
%   Detailed explanation goes here
a(mask==0) = 0; 
b(mask==0) = 0;
count = mask~=0;
count = sum(count(:));
err = double(a) - double(b);
mse = sum(sum(err.* err))/count;
psnr = 10*log10(255*255/mse);

end

