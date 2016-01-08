function [ edges ] = edgeList( h, w )
% Return edges corresponding to a full meshed HxW image

vertEdges = [1:(h-1)*w; (1:(h-1)*w) + w];

horEdges = [1:w:h*w; (1:w:h*w) + 1];
for i=1:w-2
    horEdges = [horEdges [(1:w:h*w) + i; (1:w:h*w) + i+1]];
end

rdiagEdges = [];
for i=1:h-1
    rdiagEdges = [rdiagEdges [(1:w-1)+w*(i-1); (1:w-1)+w*i+1]];
end

ldiagEdges = [];
for i=1:h-1
    ldiagEdges = [ldiagEdges [(2:w)+w*(i-1); (1:w-1)+w*i]];
end

edges = [[vertEdges(1,:) horEdges(1,:) rdiagEdges(1,:) ldiagEdges(1,:)];
         [vertEdges(2,:) horEdges(2,:) rdiagEdges(2,:) ldiagEdges(2,:)]];
     
%G = graph(edges(1,:), edges(2,:));
%plot(G,'Layout','layered')
end
