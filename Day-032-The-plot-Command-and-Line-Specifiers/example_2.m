% Day 032 · The plot Command and Line Specifiers — Plotting a function smoothly
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

x = linspace(-2, 4, 300);          % many points -> smooth curve
y = 3.5.^(-0.5*x) .* cos(6*x);
plot(x, y, 'LineWidth', 1.2)
xlabel('x'); ylabel('y')
title('y = 3.5^{-0.5x} cos(6x)')
grid on
% Compare with only 10 points: the shape is lost
x10 = linspace(-2, 4, 10);
hold on
plot(x10, 3.5.^(-0.5*x10) .* cos(6*x10), 'ko--')
hold off
legend('300 points', '10 points')
