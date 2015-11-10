function [ xRight, xLeft, yTop, yBottom ] = GetPoints( pt, bx, itr )

    xRight   = (pt(itr,1) + bx(itr));
    xLeft    = (pt(itr,1) - bx(itr));
    yTop     = (pt(itr,2) + bx(itr));
    yBottom  = (pt(itr,2) - bx(itr));
    
end