% Kolmogorov-Smirnov distance
% by S.Perugia

function k = ks(p,q)

[m,n]=size(p);

pcdf = zeros(1,n);
qcdf = zeros(1,n);

%% ----- Cumulative Distribution Functions
for i = 1:n
    pa = p(1,1:i);
    pcdf(1,i) = sum (pa);
    qa = q(1,1:i);
    qcdf(1,i) = sum(qa);
end

%% ----- KS distance
k = max(abs(pcdf-qcdf));

end