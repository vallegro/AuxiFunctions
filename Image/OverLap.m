function [ im ] = OverLap( im_a, im_b , align )
%OVERLAP Summary of this function goes here
%   Detailed explanation goes here
im_a = double(im_a);
im_b = double(im_b);

kernel = fspecial('gaussian', align ,2);
size_a = size(im_a)/align;
size_b = size(im_b)/align;
kernel_a = repmat(kernel , size_a);
kernel_b = repmat(kernel , size_b);

im_a = im_a.*kernel_a;
im_b = im_b.*kernel_b;

kernel = kernel_a(1+align/2:end-align/2 , 1+align/2:end-align/2) + kernel_b;
im = im_a(1+align/2:end-align/2 , 1+align/2:end-align/2) + im_b;

im = im./kernel;
end

