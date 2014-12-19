function [ ssim ] = CalSSIM( a,b )
%CALSSIM Summary of this function goes here
%   Detailed explanation goes here
    ua = mean(a(:));
    ub = mean(b(:));
    cov_mat = cov(a(:),b(:));
    va = cov_mat(1,1);
    vb = cov_mat(2,2);
    covab = cov_mat(1,2);
    c1 = (0.01*255)^2;
    c2 = (0.03*255)^2;
    ssim = (2*ua*ub + c1) * (2*covab + c2) / ((ua^2 + ub^2 + c1) * (va + vb +c2));
    
end

