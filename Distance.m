

function [ d ] = Distance( x1, y1, x2, y2 )

    A = (x2 - x1).^2;
    B = (y2 - y1).^2;
    d = sqrt( A + B );
    
end