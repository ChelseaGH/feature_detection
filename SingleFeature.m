function SingleFeature( image, location )
    delta = 5;

    image =  PrepImage( image );
    [length, ~] = size(location);
    for i = 1: length


        x = location(i,2);
        y =  location(i,1);
        
        point = [x,y];

        
        x = point(1);
        y = point(2);
        
        
        x1 = x - delta;
        y1 = y - delta;
        
        mat = zeros( 5,5 );
        mat = image( y,x );
        ShowImage( mat, 'blahh' );

    end
    
end