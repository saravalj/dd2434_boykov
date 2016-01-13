
function [ newH ] = updateImgGraph(H, img, new_bgseeds, sourceWeights, sinkWeights, K);

 % Reshape image and masks
[h, w, c] = size(img);
Simg = reshape(img, h*w, c);
Snew_bgseeds = reshape(new_bgseeds, h*w, 1);

% Compute the edges to the sink and the source
sinkId = h*w+1; % node id for the sink
sourceId = h*w+2; % node id for the source

nodeIdvec = 1:h*w;
%Removing all sink and source edges connected to the new seeds

%Initialize vector of node Ids that labelled as background by the new seeds
new_bgnodeIds = nodeIdvec(Snew_bgseeds == 255);

sinkIdvec = sinkId*ones(1,length(new_bgnodeIds));
sourceIdvec = sourceId*ones(1,length(new_bgnodeIds));

%Removing all edges between the new seeds and the sink node
tempH = rmedge(H,new_bgnodeIds,sinkIdvec);

%Removing all edges between the new seeds and the source node
tempH = rmedge(tempH,sourceIdvec,new_bgnodeIds);

%Initialize vectors for the new sink and source weights
newsourceWeights = zeros(length(new_bgnodeIds), 1);
newsinkWeights = zeros(length(new_bgnodeIds), 1);

for i=1:length(new_bgnodeIds)
    k = new_bgnodeIds(i);
    newsourceWeights(i) = sinkWeights(k) + sourceWeights(k);
    newsinkWeights(i)  = sinkWeights(k) + sourceWeights(k) + K;
end

%Adding new sink and source edges
tempH = addedge(tempH, new_bgnodeIds, sinkIdvec, newsinkWeights);
newH = addedge(tempH, sourceIdvec, new_bgnodeIds, newsourceWeights);

%sum(find(sinkWeights==0))
end

