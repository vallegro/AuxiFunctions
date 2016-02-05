% Skin detection
% by S.Perugia

function skins = skinDet(rgb, m, settings)

strel_param = settings.strel_param;
hsv_inf_th = settings.hsv_inf_th;
hsv_sup_th = settings.hsv_sup_th;
erosion_ord = settings.erosion_ord;
skin_th = settings.skin_th;

hsv = rgb2hsv(rgb);
se = strel('square', strel_param);
skins = zeros(2,1);

[r c] = size(rgb(:,:,1));
skinmap = zeros(r, c);
f = 0;

%% ----- Processing for skin detection 
skinmap(find(hsv(:,:,1) >= hsv_inf_th & hsv(:,:,1) <= hsv_sup_th)) = 1; 
dilatated = imdilate(skinmap, se);
eroded = imerode(dilatated, se);
skinmap = medfilt2(eroded,[erosion_ord erosion_ord]);

numskin = sum(sum(skinmap)); % reference threshold

%% ----- Skin containing blocks - get positions
for h = 0 : (m-1)   % for each block
    for l = 0 : (m-1)
        if sum(sum(skinmap((r/m)*h+1:(r/m)*(1+h),(c/m)*l+1:(c/m)*(l+1)))) > skin_th*numskin
            f = f + 1;
            skins(1,f) = (r/m)*h+1;
            skins(2,f) = (r/m)*(1+h);
            skins(3,f) = (c/m)*l+1;
            skins(4,f) = (c/m)*(l+1);
        end
    end
end

end



