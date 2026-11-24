% Day 078 · Three-Dimensional Line Plots: plot3 — A helix and a conical spiral
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

t = linspace(0, 6*pi, 500);
subplot(1, 2, 1)
plot3(cos(t), sin(t), t/(2*pi), 'LineWidth', 1.5)
grid on; xlabel('x'); ylabel('y'); zlabel('turns'); title('Helix')
subplot(1, 2, 2)
r = t / max(t);
plot3(r.*cos(3*t), r.*sin(3*t), r, 'r')
grid on; title('Conical spiral')
