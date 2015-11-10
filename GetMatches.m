function GetMatches( img1, loc1, scal1, ori1, img2, loc2, scal2, ori2 )


    [ x1, y1 ] = size(img1);
    [ x2, y2 ] = size(img2);
     [ ig1 ] = PrepImage( img1 );
      [ ig2 ] = PrepImage( img2 );
    figure, imshowpair(img1, img2, 'montage');
    
     [newLoc2, offval] = Offset(loc2, img1);

     ShowFeatures(  loc1, scal1, ori1 );
     ShowFeatures(  newLoc2, scal2, ori2 );
    
%      feat1 = GetBadFeatures( img1, loc1 );
%      feat2 = GetBadFeatures( img2, loc2 );
%      
      feat1 = GetRotatedFeatures( img1, loc1, ori1 );
      feat2 = GetRotatedFeatures( img2, loc2, ori2 );
      
     %pos = SSD( feat1, feat2 );
     %pos = SSDRatio( feat1, feat2 );
     pos = SSDCustom( feat1, feat2, 30 );

     [ ~, sz ] = size(pos);

hold on
for i=1:sz
    %Only plot if good match
    if pos(1,i) > 0
        j = loc1(1,1);
        p1 = [loc1(i,1),loc1(i,2)];
        p2 = [loc2(pos(1,i),1), loc2(pos(1,i),2)+offval];
        plot([p1(2),p2(2)],[p1(1),p2(1)],'r-*','LineWidth',1);
    end
end
%# plot the points.
%# Note that depending on the definition of the points,
%# you may have to swap x and y
     
%      corr = conv2( ig2, rot90(  feat{1} , 2), 'same');
%      [i,j] = find(corr == max(corr(:)));
% 
%      
%      %# make sure the image doesn't disappear if we plot something else
% hold on
% 
% %# define points (in matrix coordinates)
% p1 = [loc1(1,1),loc1(1,2)];
% p2 = [i,j+offval];
% 
% %# plot the points.
% %# Note that depending on the definition of the points,
% %# you may have to swap x and y
% plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','r','LineWidth',2);

end