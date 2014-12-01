function [ psnr ] = CalPSNR( a,b )
%CALPSNR Summary of this function goes here
%   Detailed explanation goes here
err = double(a) - double(b);
mse = sum(sum(err.* err))/length(a(:));
psnr = 10*log10(255*255/mse);



end

