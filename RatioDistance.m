
function [ sum ] = RatioDistance( f1, f2, f2prime )
    sum = SSD( f1, f2 ) / SSD( f1, f2prime );
end