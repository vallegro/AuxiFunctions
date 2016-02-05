function [noised] = AddNoise(ori)
    size_ori = size(ori);
    %Gaussian    
    noise_normal = normrnd(0,2,size_ori);
    noised = uint8(double(ori) + noise_normal);
    

end