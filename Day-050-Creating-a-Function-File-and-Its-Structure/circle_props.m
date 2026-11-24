function [area, circumference] = circle_props(r)
% CIRCLE_PROPS  Area and circumference of a circle.
%   [A, C] = CIRCLE_PROPS(R) returns the area A and the circumference C
%   of a circle of radius R. R can be a vector: then A and C are vectors.
%
%   Example:
%       [a, c] = circle_props(2)
area = pi * r.^2;              % .^ so that it also works for vectors
circumference = 2 * pi * r;
end

% (Course file for Day 050 · Creating a Function File and Its Structure)
