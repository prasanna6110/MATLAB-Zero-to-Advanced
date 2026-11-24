% Day 010 · The Transpose Operator and Array Addressing — Matrix elements and linear indexing
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

A = [10 20 30; 40 50 60; 70 80 90]
A(2, 3)                        % row 2, column 3 -> 60
A(3, 1) = -1                   % change one element
A(4)                           % linear index: counts down columns -> 20
k = sub2ind(size(A), 2, 3)     % (2,3) is linear index 8
[r, c] = ind2sub(size(A), 8)   % and back again
