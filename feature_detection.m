%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                %%%

function feature_detection()
%Feature Detection system using Harris Corners.
%Harris Algorithm:
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
    
    clc
    close all
    
    %Image Files
    %f1 = 'img\other\whatdeheek.PNG';
    f1 = 'img\bikes\img1.ppm';
    
    %Kernel Type
    kType = 'ISOTROPIC';
    
    %Gaussian Variables
    hsize = 5;
    sigma = 5;
    
    %Open Image
    [ i1, i1g ] = ReadImage( f1 );
    
    %Verify Step 1
    ShowImage( i1, 'Original Image' );

    %Build Gaussian
    gauss = fspecial('gaussian', hsize, sigma);
 
    %Get Kernels
    [ kernX, kernY ] = GetKernel( kType );
   
    %Compute Image derivatives Ix and Iy by convolving original image
    Ix = conv2( i1g, kernX );
    Iy = conv2( i1g, kernY );

    %Verify Step 2
    ShowImage( Ix, 'Ix' );
    ShowImage( Iy, 'Iy' );
    
    %Compute the three images corresponding to Ix^2, Iy^2, and Ix Iy    
    Ix2 = Ix.*Ix;
    Iy2 = Iy.*Iy;
    Ixy = Ix.*Iy;
    
    %Verify Step 3
    ShowImage( Ix2, 'Ix squared' );
    ShowImage( Iy2, 'Iy squared' );
    ShowImage( Ixy, 'Ix * Iy' );

    %Gauss Filter Ix2, Iy2, Ixy
    FIx2 = conv2( Ix2, gauss);
    FIy2 = conv2( Iy2, gauss );
    FIxy = conv2( Ixy, gauss );

    %Verify Step 4
    ShowImage( FIx2, 'Filtered Ix squared' );
    ShowImage( FIy2, 'Filtered Iy squared' );
    ShowImage( FIxy, 'Filtered Ix * Iy' );    
    

    %Compute a corner strength function    
    %c(H) = det(H) / trace(H)
    detH = FIx2.*FIy2 - FIxy.*FIxy;
    traceH = FIx2+FIy2;
    corners = detH ./ traceH;
    %Verify Step 5
    ShowImage( corners, 'Corner Strength' );

    threshold = 900;
    
    %Design Filter
    maxval = ordfilt2(corners, 9, ones(3,3));
    
    %Find all corners
    maxlist = (corners == maxval) & (corners > threshold);
    
    %Find all points that satisfy the filter
    [r, c] = find(maxlist);
    %detH = ( Ix2.*Iy2 ) - ( Ixy.*Ixy );
      
    location = [r,c];
    ShowFeatures( i1, location, 0, 0 );
end


function [ img, img_g ] = ReadImage( file )

    %Read in image, scale it down a bit, return colored img and grayscale
    img = imread( file );
    img = imresize( img, 0.8 );
    img_g = rgb2gray( img );
    img_g = double( img_g );
    
end

function ShowImage( img, caption )

    %Show images with appropriate descriptions
    figure, imshow( img,[] );    
    title( caption );
    
end

function ShowFeatures( image, location, scale, orientation, caption )

    delta = 5;
    if nargin < 5
       caption = 'Here it is';
    end
        ShowImage( image, caption );

    [length, blah] = size(location);
    for i = 1: length

        x = location(i,2);
        y =  location(i,1);
        
        point = [x,y];

        x1 = x - delta;
        y1 = y - delta;

        x2 = x + delta;
        y2 = y + delta;

        pos = [x1, y1, 5, 5];
        hold on;
        rectangle('position', pos ,'EdgeColor','r');

    end


end

function [ Gx, Gy ] = GetKernel( kType )
    %Ensure first arg is always caps
    kType = upper(kType);
    
    if strcmp( kType, 'ROBERTS')
        %ROBERTS:
        Gx = [  0  1  ;
               -1  0 ];
        Gy = [  1  0  ;
                0 -1 ];
        
    else
        %HANDLE THE OTHERS
        if strcmp( kType, 'PREWITT')
            %PREWITT:
            p = 3;
        
        elseif strcmp( kType, 'SOBEL')
            %SOBEL:
            p = 4;
        
        elseif strcmp( kType, 'ISOTROPIC')
            %ISOTROPIC:
            p = 2 + sqrt(2);
        end
        %Gradient Kernel Family used for Prewitt, Sobel, Iso:
        GradKernX = [   -1    0    1   ;
                        2-p   0   p-2  ;
                        -1    0    1  ];

        GradKernY = [   -1   2-p  -1   ;
                         0    0    0   ;
                         1   p-2   1  ];            
        

        %Apply finite difference kernels
        Gx = (1/p) * GradKernX;
        Gy = (1/p) * GradKernY;
        
    end
end

function [ derX, derY, edge ] = FindEdges( image, kernX, kernY )
    %Generate X Derivative Map through convolution
    derX = convolution( image, kernX );
    %Generate Y Derivative Map through convolution
    derY = convolution( image, kernY );
    %Generate Edge Map through gradient magnitude
    edge = sqrt(derX.^2 + derY.^2);
end