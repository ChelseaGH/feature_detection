
function [ loc ] = Offset( loc, firstImg )

    [sizeX,sizeY] = size(rgb2gray(firstImg));
    
    [locX, locY] = size(loc);
    
    loc(:,2) = loc(:,2) + sizeY;
end