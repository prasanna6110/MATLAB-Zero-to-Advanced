% Day 073 · Numerical Integration: integral, trapz and cumtrapz — Double integrals and comparing methods
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Volume under z = x*y over the triangle 0<=x<=1, 0<=y<=x  (exact 1/8)
V = integral2(@(x, y) x.*y, 0, 1, 0, @(x) x)
% Area of a circle of radius 2 by integrating 1 over the disc
A = integral2(@(x, y) ones(size(x)), -2, 2, @(x) -sqrt(4 - x.^2), @(x) sqrt(4 - x.^2))
% trapz accuracy improves with more points
exact = 2;      % integral of sin from 0 to pi
for n = [5 10 50 200]
    x = linspace(0, pi, n);
    fprintf('n = %3d: trapz error = %.2e\n', n, abs(trapz(x, sin(x)) - exact));
end
