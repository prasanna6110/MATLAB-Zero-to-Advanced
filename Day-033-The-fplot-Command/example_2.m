% Day 033 · The fplot Command — Several functions and a parametric curve
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

fplot(@(t) exp(-t), [0 5], 'b')
hold on
fplot(@(t) 1 - exp(-t), [0 5], 'r--')
fplot(@(t) t.*exp(-t), [0 5], 'k:')
hold off
legend('e^{-t}', '1 - e^{-t}', 't e^{-t}')
xlabel('t (time constants)')
figure
t = linspace(0, 2*pi, 500);       % a parametric curve: x(t), y(t)
plot(sin(3*t), sin(4*t))          % (MATLAB also allows fplot(@(t) sin(3*t), @(t) sin(4*t), [0 2*pi]))
axis equal
title('x = sin 3t, y = sin 4t')
