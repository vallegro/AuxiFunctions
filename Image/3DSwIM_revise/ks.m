% Kolmogorov-Smirnov distance
% by S.Perugia

function [k,idx] = ks(p,q)

% [m,n]=size(p);
n=length(p);

pcdf = zeros(1,n);
qcdf = zeros(1,n);

%% ----- Cumulative Distribution Functions
for i = 1:n
    pa = p(1:i);
    pcdf(i) = sum (pa);
    qa = q(1:i);
    qcdf(i) = sum(qa);
end

% figure;
% plot(1:n,pcdf,'-bo',1:n,qcdf,'-r*');
% grid on

%% ----- KS distance
[k,idx] = max(abs(pcdf-qcdf));
idx;

end