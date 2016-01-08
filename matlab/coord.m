function [ c ] = coord( pIndex, w )

xp = mod(pIndex-1, w) + 1;
yp = ((pIndex - xp)./w) + 1;
c = [xp(:) yp(:)];
end

