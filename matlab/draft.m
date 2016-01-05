clear; clc;

lambda = 60;

% Open image & masks + reshape
img = rgb2gray(imread('img/grid.png'));
fgseeds = rgb2gray(imread('img/grid_fgmask.png'));
bgseeds = rgb2gray(imread('img/grid_bgmask.png'));

[h, w, c] = size(img);
Sgrid = reshape(img, h*w, c);
Sfgseeds = reshape(fgseeds, h*w, 1);
Sbgseeds = reshape(bgseeds, h*w, 1);

% Apply masks
%Sgrid(Sfgseeds == 0,:) = 0;
%Sgrid(Sbgseeds == 0,:) = 0;
%Sgrid(~((Sfgseeds == 0) .* (Sbgseeds == 0) == 0),:) = 0;
%imshow(reshape(Sgrid, h,w,c));


% Compute histograms on seeded pixels
[fgHist, binLocations] = imhist(Sgrid(Sfgseeds == 255,:));
[bgHist, ~] = imhist(Sgrid(Sbgseeds == 255,:));

% Compute the distribution probability
fgHist = fgHist ./ sum(fgHist);
bgHist = bgHist ./ sum(bgHist);

% Example 
% Rp_fg for the pixel in (1,1)
Rp_fg = fgHist(binLocations == img(1,1,:));