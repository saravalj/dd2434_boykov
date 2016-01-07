clear; clc;

lambda = 60;

% Open image & masks
img = rgb2gray(imread('img/grid.png'));
fgseeds = rgb2gray(imread('img/grid_fgmask.png'));
bgseeds = rgb2gray(imread('img/grid_bgmask.png'));
[h, w, c] = size(img);

% Compute the graph
[G,Simg,sinkId,sourceId] = buildImgGraph(img, fgseeds, bgseeds, lambda);

% Cut the graph
[mf,H,cs,ct] = maxflow(G,sourceId,sinkId);

% Show the segmented image
segmentedImg = Simg;
segmentedImg(cs(cs ~= sourceId)) = 255;
segmentedImg(ct(ct ~= sinkId)) = 0;
imshow(reshape(segmentedImg, h, w, 1));