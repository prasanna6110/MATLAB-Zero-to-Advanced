% Day 094 · Physical Modelling with Simscape and Simulink-Supported Hardware — A DC motor model (what a Simscape motor block solves)
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Armature: L di/dt = V - R i - Ke w ;  Mechanics: J dw/dt = Kt i - b w - T_load
R = 1.2; L = 0.005; Ke = 0.05; Kt = 0.05; J = 2e-4; b = 1e-5; V = 12;
T_load = @(t) 0.02 * (t >= 0.6);                % a load torque applied at 0.6 s
f = @(t, s) [(V - R*s(1) - Ke*s(2))/L; (Kt*s(1) - b*s(2) - T_load(t))/J];
[t, S] = ode45(f, [0 1.2], [0; 0], odeset('MaxStep', 1e-3));
subplot(2, 1, 1); plot(t, S(:, 2)*60/(2*pi)); ylabel('Speed (rpm)'); grid on
subplot(2, 1, 2); plot(t, S(:, 1)); ylabel('Current (A)'); xlabel('t (s)'); grid on
fprintf('No-load speed %.0f rpm, loaded speed %.0f rpm\n', interp1(t, S(:, 2), 0.59)*60/(2*pi), S(end, 2)*60/(2*pi));
