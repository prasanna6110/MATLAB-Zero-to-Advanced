% Day 011 · Using the Colon in Addressing Arrays and the end Keyword — Rows, columns and sub-matrices
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

A = reshape(1:20, 4, 5)'       % a 5x4 matrix 1..20 row by row
row2 = A(2, :)
col3 = A(:, 3)
sub = A(2:4, 2:3)              % rows 2-4, columns 2-3
corners = A([1 end], [1 end])  % the four corners
last_row = A(end, :)
