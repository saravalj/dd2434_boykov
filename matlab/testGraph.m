% Directed graph
s = [1 1 2 3 3 4 4 5 5];
t = [2 3 3 2 5 5 6 4 6];
weights = [0.77 0.44 0.67 0.69 0.73 2 0.78 1 1];
G = digraph(s,t,weights);
plot(G,'EdgeLabel',G.Edges.Weight,'Layout','layered')

[mf,~,cs,ct] = maxflow(G,1,6);

H = plot(G,'Layout','layered','Sources',cs,'Sinks',ct, ...
    'EdgeLabel',G.Edges.Weight);
highlight(H,cs,'NodeColor','red')
highlight(H,ct,'NodeColor','green')


% Undirected graph
s = [1 1 2 2 3];
t = [2 3 3 4 4];
weights = [1 40 10 50 1];
G = graph(s,t,weights);
plot(G,'EdgeLabel',G.Edges.Weight,'Layout','layered')

[mf,~,cs,ct] = maxflow(G,1,4);

H = plot(G,'Layout','layered','Sources',cs,'Sinks',ct, ...
    'EdgeLabel',G.Edges.Weight);
highlight(H,cs,'NodeColor','red')
highlight(H,ct,'NodeColor','green')