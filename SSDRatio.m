
function [ pos ] = SSDRatio( f1, f2 )
% Naive Approach:
% Sum of square differences between the elements of the two descriptors
%   (2-norm)
% Issue:
%   Can produce good scores to ambiguous (bad) matches!
    [ sz1, ~ ] = size(f1);
    [ sz2, ~ ] = size(f2);

    pos = zeros(1,sz1);
    
    for i=1:sz1
        min  = norm(f1{i} - f2{1});
        min2 = norm(f1{i} - f2{1});
        pos(1,1) = 0;

        for j=2:sz2
            dist = norm(f1{i} - f2{j});
            if min > dist
               min2 = min;
               min = dist;
               pos(1,i) = j;
            end
        end
        validation = min / min2;
        if validation > 0.8
           pos(1,i) = 0;
        end
    end    
    
end