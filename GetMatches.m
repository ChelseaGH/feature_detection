function GetMatches( img1, loc1, scal1, ori1, img2, loc2, scal2, ori2 )


    [ x1, y1 ] = size(img1);
    [ x2, y2 ] = size(img2);
     [ ig1 ] = PrepImage( img1 );
      [ ig2 ] = PrepImage( img2 );
    figure, imshowpair(img1, img2, 'montage');
    
    
     ShowFeatures(  loc1, scal1, ori1 );
     ShowFeatures(  loc2, scal2, ori2 );
    
     feat = GetBadFeatures( img1, loc1 );

     size(feat{1})
     
     corr = conv2( ig2, rot90(  PrepImage( feat{1} )  , 2), 'same');
     [i,j] = find(corr == max(corr(:)));

end