function [ O ] = GetOrientation( feature, Ix, Iy )
%GetOrientation Determine the Orientations of all feature descriptors.
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%

    x = feature(:,1);
    y = feature(:,2);

    [ sz, ~ ] = size(x);
    O = zeros( size(x) );

    %Use arctangent to find the direction of
    %each of the Iy Ix derivatives
    %Numerator   is y component
    %Denominator is x component

    
    for i=1:sz
        numerator   = Iy( x(i) );
        denominator = Ix( y(i) );
       O(i) =  atand( numerator/denominator );
        
    end

end