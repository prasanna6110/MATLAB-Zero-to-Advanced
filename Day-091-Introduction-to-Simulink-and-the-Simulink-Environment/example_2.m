% Day 091 · Introduction to Simulink and the Simulink Environment — The system we will model, solved with code
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% dy/dt = (u - y) / tau, u = unit step at t = 1 s  (a first-order lag)
% In Simulink: Step -> Sum(+ -) -> Gain(1/tau) -> Integrator -> Scope, with y fed back to the Sum.
tau = 0.8;
u = @(t) double(t >= 1);
[t, y] = ode45(@(t, y) (u(t) - y)/tau, [0 6], 0, odeset('MaxStep', 0.01));
plot(t, y, 'LineWidth', 1.5); hold on
plot(t, u(t), 'k--'); hold off; grid on
xlabel('t (s)'); legend('y(t)', 'step input u(t)', 'Location', 'southeast')
title('What the Scope of the Simulink model should show')
fprintf('y reaches 63.2%% of the step at t = %.2f s (1 + tau = %.2f)\n', interp1(y, t, 0.632), 1 + tau);
