function [ G, Simg, sinkId, sourceId ] = buildImgGraph( img, fgseeds, bgseeds, lambda, sigma )

 % Reshape image and masks
[h, w, c] = size(img);
Simg = reshape(img, h*w, c);
Sfgseeds = reshape(fgseeds, h*w, 1);
Sbgseeds = reshape(bgseeds, h*w, 1);

% Compute histograms on seeded pixels
[fgHist, binLocations] = imhist(Simg(Sfgseeds == 255,:));
[bgHist, ~] = imhist(Simg(Sbgseeds == 255,:));

% Compute the distribution probability Pr(Ip|O) and Pr(Ip|B)
fgHist = fgHist ./ sum(fgHist);
bgHist = bgHist ./ sum(bgHist);

% Example 
% Rp_fg for the pixel in (1,1)
%Rp_fg = -log(fgHist(binLocations == img(1,1,:)));

% Compute the graph edges from the image size
edges = edgeList( h, w );

% Compute the edges to the sink and the source
sinkId = h*w+1; % node id for the sink
sourceId = h*w+2; % node id for the source
sinkEdges = [sinkId*ones(1,h*w); 1:h*w];
sourceEdges = [sourceId*ones(1,h*w); 1:h*w];

% Compute Bpq weights
weights = adhoc(single(Simg(edges(1,:))), single(Simg(edges(2,:))), sigma, w, edges(1,:), edges(2,:));

% Compute K, too long
%maxBpq = 0;
%for p = 1:h*w
%    sumBpq = sum([weights(edges(1,:) == p); weights(edges(2,:) == p)]);
%    if sumBpq > maxBpq
%        maxBpq = sumBpq;
%    end
%end
%K = 1 + maxBpq;

% Compute K
K = sum(weights);

% Compute sink weights
%sinkWeights = zeros(h*w, 1);
tmp = -log(fgHist(1+Simg));
tmp(tmp == Inf) = 200000*K;
sinkWeights = lambda * tmp;
sinkWeights(Sfgseeds == 255) = 0;
sinkWeights(Sbgseeds == 255) = K;

% Clever way to assign weights, but gain in speed is negligeable
%tmp = -log(fgHist(1+Simg((Sfgseeds == 0) .* (Sbgseeds == 0) == 1)));
%tmp(tmp == Inf) = 200000*K;
%sinkWeights((Sfgseeds == 0) .* (Sbgseeds == 0) == 1) = lambda * tmp;

% Compute source weights
%sourceWeights = zeros(h*w, 1);
tmp = -log(bgHist(1+Simg));
tmp(tmp == Inf) = 200000*K;
sourceWeights = lambda * tmp;
sourceWeights(Sfgseeds == 255) = K;
sourceWeights(Sbgseeds == 255) = 0;

% Clever way to assign weights, but gain in speed is negligeable
%tmp = -log(bgHist(1+Simg((Sfgseeds == 0) .* (Sbgseeds == 0) == 1)));
%tmp(tmp == Inf) = 200000*K;
%sourceWeights((Sfgseeds == 0) .* (Sbgseeds == 0) == 1) = lambda * tmp;

% Create the weighted undirected graph
G = graph(  [edges(1,:) sinkEdges(1,:) sourceEdges(1,:)], ...
            [edges(2,:) sinkEdges(2,:) sourceEdges(2,:)], ...
            [weights; sinkWeights; sourceWeights]);

%plot(G,'Layout','layered')
end

