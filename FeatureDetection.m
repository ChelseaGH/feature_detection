%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                %%%

function FeatureDetection()
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
%     f1 = 'img\bikes\img1.ppm';
%     f2 = 'img\bikes\img2.ppm';
%     

    f1 = 'img\Yosemite\Yosemite1.jpg';
    f2 = 'img\Yosemite\Yosemite2.jpg';
    
    %Open Image 1
    img1 = imread( f1 );
    [loc1, Ix1, Iy1 ] = Harris( img1 );
    ori1 = GetOrientation( loc1, Ix1, Iy1 );
    scal1 = GetScale( loc1, Ix1, Iy1);
    %scal1 = ones(2000); % GetScale( loc1, Ix1, Iy1);
    
    ShowImage( img1, 'wohooopie' );
    ShowFeatures(  loc1, scal1, ori1 );
    %SingleFeature(  img1, loc1 );
    

     %Open Image 2
     img2 = imread( f2 );
     [loc2, Ix2, Iy2 ] = Harris( img2 );
     ori2 = GetOrientation( loc2, Ix2, Iy2 );
     scal2 = GetScale(loc2, Ix2, Iy2); 
     %scal2 = ones(2000); % GetScale( loc1, Ix1, Iy1);
     
     ShowImage( img2, 'wohooopie' );
     ShowFeatures(  loc2, scal2, ori2 );
     
     newLoc2 = Offset(loc2, img1);
     GetMatches( img1, loc1, scal1, ori1, img2, newLoc2, scal2, ori2 );
     SSD( loc1, loc2);
end


























