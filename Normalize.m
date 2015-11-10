

function normalized = Normalize(vector, x, y)

     % Normalize to [0, 1]:
     m = min(vector);
     range = max(vector) - m;
     vector = (vector - m) / range;

     % scale
     range2 = y - x;
     normalized = (vector*range2) + x;
     
end