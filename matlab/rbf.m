function [ d ] = rbf( a, b, sigma )
% Perform the element-wise RBF kernel function between a and b vectors

if nargin < 3
    sigma = 80;
end

tmp = a - b;
d = exp(-tmp .* tmp/(2*sigma^2));
end

