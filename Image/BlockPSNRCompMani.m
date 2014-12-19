function [ mani ] = BlockPSNRCompMani( a ,b ,c ,align)
%BLOCKPSNRCOMPMANI Summary of this function goes here
%   Detailed explanation goes here
    im_size = size(a);
    im_size3c = [im_size 3];
    mani = zeros(im_size3c);
    color = zeros(im_size3c);
    psnr_mat1 = CalPSNRPerBlock(a,c,align);
    psnr_mat2 = CalPSNRPerBlock(b,c,align);
    better1 = (psnr_mat1 > psnr_mat2);
    better2 = (psnr_mat2 > psnr_mat1);
    b = ones(align);
    color(:,:,1) = kron(better1 , b)*255;
    color(:,:,2) = kron(better2 , b)*255;
    c_edge = edge(c,'canny')*255;
    for i= 1:3,
        mani(1:im_size(1),1:im_size(2),i) = c+c_edge; 
    end
    mani = uint8(0.75*mani+0.25*color);
    
end

