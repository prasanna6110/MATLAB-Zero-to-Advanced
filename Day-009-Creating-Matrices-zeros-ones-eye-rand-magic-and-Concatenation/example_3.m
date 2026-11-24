% Day 009 · Creating Matrices: zeros, ones, eye, rand, magic and Concatenation — Building bigger matrices from smaller ones
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

A = [1 2; 3 4];
B = [5 6; 7 8];
side = [A B]                    % 2x4
stacked = [A; B]                % 4x2
block = [A zeros(2); zeros(2) B] % a block-diagonal 4x4 matrix
three_d = cat(3, A, B);         % a 2x2x2 array
size(three_d)
% Error example: rows of different length
try
    bad = [1 2 3; 4 5];
catch err
    disp(err.message)
end
