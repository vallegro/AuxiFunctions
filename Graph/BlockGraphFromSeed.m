function [ graph ] = BlockGraphFromSeed( graph_seed ,neis )
%NODE2LAP Summary of this function goes here
%   Detailed explanation goes here
%   tracked on Nov 11, 2014. coded by vall.

block_size = size(graph_seed);
block_total = block_size(1)*block_size(2);

graph = zeros(block_total);

var_block = max( var(graph_seed(:)), 0.01 );
        
for i_node = 1:block_total,
    [sub1,sub2] = ind2sub(block_size, i_node);
    for i_nei = 1:length(neis)
        sub_nei = [sub1,sub2] + neis(i_nei,:);
        if sub_nei(1)>0 && sub_nei(2)>0 && sub_nei(1)<= block_size(1) && sub_nei(2)<=block_size(2),
            ind_nei = sub2ind( block_size, sub_nei(1),sub_nei(2));
            graph( ind_nei , i_node ) = exp( -(graph_seed(i_node)-graph_seed(ind_nei))^2/300);
            graph( i_node , ind_nei ) = graph( ind_nei , i_node );
        end
    end
end
        


end