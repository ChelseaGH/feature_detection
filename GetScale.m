function [ S ] = GetScale(feature, Ix, Iy)
%GetScale Determine the Scales of all feature descriptors.
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%

    Ix2 = Ix.*Ix;
    Iy2 = Iy.*Iy;    
    
    x = feature(:,1);
    y = feature(:,2);

    [ sz, ~ ] = size(x);
    S = zeros( size(x) );
    
    %Use square root to find the scale of
    %each of the Iy2 Ix2 derivatives
    %A is x component
    %B is y component

    for i=1:sz
        A   = Ix2( x(i) );
        B   = Iy2( y(i) );
        S(i) =  sqrt(A+B);
        
    end
    %Normalize scales so they aren't obnoxious
    S = Normalize(S, 0, 1);
end