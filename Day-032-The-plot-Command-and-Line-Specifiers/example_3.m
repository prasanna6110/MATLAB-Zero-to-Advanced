% Day 032 · The plot Command and Line Specifiers — Markers only, and plot(y)
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

rng(2);
x = 1:20;
y = 2*x + 5 + 4*randn(1, 20);
plot(x, y, 'bo', 'MarkerSize', 7)           % scatter-style, no line
xlabel('Sample'); ylabel('Value'); grid on
figure
plot(cumsum(randn(1, 200)), 'k')            % plot(y): x is 1..200
title('A random walk')
