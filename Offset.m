function [ loc, offset ] = Offset( loc, firstImg )
%Offset Determine Plot offset of second image when both are on same plane
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%

    %Get Dimensions of other image
    [sizeX,sizeY] = size(rgb2gray(firstImg));
    
    
    [locX, locY] = size(loc);
    
    %Determine offset
    offset = sizeY;
    loc(:,2) = loc(:,2) + offset;
end