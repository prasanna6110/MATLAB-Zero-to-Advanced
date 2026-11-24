% Day 018 · Matrix Multiplication and the Dot Product — Dot product, outer product and cross product
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

a = [1 2 3]; b = [4 5 6];
a * b'                       % dot product = 32
dot(a, b)                    % same
a' * b                       % outer product, 3x3
cross(a, b)                  % perpendicular vector
% Work done by a force F along a displacement d
F = [10 0 5]; d = [3 4 0];
W = dot(F, d)
