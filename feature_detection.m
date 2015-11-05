%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                %%%

function feature_detection()

    f1 = 'img\Yosemite\Yosemite1.jpg'
    f2 = 'img\Yosemite\Yosemite1.jpg'
    
    [ i1, i1g ] = ReadImage( f1 );
    
    ShowImage( i1, 'MHMMGOODSHIT' );

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

function ShowFeatures( location, scale, orientation )



end
