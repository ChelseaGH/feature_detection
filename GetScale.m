
function [ S ] = GetScale(feature, Ix, Iy)
    Ix2 = Ix.*Ix;
    Iy2 = Iy.*Iy;    
    
    x = feature(:,1);
    y = feature(:,2);

    %Use square root to find the scale of
    %each of the Iy2 Ix2 derivatives
    %A is x component
    %B is y component
    A = Ix2( x,y );
    B = Iy2( x,y );
    
    %Get the Scaling value
    o = sqrt( A + B );
    
    %Normalize scales
    q = Normalize(o(:,1), 0, 1);
    r = Normalize(o(:,2), 0, 1);

    S = [ q, r];
end