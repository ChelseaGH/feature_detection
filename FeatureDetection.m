function FeatureDetection()
%FeatureDetection Feature Detection Program
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%


    
    clc
    close all
    

    %Image Files
    
    
    f1 = 'img\bikes\img1.ppm';
    f2 = 'img\bikes\img3.ppm';
    
%     f1 = 'img\wall\img1.ppm';
%     f2 = 'img\wall\img6.ppm';
%     

%     f1 = 'img\Yosemite\Yosemite1.jpg';
%     f2 = 'img\Yosemite\Yosemite2.jpg';
%     
% 
%     f1 = 'img\graf\img1.ppm';
%     f2 = 'img\graf\img2.ppm';
%     
% 
%     f1 = 'img\leuven\img1.ppm';
%     f2 = 'img\leuven\img5.ppm';

    %Open Image 1
    img1 = imread( f1 );
    [loc1, Ix1, Iy1 ] = Harris( img1, 100 );
    ori1 = GetOrientation( loc1, Ix1, Iy1 );
    scal1 = GetScale( loc1, Ix1, Iy1);
    %scal1 = ones(2000); % GetScale( loc1, Ix1, Iy1);
    
    ShowImage( img1, 'wohooopie' );
    ShowFeatures(  loc1, scal1, ori1 );
    %SingleFeature(  img1, loc1 );
    

     %Open Image 2
     img2 = imread( f2 );
     %img2 = imrotate( img2, 180 );
     [loc2, Ix2, Iy2 ] = Harris( img2, 50 );
     ori2 = GetOrientation( loc2, Ix2, Iy2 );
     scal2 = GetScale(loc2, Ix2, Iy2); 
     %scal2 = ones(2000); % GetScale( loc1, Ix1, Iy1);
     
     ShowImage( img2, 'wohooopie' );
     ShowFeatures(  loc2, scal2, ori2 );
     
     GetMatches( img1, loc1, scal1, ori1, img2, loc2, scal2, ori2 );
end


























