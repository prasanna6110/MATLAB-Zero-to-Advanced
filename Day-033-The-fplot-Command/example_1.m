% Day 033 · The fplot Command — fplot with a function handle
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

f = @(x) x.^2 + 4*sin(2*x) - 1;
fplot(f, [-3 3], 'LineWidth', 1.5)
grid on
xlabel('x'); ylabel('f(x)')
title('f(x) = x^2 + 4 sin(2x) - 1')
