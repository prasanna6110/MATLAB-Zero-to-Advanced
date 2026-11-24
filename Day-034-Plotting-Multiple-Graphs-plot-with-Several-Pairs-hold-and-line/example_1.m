% Day 034 · Plotting Multiple Graphs: plot with Several Pairs, hold, and line — A function and its derivatives in one plot call
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

x = linspace(-2, 4, 200);
y = 3*x.^3 - 26*x + 10;
dy = 9*x.^2 - 26;
d2y = 18*x;
plot(x, y, 'b-', x, dy, 'r--', x, d2y, 'k:', 'LineWidth', 1.4)
legend('y', 'y''', 'y''''', 'Location', 'northwest')
xlabel('x'); grid on
title('y = 3x^3 - 26x + 10 and its derivatives')
