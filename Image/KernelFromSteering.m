function[W] = KernelFromSteering( c, k_size,h )
%KERNELFROMSTEERING Summary of this function goes here
%   Detailed explanation goes here   
    [y,x] = meshgrid( -k_size:k_size, -k_size:k_size);
    tt = x .* (c(1,1) .* x+ c(1,2) .* y)+ y .* (c(1,2).* x+c(2,2) .* y);
    sq_detC = sqrt(det(c))
    W = exp(-(0.5/h^2) * tt);

end

