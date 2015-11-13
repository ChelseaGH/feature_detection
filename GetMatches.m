function GetMatches( img1, loc1, scal1, ori1, img2, loc2, scal2, ori2, tol )
%GetMatches Plot lines from one image to another based on features
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%

    if nargin < 9
       tol = 10; 
    end
    
    [ x1, y1 ] = size(img1);
    [ x2, y2 ] = size(img2);
    [ ig1 ] = PrepImage( img1 );
    [ ig2 ] = PrepImage( img2 );
    figure, imshowpair(img1, img2, 'montage');

    %Determine offset
    [newLoc2, offval] = Offset(loc2, img1);

    %Plot both sets of squares on one plane
    ShowFeatures(  loc1, scal1, ori1 );
    ShowFeatures(  newLoc2, scal2, ori2 );

%     feat1 = GetBadFeatures( img1, loc1 );
%     feat2 = GetBadFeatures( img2, loc2 );
% 
%     feat1 = GetRotatedFeatures( img1, loc1, ori1 );
%     feat2 = GetRotatedFeatures( img2, loc2, ori2 );


    feat1 = GetSIFTy( img1, loc1 );
    feat2 = GetSIFTy( img2, loc2 );
    %pos = SSD( feat1, feat2 );
    %pos = SSDRatio( feat1, feat2 );
    pos = SSDCustom( feat1, feat2, tol );

    [ ~, sz ] = size(pos);

    %Plot that stuffff
    hold on
    for i=1:sz
        %Only plot if good match
        if pos(1,i) > 0
            p1 = [loc1(i,1),loc1(i,2)];
            p2 = [loc2(pos(1,i),1), loc2(pos(1,i),2)+offval];
            plot([p1(2),p2(2)],[p1(1),p2(1)],'r-*','LineWidth',1);
        end
    end
end