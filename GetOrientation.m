function [ O ] = GetOrientation( feature, Ix, Iy )
    x = feature(:,1);
    y = feature(:,2);

    %Use arctangent to find the direction of
    %each of the Iy Ix derivatives
    %Numerator   is y component
    %Denominator is x component
    numerator   = Iy( x,y );
    denominator = Ix( x,y );
    
    %Get the orientation angle, so we need arctangent
    O = atan( numerator./denominator );
end