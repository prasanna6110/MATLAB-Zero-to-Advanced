% Day 012 · Adding Elements, Deleting Elements and Reshaping Arrays — Growing vectors and matrices
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

v = [4 8];
v(5) = 20                     % elements 3 and 4 become 0
v(end+1) = 24                 % append
v = [v 28 32]                 % append several
A = eye(2);
A(3, 4) = 9                   % grows to 3x4, padded with zeros
A(end+1, :) = 1:4             % add a new row
