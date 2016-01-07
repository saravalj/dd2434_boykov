clear; clc;

% Open image & masks + reshape
img = rgb2gray(imread('img/grid.png'));
fgseeds = rgb2gray(imread('img/grid_fgmask.png'));
bgseeds = rgb2gray(imread('img/grid_bgmask.png'));

[h, w, c] = size(img);
Simg = reshape(img, h*w, c);
Sfgseeds = reshape(fgseeds, h*w, 1);
Sbgseeds = reshape(bgseeds, h*w, 1);

% Apply masks
%Simg(Sfgseeds == 255,:) = 100;
%Simg(Sbgseeds == 255,:) = 200;
%Simg(((Sfgseeds == 0) .* (Sbgseeds == 0) == 1),:) = 255;
%imshow(reshape(Simg, h,w,c));


% Compute histograms on seeded pixels
[fgHist, binLocations] = imhist(Simg(Sfgseeds == 255,:));
[bgHist, ~] = imhist(Simg(Sbgseeds == 255,:));

% Compute the distribution probability
fgHist = fgHist ./ sum(fgHist);
bgHist = bgHist ./ sum(bgHist);

% Example 
% Rp_fg for the pixel in (1,1)
Rp_fg = -log(fgHist(binLocations == img(1,1,:)));