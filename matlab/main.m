clear; clc;

lambda = 0;
sigma = 80;

% Open image & masks
img = rgb2gray(imread('img/grid.png'));
fgseeds = rgb2gray(imread('img/grid_fgmask_2.png'));
bgseeds = rgb2gray(imread('img/grid_bgmask_2.png'));
[h, w, c] = size(img);

% Compute the graph
[G,Simg,sinkId,sourceId] = buildImgGraph(img, fgseeds, bgseeds, lambda, sigma);

% Cut the graph
[mf,H,cs,ct] = maxflow(G,sourceId,sinkId);

% Show the segmented image
segmentedImg = Simg;
segmentedImg(cs(cs ~= sourceId)) = 255;
segmentedImg(ct(ct ~= sinkId)) = 0;

% Overlay the fgSeeds on final segmentation
%Sfgseeds = reshape(fgseeds, h*w, 1);
%segmentedImg(Sfgseeds == 255) = 128;

% Plot the final segmentation
imshow(reshape(segmentedImg, h, w, 1));

%figure;
%tmp = img;
%co = coord(cs(cs ~= sourceId),499);
%tmp(co(:,2), co(:,1)) = 255;
%co = coord(ct(ct ~= sinkId),499);
%tmp(co(:,2), co(:,1)) = 0;
%imshow(tmp);