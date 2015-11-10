function [ features ] = GetBadFeatures( image, location )

    x = location(:,2);
    y =  location(:,1);
    pt = [ x, y ];
    [ img_g ] = PrepImage( image );

    [ imgX, imgY ] = size(img_g);
    %Determine loop size based on the number of locations in list
    [locX, ~] = size(pt);
    
    features = cell(locX);

    for i = 1: locX
       xPt = pt(i,1);
       yPt = pt(i,2);
       %img_g( (yPt-2):(yPt+2),(xPt-2):(xPt+2) )
       features{i} = img_g( (yPt-2):(yPt+2),(xPt-2):(xPt+2) );
       
    end
end