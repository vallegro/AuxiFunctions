function [block_direction] = BlockDirection(block)

block = double(block);
fy = [-1,-1,-1;0,0,0;1,1,1];
fx = [-1,0,1;-1,0,1;-1,0,1];

gy = conv2(block,fy,'same');
gx = conv2(block,fx,'same');

gy = gy( 2:end-1 , 2:end-1);
gx = gx( 2:end-1 , 2:end-1);

pixel_direction = gy./(gx+0.0001);
magnitude = sqrt(gy.^2 + gx.^2);
index = magnitude>50;

block_direction = sum(sum(pixel_direction(index)))/(sum(sum(index))+0.01);




