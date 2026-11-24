% Day 034 · Plotting Multiple Graphs: plot with Several Pairs, hold, and line — hold on / hold off
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

t = linspace(0, 0.04, 400);
va = 325*sin(2*pi*50*t);
vb = 325*sin(2*pi*50*t - 2*pi/3);
vc = 325*sin(2*pi*50*t + 2*pi/3);
plot(t*1000, va, 'r')
hold on
plot(t*1000, vb, 'g')
plot(t*1000, vc, 'b')
hold off
xlabel('Time (ms)'); ylabel('Voltage (V)')
legend('V_a', 'V_b', 'V_c')
title('Three-phase supply')
grid on
