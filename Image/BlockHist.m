function [ h ] = BlockHist( img,x1,x2,align )
%BLOCKHIST Summary of this function goes here
%   Detailed explanation goes here
    block = img(x1:x1-1+align,x2:x2-1+align);
    h = hist(block(:),1:1:255);
    plot(h);

end

