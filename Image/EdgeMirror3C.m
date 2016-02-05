function y = EdgeMirror3C( x, width )
%EDGEM Summary of this function goes here
%   Detailed explanation goes here

y = cat(2, x(:, width(2)+1:-1:2,:), x, x(: ,end-1:-1:end-width(2),:));
y = cat(1, y(width(1)+1:-1:2, :,:), y, y(end-1:-1:end-width(1), :,:));
end

