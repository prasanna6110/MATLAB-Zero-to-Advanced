% Day 071 · Solving an Equation with One Variable: fzero — Watching fzero iterate, and the roots of a polynomial
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

opts = optimset('Display', 'iter', 'TolX', 1e-10);
x = fzero(@(x) cos(x) - x, [0 1], opts);
fprintf('cos(x) = x at x = %.10f\n', x);
p = [1 -2 -5 6];
fprintf('roots: %s\n', mat2str(roots(p)', 6));
fprintf('fzero near 0: %.6f\n', fzero(@(x) polyval(p, x), 0));
