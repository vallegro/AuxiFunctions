function[im]= pfm_read(s)

fp = fopen(s);
fgets(fp)
fgets(fp)
fgets(fp)
im = fread(fp,'float32');
im(im==Inf) = 0;
im = im/max(im(:))*255;
im = uint8(reshape(im,[2880,1944]))';