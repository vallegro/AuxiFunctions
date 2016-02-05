% DIBR view evaluation
% by S.Perugia

function score = TDSwIM(io,is, format)

%% ----- Initalize parameters
settings = initSettings;

d0 = settings.d0;
m = settings.m;
hsearch = settings.hsearch;
skinW = settings.skinW;

%% ----- Load original view and DIBR view
if nargin == 0
    [filename, pathname] = uigetfile({'*.bmp';'*.jpeg';'*.jpg';'*.tiff';'*.tif';'*.png';'*.gif'},'Select the original view');
    file = fullfile(pathname, filename);
    io = imread(file);
    currentFolder = cd(pathname);
    [filename, pathname] = uigetfile({'*.bmp';'*.jpeg';'*.jpg';'*.tiff';'*.tif';'*.png';'*.gif'},'Select the DIBR view');
    file = fullfile(pathname, filename);
    is = imread(file);
    cd(currentFolder);
    
elseif nargin == 2
  %  io = imread(io);
  %  is = imread(is);
  %  io = rgb2ycbcr(io);
   % is = rgb2ycbcr(is);
   % io = io(:,:,1);
   % is = is(:,:,1);
    
elseif nargin == 3
    switch format
        case 'YUV'
            io = io(:,:,1);
            is = is(:,:,1);
        case 'RGB'
            io = rgb2ycbcr(io);
            is = rgb2ycbcr(is);
            io = io(:,:,1);
            is = is(:,:,1);
    end
    
end

%currentFolder = cd('./libraries');

[r, c] = size(io);

dtotal = 0;

%% ----- For each block
for h = 0 : (m-1)
    for l = 0 : (m-1)
        
        bor = io((r/m)*h+1:(r/m)*(1+h),(c/m)*l+1:(c/m)*(l+1));
        bis = is((r/m)*h+1:(r/m)*(1+h),(c/m)*l+1:(c/m)*(l+1));
        
        %% ----- Registration
        if settings.registration_ON == 1
            cost_min = sum(sum(abs(bis-bor)));
            
            for k = -hsearch : hsearch
                if(c/m)*l+1+k > 0 && (c/m)*(l+1)+k <= c
                    borp = io((r/m)*h+1:(r/m)*(1+h),(c/m)*l+1+k:(c/m)*(l+1)+k);
                    cost = sum(sum(abs(bis-borp)));
                    if (cost <= cost_min)
                        cost_min = cost;
                        bor=borp;
                        a = k;
                    end
                end
            end
        end
        
        %% ----- Wavelet Transforms
        [woll,woh,wov,wod] = dwt2(bor,'haar');
        [wsll,wsh,wsv,wsd] = dwt2(bis,'haar');
        
        %% ----- Histograms
        p = imhist(woh);
        q = imhist(wsh);
        
        %% ----- Skin detection
        skin = 0;
        if settings.skin_detection_ON == 1
            skins = skinDet(is, m, settings);
            [a b] = size(skins);
            for g = 1 : b
                if skins(1,b) == (r/m)*h+1 && skins(2,b) == (r/m)*(1+h) && skins(3,b) == (c/m)*l+1+a && skins(4,b) == (c/m)*(l+1) + a
                    skin = 1;
                end
            end
        end
        
        %% ----- Kolmogorov-Smirnov distance
        if skin == 1
            d = ks(p,q)*skinW;
        else d = ks(p,q);
        end
        
        dtotal = dtotal+d;
    end
end

%cd(currentFolder);

%% ----- Score computation
dtotal = dtotal/d0;  % final distortion
score = 1/(1+dtotal);  % final score