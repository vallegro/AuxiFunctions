% Metric settings
% by S.Perugia

function settings = initSettings

%% ----- Main settings
%%% original
settings.d0 = 10^3;  %  normalize the total distortion
settings.m = 32;      %  the image is divided in m*m blocks
settings.hsearch = 10; % horizontal resgistration

%%%% ours
% settings.d0 = 10;  %  normalize the total distortion. 2015-04-03
% settings.m = 9;      %  the image is divided in m*m blocks. 2015-04-03
% settings.hsearch = 3; % horizontal resgistration. 2015-04-03

%% ----- Skin detection settings
settings.skin_detection_ON = 0;
settings.skinW = 15; % skin-blocks weight
settings.strel_param = 1; % morphological structuring element - width 
settings.hsv_inf_th = 0.064; % inf hsv value for skin 
settings.hsv_sup_th = 0.085; % sup hsv value for skin 
settings.erosion_ord = 7; % erosion order
settings.skin_th = 0.03; % inf threshold for skin detection


settings.registration_ON = 1;

end