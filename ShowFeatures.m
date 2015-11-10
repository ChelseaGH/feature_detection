function ShowFeatures( location, scale, orientation )

    %Computers are row major, but we like to think of x first y second
    %When plotting, so let's flip these around
    x = location(:,2);
    y =  location(:,1);
    pt = [ x, y ];


    %Determine loop size based on the number of locations in list
    [locX, locY] = size(pt);
    
    Xcoord = zeros(1, 7);
    Ycoord = zeros(1, 7);
    angle = zeros (size(orientation));
    box = zeros (size(scale));

    size(scale);
    
    scale = scale * 2;
    
    for i=1:locX
        
        %Use Rotation Matrix to determine how much each box is rotated
        angle = orientation;
        Rot = [ cos(angle(i)) -sin(angle(i)) ; 
              sin(angle(i)) cos(angle(i)) ];
        box(i) = 10;

        %Set the scaling of the box based on previous scaling weights
        box(i) = box(i) * (scale(i));

        %Generate Points
        [ xRight, xLeft, yTop, yBottom ] = GetPoints( pt, box, i );
        xPoint = pt(i,1);
        yPoint = pt(i,2);

        %Draw Box (first 4 pts), 
        %go back and draw orientation line (last 3 pts)
        %Top Right, Bottom Right, Bottom Left, Top Left, Top Right, Middle.
        Ycoord(1,:) = [ yTop   yBottom yBottom yTop  yTop   yPoint yPoint ];
        Xcoord(1,:) = [ xRight xRight  xLeft   xLeft xRight xRight xPoint ];

        %Create a matrix of length Xcoord of center coords
        Rpoint = repmat([xPoint;yPoint], 1, length(Xcoord(1,:)));

        %Combine into 2D Coordinate Matrix
        Coord = [Xcoord(1,:);Ycoord(1,:)];
        
        size(Coord);
        %Rotate points, but put everything to the center first.
        Rcoord = -Rot * (Coord - Rpoint) + Rpoint;

        %Slice them back into vectors
        RotxCoord = Rcoord(1,:);
        RotyCoord = Rcoord(2,:);
        hold on

        %Plot the vectors
        plot(RotxCoord, RotyCoord, 'm-');
        %axis equal;

    end

end
