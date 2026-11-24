% Day 089 · Plotting Symbolic Expressions and Numerical Calculations — From a symbolic result to a plot
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Needs: Symbolic Math Toolbox
syms x
f = x^3 - 6*x^2 + 9*x + 1;
df = diff(f);
fh = matlabFunction(f);
dfh = matlabFunction(df);
fplot(fh, [-0.5 4.5]); hold on
fplot(dfh, [-0.5 4.5], '--'); hold off
grid on; legend('f(x)', 'f''(x)')
crit = double(solve(df == 0, x));
fprintf('Turning points at x = %s\n', mat2str(crit', 4));
