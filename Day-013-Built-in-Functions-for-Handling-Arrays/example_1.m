% Day 013 · Built-in Functions for Handling Arrays — size, length, numel
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

A = rand(3, 7);
length(A)
size(A)
[rows, cols] = size(A)
numel(A)
isvector(1:5), isscalar(7), isempty([])
