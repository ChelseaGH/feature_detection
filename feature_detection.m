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

    %Image Files
    f1 = 'img\Yosemite\Yosemite1.jpg';
    f2 = 'img\Yosemite\Yosemite1.jpg';
    
    %Kernel Type
    kType = 'SOBEL';
    
    %Gaussian Variables
    hsize = 5;
    sigma = 0.5;
    
    [ i1, i1g ] = ReadImage( f1 );
    
    %Build Gaussian
    gauss = fspecial('gaussian', hsize, sigma);
    
    %Get Kernels
    [ kernX, kernY ] = GetKernel( kType );
    %Compute Ix and Iy by convolving original image with derivative
    Ix = conv2( i1g, kernX );
    Iy = conv2( i1g, kernY );

    %Compute the three images corresponding to Ix^2, Iy^2, and Ix Iy    
    Ix2 = Ix.*Ix;
    Iy2 = Iy.*Iy;
    Ixy = Ix.*Iy;
    
    %Compute 
    ShowFeatures( i1, 0, 0, 0 );
end


function [ img, img_g ] = ReadImage( file )

    %Read in image, scale it down a bit, return colored img and grayscale
    img = imread( file );
    img = imresize( img, 0.8 );
    img_g = rgb2gray( img );
    img_g = double( img_g );
    
end

function ShowImage( img, description )

    %Show images with appropriate descriptions
    figure, imshow( img,[] );    
    title( description );
    
end

function ShowFeatures( image, location, scale, orientation )





    ShowImage( image, 'Here it is' );

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