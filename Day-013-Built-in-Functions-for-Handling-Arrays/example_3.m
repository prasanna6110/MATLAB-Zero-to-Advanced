% Day 013 · Built-in Functions for Handling Arrays — Column-wise vs row-wise vs whole matrix
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

M = [8 1 6; 3 5 7; 4 9 2]
max(M)                              % maximum of each column
max(M, [], 2)'                      % maximum of each row
max(M(:))                           % maximum of everything
[~, idx] = max(M(:));               % ~ ignores an output
[r, c] = ind2sub(size(M), idx)      % position of the overall maximum
sortrows([3 30; 1 10; 2 20], 1)     % sort rows by column 1
