function normalized = Normalize(vector, x, y)
%Normalize Normalize a vector to a range
% Usually 0-1
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%
     
    % Normalize to [x, y]:
     m = min(vector);
     range = max(vector) - m;
     vector = (vector - m) / range;

     % scale
     range2 = y - x;
     normalized = (vector*range2) + x;
     
end