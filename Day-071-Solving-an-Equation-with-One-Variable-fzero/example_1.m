% Day 071 · Solving an Equation with One Variable: fzero — Plot first, then find each root
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

f = @(x) x .* exp(-x) - 0.2;
fplot(f, [0 8]); grid on; hold on
r1 = fzero(f, 0.5);
r2 = fzero(f, [1 5]);              % an interval with a sign change
plot([r1 r2], [0 0], 'ro', 'MarkerFaceColor', 'r'); hold off
fprintf('Roots: %.6f and %.6f\n', r1, r2);
[x, fval, flag] = fzero(f, 3)
