function [ d ] = adhoc( a, b, sigma, w, pIndex, qIndex )

p = coord(pIndex, w);
q = coord(qIndex, w);
tmp = p - q;

r = rbf(a, b, sigma);

d = zeros(size(r));
for i=1:size(tmp,1)
    d(i) = r(i) ./ sqrt(tmp(i,:) * tmp(i,:)');
end

end

