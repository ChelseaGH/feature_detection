
function [ loc, offset ] = Offset( loc, firstImg )

    [sizeX,sizeY] = size(rgb2gray(firstImg));
    
    [locX, locY] = size(loc);
    
    offset = sizeY;
    loc(:,2) = loc(:,2) + offset;
end