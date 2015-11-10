function [ O ] = GetOrientation( feature, Ix, Iy )
    x = feature(:,1);
    y = feature(:,2);

    [ sz, ~ ] = size(x);
    O = zeros( size(x) );
    Ix2 = Ix.*Ix;
    Iy2 = Iy.*Iy;
    %Use arctangent to find the direction of
    %each of the Iy Ix derivatives
    %Numerator   is y component
    %Denominator is x component

    
    %Get the orientation angle, so we need arctangent
    %O = atand( Ix./Iy );
    %size(O);
    
    for i=1:sz
        numerator   = Ix( x(i) );
        denominator = Iy( y(i) );
       O(i) =  atand( numerator/denominator );
        
    end
    O
end