% Day 001 · What is MATLAB? Installation and the MATLAB Desktop — Everything is a matrix
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

a = 7;
size(a)            % 1 1 -> a single number is a 1x1 matrix
v = [1 2 3 4];
size(v)            % 1 4 -> a row vector
M = [1 2; 3 4; 5 6];
size(M)            % 3 2 -> 3 rows, 2 columns
class(a)           % 'double' -> the default number type
