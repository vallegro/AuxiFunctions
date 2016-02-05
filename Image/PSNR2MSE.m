function [ mse ] = PSNR2MSE( psnr )
%PSNR2MSE Summary of this function goes here
%   Detailed explanation goes here

mse = 255*255/(10^(psnr/10));

end

