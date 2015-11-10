function [ r2, c2 ] = ExtraFilter( r,c, image )
    [lengthR, none] = size(r);
    [lengthC, none] = size(c);
    
    image = rgb2gray( image );
    image = double( image );
    [ maxX, maxY ] = size(image);
    
    delta = 10;
    
    %Mark all "bad points" as -1
    for i = 1: lengthR
        if r(i) < delta || r(i) > maxX - delta || ...
           c(i) < delta || c(i) > maxY - delta
            r(i) = -1;
            c(i) = -1;
        end
        
    end

    
    %Strip out all values with -1
    r2 = r(r~=-1);
    c2 = c(c~=-1);

end