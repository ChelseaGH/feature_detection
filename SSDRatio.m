function [ pos ] = SSDRatio( f1, f2 )
%SSDRatio Squared Sum of Differences with Ratio
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%
% Naive Approach:
% Sum of square differences between the elements of the two descriptors
%   (2-norm)
% Issue:
%   Can produce good scores to ambiguous (bad) matches!
    [ sz1, ~ ] = size(f1);
    [ sz2, ~ ] = size(f2);

    pos = zeros(1,sz1);
    
    for i=1:sz1
        %set minimum
        min  = norm(f1{i} - f2{1});
        min2 = norm(f1{i} - f2{1});
        pos(1,1) = 0;

        for j=2:sz2
            %get distance
            dist = norm(f1{i} - f2{j});
            %replace closest and second closest
            if min > dist
               min2 = min;
               min = dist;
               pos(1,i) = j;
            end
        end
        validation = min / min2;
        
        %Throw out anything that doesn't pass validation
        if validation > 0.8
           pos(1,i) = 0;
        end
    end    
    
end