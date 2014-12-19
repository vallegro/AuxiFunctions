function [ err ] = DispErr( im1 , im2 )
%DISPERR Summary of this function goes here
%   Detailed explanation goes here
    err = abs ( double(im1) - double(im2));
    imtool(uint8(err));

end

