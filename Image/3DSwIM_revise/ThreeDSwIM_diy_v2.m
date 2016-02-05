function [score,dtotal]=ThreeDSwIM_diy_v2(imSyn1,imSyn2)
%% This is used to test our propsoed distortion model for synthesized view from 3DSwIM point.
% virtual view is synthesized with only one depth map
% synthesized virtual view imSyn2 compare with virtual view imSyn1 synthesized by
% original depth map. There is no more imtarget here

%%%%%%%%%%% 3DSwIM %%%%%%%%%%

%% ----- Initalize parameters
settings = initSettings;

d0 = settings.d0;
m = settings.m; %?define m*m block, by yuan
hsearch = settings.hsearch;
skinW = settings.skinW;

x=0.5;

[rows,cols,nz]=size(imSyn1);

Bn=cols/m; % cols
Bm=rows/m; % rows

Dbd=ones(Bm,Bn)*-inf;
Dflag=zeros(Bm,Bn);

dtotal=0;

%% ----- For each block
if nz==3  % rgb image
    io = rgb2ycbcr(imSyn1);  io = io(:,:,1); % figure;imshow(io/255); title('imSyn1');  % as synthesized view with original depth
    is = rgb2ycbcr(imSyn2);    is = is(:,:,1); % figure;imshow(is/255); title('imSyn2'); % sythesized with approximated depth, for evaluation
elseif nz==1  % already transfered to yuv domain.
    io=imSyn1;
    is=imSyn2;
end

% sum(sum(abs(io-is)))
[idxr,idxc]=find(io~=is);
idx=find(io~=is);

for h = 0 : Bm-1
    for l = 0 : Bn-1
        
        indx=h*m+1:(h+1)*m; indy=l*m+1:(l+1)*m;  % define this as the index for synthesized view, need to figure out the corresponding block in left and right depth map.   
        bor=io(indx,indy); % imSyn1
        bis = is(indx,indy); % imSyn2
        
        check=0;
        if sum(sum(abs(bis-bor)))~=0
            check=1;
            figure(3);imshow(bor/255);
            figure(4);imshow(bis/255);
        end
        
        %% ----- Registration
        costSet=ones(1,2*hsearch+1)*inf;
        if settings.registration_ON == 1
            cost_min = sum(sum(abs(bis-bor)));
            cost_before=cost_min;
            
            for k = -hsearch : hsearch
                if m*l+1+k > 0 && m*(l+1)+k <= cols
                    borp = io(m*h+1:m*(1+h),m*l+1+k:m*(l+1)+k);
                    cost = sum(sum(abs(bis-borp)));
                    costSet(k+hsearch+1)=cost;
                    if (cost <= cost_min)
                        cost_min = cost;
                        bor=borp;
                        a = k;
                    end
                end
            end
            cost_after=cost_min;
        end
        
%         costSet
        
        if a~=0
            Dflag(h+1,l+1)=1;
%             a
            cost_before;
            cost_after;
            check2=1;
        end
        
        
        %% ----- Wavelet Transforms
%         [woll,woh,wov,wod] = dwt2(bor,'haar');
%         [wsll,wsh,wsv,wsd] = dwt2(bis,'haar');
        
        %% ------ Change the value of bor and bis to see the difference
%         if check==1
%             uno=unique(bor);
%             ind=find(bor==uno(1)); bor(ind)=20;
%             ind=find(bor==uno(2)); bor(ind)=200;
%             ind=find(bis==uno(1)); bis(ind)=20;
%             ind=find(bis==uno(2)); bis(ind)=200;
%         end
        
        %% ------ DCT Transforms
        bor=bor-128;
        bis=bis-128;
        
        woh=zeros(m,m); % horizontal coeffecients for original block
        wsh=zeros(m,m); % horizontal coeffecients for synthesized block
        for iii=1:m
            woh(iii,:)=dct(bor(iii,:));
            wsh(iii,:)=dct(bis(iii,:));
        end
        
        %% ----- Histograms
%         woh=int8(woh);
%         wsh=int8(wsh);
%         
%         p = imhist(woh);
%         q = imhist(wsh);
%         
        %% ----- Histogram for DCT
        woh_cc=woh(:,2:end);
        wsh_cc=wsh(:,2:end);
        minW=min(min(woh_cc(:)),min(wsh_cc(:)));
        maxW=max(max(woh_cc(:),max(wsh_cc(:))));
        p=HistGram(woh_cc,minW,maxW);
        q=HistGram(wsh_cc,minW,maxW);
        
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
        else [d,idx] = ks(p,q);
        end
%         if check==1
%             floor(minW/10)*10+idx*10-10
%         end
        
        Dbd(h+1,l+1)=d;
        dtotal = dtotal+d;
    end
end

%% ----- Score computation
dtotal = dtotal/d0;  % final distortion
score = 1/(1+dtotal);  % final score