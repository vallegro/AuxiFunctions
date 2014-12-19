function [ psnr_mat, block_mat ] = CalPSNRPerBlock( a,b ,align )
%CALBLOCKPSNR Summary of this function goes here
%   Detailed explanation goes here
    im_size = size(a);
    mat_size = im_size/align;
    block_mat_size = [mat_size align align];
    
    psnr_mat = zeros(mat_size);
    block_mat = zeros(block_mat_size);
    for i1 = 1:align:im_size(1),
        for i2 = 1:align:im_size(2),
            block_ind1 = (i1-1)/align+1; block_ind2 = (i2-1)/align+1;
            block_psnr = CalPSNR(a(i1:i1+align-1,i2:i2+align-1),...
                                 b(i1:i1+align-1,i2:i2+align-1));
                             
            psnr_mat(block_ind1, block_ind2) = block_psnr;
            block_mat(block_ind1, block_ind2, 1:align, 1:align) = ...
                b(i1:i1+align-1,i2:i2+align-1); 
           
                        
        end
    end                
end

