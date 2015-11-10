function [ img_g ] = PrepImage( img )

    %img = imresize( img, 0.8 );
    img_g = rgb2gray( img );
    img_g = double( img_g );
    
end