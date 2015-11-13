function [ derX, derY, edge ] = Magnitude( image, kernX, kernY )
%Magnitude Calculate Magnitude of image
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%
    %Generate X Derivative Map through convolution
    derX = conv2( image, kernX, 'same' );
    %Generate Y Derivative Map through convolution
    derY = conv2( image, kernY, 'same' );
    %Generate Edge Map through gradient magnitude
    edge = sqrt(derX.^2 + derY.^2);
end