% Day 034 · Plotting Multiple Graphs: plot with Several Pairs, hold, and line — The line command and DisplayName
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

x = 0:0.1:10;
plot(x, sqrt(x), 'DisplayName', '\surd x')
line(x, log(x + 1), 'Color', 'r', 'LineStyle', '--', 'DisplayName', 'ln(x+1)')
line([0 10], [2 2], 'Color', [0.5 0.5 0.5], 'DisplayName', 'level 2')
legend show
xlabel('x'); grid on
