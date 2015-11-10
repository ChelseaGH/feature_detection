function [ points, Ix, Iy ] = Harris( image, threshold )
%Harris Harris Algorithm for detecting image corners:
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%
% Algorithm
%   1. Compute Ix and Iy by convolving the original 
%        image with a derivative
%   2. Compute the three images corresponding to 
%       Ix^2, Iy^2, and Ix Iy
%   3. Convolve each of these images with a larger 
%       Gaussian
%   4. Compute the corner strength according to one 
%       of the corner strength functions
%   5. Find the maxima above a threshold and report 
%       as detected features
%   6. (optionally) apply non-maximum suppression to 
%       ensure feature is a local maxima

    if nargin < 2
        %If threshold is too high, sometimes breaks, keep that in mind i
        %gguess
         threshold = 500;
    end
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
    Ix = conv2( gray, kernX, 'same' );
    Iy = conv2( gray, kernY, 'same' );

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
    FIx2 = conv2( Ix2, gauss, 'same' );
    FIy2 = conv2( Iy2, gauss, 'same' );
    FIxy = conv2( Ixy, gauss, 'same' );

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

    
    %Design Filter
    %local maximum in at least a 3x3 neighborhood.
    maxval = ordfilt2(corners, 25, ones(5,5));
    
    %Find all corners
    maxlist = (corners == maxval) & (corners > threshold);
    
    %Find all points that satisfy the filter
    [r, c] = find(maxlist);
    %detH = ( Ix2.*Iy2 ) - ( Ixy.*Ixy );
      
    %Get rid of false positives generated around edge of image....
    [r2, c2] = ExtraFilter( r, c, image);
    points = [r2,c2];

end