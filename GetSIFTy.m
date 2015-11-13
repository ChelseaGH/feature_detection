function [ features ] = GetSIFTy( image, location )
%GetSIFTy SIFT implementation of GetFeatures
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%

    x = location(:,2);
    y =  location(:,1);
    pt = [ x, y ];
    
    %Grayscale
    [ img_g ] = PrepImage( image );
        
    %Determine loop size based on the number of locations in list
    [locX, ~] = size(pt);
    
    features = cell(locX);

    for i = 1: locX
       xPt = pt(i,1);
       yPt = pt(i,2);
          
       gauss = fspecial('gaussian', 5, 5);

       features{i} = [];

       %construct 16x16 matrix
       feature = img_g( (yPt-8):(yPt+7),(xPt-8):(xPt+7) );
       
       %iterate through 16x16 matrix in 4x4 chunks
       for j=1:4:16
          for k=1:4:16
            %get a 4x4 slice of 16x16 matrix
            o =  feature(j:j+3,k:k+3 );

            %Apply Gaussian
            oconv = conv2( o, gauss, 'same' );
            for l=1:4
                for m=1:4
                    %Combine all slices into one big vector
                    features{i} = [features{i} oconv(l,m)];
                end
            end
          end
       end
    end
    
    %Normalize vectors to handle illumination invariance
   for i = 1: locX
        features{i} = Normalize(features{i},0,1);
   end
end