% Day 017 · Addition, Subtraction and Operations with Scalars — Implicit expansion
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

X = [1 2 3; 4 5 6; 7 8 9];
row = [10 20 30];
X + row                    % row added to every row
col = [100; 200; 300];
X + col                    % column added to every column
outer = (1:3)' + (1:4)     % 3x4 table of sums
X - mean(X)                % each column now has mean 0
