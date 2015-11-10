function [ features ] = GetSIFTy( image, location, orientation )

    x = location(:,2);
    y =  location(:,1);
    pt = [ x, y ];
    [ img_g ] = PrepImage( image );

    angle = zeros (size(orientation));

        
    [ imgX, imgY ] = size(img_g);
    %Determine loop size based on the number of locations in list
    [locX, ~] = size(pt);
    
    features = cell(locX);

    for i = 1: locX
       xPt = pt(i,1);
       yPt = pt(i,2);

       angle = orientation;
       deg =  angle(i);%radtodeg(angle(i));
          
       feature = img_g( (yPt-8):(yPt+7),(xPt-8):(xPt+7) );
       featRot = imrotate(feature, -deg);
       newFeat = featRot( 11:15, 11:15 );
       features{i} = [];
       for j=1: 5
           for k=1:5
               features{i} = [features{i} newFeat(j,k)];
           end
       end
    end
end