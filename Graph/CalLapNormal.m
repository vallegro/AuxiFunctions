function [ lap ] = CalLapNormal( graph )
%CAL_LAP Summary of this function goes here
%   Detailed explanation goes here
    D = diag(sum(graph)+0.0001);
    lap = D - graph;
    lap = D^(-1/2)*lap*D^(-1/2);
end

