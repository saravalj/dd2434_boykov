function [ d ] = distPix( a, b, c )

if nargin < 3
    c = 1;
end

tmp = a - b;
d = 1./(tmp .* tmp + 1);
end

