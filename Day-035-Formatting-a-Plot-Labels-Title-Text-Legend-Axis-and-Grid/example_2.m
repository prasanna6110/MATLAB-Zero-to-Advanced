% Day 035 · Formatting a Plot: Labels, Title, Text, Legend, Axis and Grid — Axis options and custom ticks
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

x = linspace(0, 2*pi, 200);
plot(x, sin(x), x, cos(x), '--', 'LineWidth', 1.5)
xlim([0 2*pi]); ylim([-1.2 1.2])
xticks(0:pi/2:2*pi)
xticklabels({'0', '\pi/2', '\pi', '3\pi/2', '2\pi'})
legend('sin \theta', 'cos \theta', 'Location', 'southwest')
grid on
figure
th = linspace(0, 2*pi, 100);
plot(2*cos(th), 2*sin(th))
axis equal                          % otherwise the circle looks like an ellipse
title('axis equal keeps circles round')
