% Day 035 · Formatting a Plot: Labels, Title, Text, Legend, Axis and Grid — A fully labelled plot
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

t = linspace(0, 5, 300);
tau = 1;
v = 10 * (1 - exp(-t/tau));
plot(t, v, 'b', 'LineWidth', 2)
xlabel('Time t (s)', 'FontSize', 12)
ylabel('v_C(t) (V)', 'FontSize', 12)
title('Charging: v_C = 10(1 - e^{-t/\tau}),  \tau = 1 s')
axis([0 5 0 11])
grid on
hold on
plot(tau, 10*(1 - exp(-1)), 'ro', 'MarkerFaceColor', 'r')
text(tau + 0.15, 6.0, '63.2% at t = \tau', 'Color', 'r')
hold off
