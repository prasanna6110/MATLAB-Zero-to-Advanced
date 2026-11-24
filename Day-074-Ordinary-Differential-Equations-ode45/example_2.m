% Day 074 · Ordinary Differential Equations: ode45 — A nonlinear ODE: draining a tank
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% dh/dt = -(a/A) sqrt(2 g h)   (Torricelli), h(0) = 2 m
A = 1.5; a = 0.01; g = 9.81;
f = @(t, h) -(a/A) * sqrt(2*g*max(h, 0));
[t, h] = ode45(f, [0 600], 2);
plot(t/60, h, 'LineWidth', 1.5); grid on
xlabel('Time (min)'); ylabel('Water level (m)')
k = find(h < 0.5, 1);
fprintf('The level falls below 0.5 m after %.1f minutes\n', t(k)/60);
