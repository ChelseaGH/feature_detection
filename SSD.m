
function [ sum ] = SSD( f1, f2 )
% Naive Approach:
% Sum of square differences between the elements of the two descriptors
%   (2-norm)
% Issue:
%   Can produce good scores to ambiguous (bad) matches!

    [a,~] = size(f1);
    [b,~] = size(f2);


    f1;
    
    len1 = a;
    len2 = b;
    
    M = zeros(len1,1);
    for i=1:len1
        
        x1 = f1(i,1);
        y1 = f1(i,2);
        
        D = zeros (len2,1);

        for j=1:len2
            x2 = f2(j,1);
            y2 = f2(j,2);
            D(j) = Distance( x1, y1, x2, y2 );
        end
        M(i) = min(D);
    end
    
    sum = 0;
end