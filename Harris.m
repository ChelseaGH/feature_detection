
function [ points, Ix, Iy ] = Harris( image )

    %Kernel Type
    kType = 'SOBEL';
    
    %Gaussian Variables
    hsize = 5;
    sigma = 5;
    
    gray = PrepImage( image );
    %Verify Step 1
    %ShowImage( image, 'Original Image' );

    %Build Gaussian
    gauss = fspecial('gaussian', hsize, sigma);
 
    %Get Kernels
    [ kernX, kernY ] = GetKernel( kType );
   
    %Compute Image derivatives Ix and Iy by convolving original image
    Ix = conv2( gray, kernX );
    Iy = conv2( gray, kernY );

    %Verify Step 2
    %ShowImage( Ix, 'Ix' );
    %ShowImage( Iy, 'Iy' );
    
    %Compute the three images corresponding to Ix^2, Iy^2, and Ix Iy    
    Ix2 = Ix.*Ix;
    Iy2 = Iy.*Iy;
    Ixy = Ix.*Iy;
    
    %Verify Step 3
    %ShowImage( Ix2, 'Ix squared' );
    %ShowImage( Iy2, 'Iy squared' );
    %ShowImage( Ixy, 'Ix * Iy' );

    %Gauss Filter Ix2, Iy2, Ixy
    FIx2 = conv2( Ix2, gauss);
    FIy2 = conv2( Iy2, gauss );
    FIxy = conv2( Ixy, gauss );

    %Verify Step 4
    %ShowImage( FIx2, 'Filtered Ix squared' );
    %ShowImage( FIy2, 'Filtered Iy squared' );
    %ShowImage( FIxy, 'Filtered Ix * Iy' );    
    

    %Compute a corner strength function    
    %c(H) = det(H) / trace(H)
    detH = FIx2.*FIy2 - FIxy.*FIxy;
    traceH = FIx2+FIy2;
    corners = detH ./ traceH;
    
    %Verify Step 5
    %ShowImage( corners, 'Corner Strength' );

    threshold = 10;
    
    %Design Filter
    %local maximum in at least a 3x3 neighborhood.
    maxval = ordfilt2(corners, 9, ones(15,15));
    
    %Find all corners
    maxlist = (corners == maxval) & (corners > threshold);
    
    %Find all points that satisfy the filter
    [r, c] = find(maxlist);
    %detH = ( Ix2.*Iy2 ) - ( Ixy.*Ixy );
      
    %Get rid of false positives generated around edge of image....
    [r2, c2] = ExtraFilter( r, c, image);
    points = [r2,c2];
    %orientation = GetOrientation( location, Ix, Iy )

end