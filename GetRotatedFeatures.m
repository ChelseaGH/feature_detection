function [ features ] = GetRotatedFeatures( image, location, orientation )
%GetRotatedFeatures Variation of GetFeatures encorporating orientation
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%

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
       deg =  angle(i);
          
       feature = img_g( (yPt-12):(yPt+12),(xPt-12):(xPt+12) );
       
       %Rotate feature based on orientation info
       featRot = imrotate(feature, -deg);
       
       %Slice out 5x5 Descriptor from larger rotated feature.
       newFeat = featRot( 11:15, 11:15 );
       features{i} = [];
       for j=1: 5
           for k=1:5
               %convert to vector
               features{i} = [features{i} newFeat(j,k)];
           end
       end
    end
end