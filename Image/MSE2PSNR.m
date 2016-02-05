function [ psnr ] = MSE2PSNR( mse )
%MSE2PSNR Summary of this function goes here
%   Detailed explanation goes here

psnr = 10*log10(255*255/mse);
end

