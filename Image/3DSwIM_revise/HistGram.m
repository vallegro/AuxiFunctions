function H = HistGram(X,minX,maxX)
% bin the range minX to maxX wiht every 10 values. Then count the number.

scale=10;

LB = floor(minX/scale)*scale;
HB = ceil(maxX/scale)*scale;

LenH=(HB-LB)/scale;
H=zeros(1,LenH);

for m = 1:LenH
    ind = find(X >= LB+scale*(m-1) & X < LB+scale*m);
    H(m)=length(ind);    
end
if LenH==0
    H(1)=length(find(X==0));
end
if maxX == HB & LenH~=0 % for the last one
    H(LenH)=H(LenH)+length(find(X==maxX));
end

if sum(H)~=length(X(:));
    disp('Warning in HistGram: length does not match');
end