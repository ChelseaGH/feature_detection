function [ xRight, xLeft, yTop, yBottom ] = GetPoints( pt, bx, itr )
%GetPoints Construct corner points for plotting a box
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%

    xRight   = (pt(itr,1) + bx(itr));
    xLeft    = (pt(itr,1) - bx(itr));
    yTop     = (pt(itr,2) + bx(itr));
    yBottom  = (pt(itr,2) - bx(itr));
    
end