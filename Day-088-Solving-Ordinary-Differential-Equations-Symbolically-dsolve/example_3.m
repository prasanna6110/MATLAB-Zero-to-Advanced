% Day 088 · Solving Ordinary Differential Equations Symbolically: dsolve — A system of two ODEs
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% MATLAB-ONLY: GNU Octave's dsolve returns systems in a different form
% Needs: Symbolic Math Toolbox
syms x(t) y(t)
eqs = [diff(x, t) == y, diff(y, t) == -x];       % simple harmonic motion
[xs, ys] = dsolve(eqs, [x(0) == 1, y(0) == 0])
check = simplify(xs^2 + ys^2)                    % stays 1: the motion is a circle
