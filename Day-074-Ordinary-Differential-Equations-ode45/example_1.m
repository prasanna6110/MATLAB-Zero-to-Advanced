% Day 074 · Ordinary Differential Equations: ode45 — A first-order ODE: an RC circuit
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% dv/dt = (Vs - v) / (R C), v(0) = 0
R = 1e3; C = 470e-6; Vs = 12;
f = @(t, v) (Vs - v) / (R*C);
[t, v] = ode45(f, [0 3], 0);
v_exact = Vs * (1 - exp(-t/(R*C)));
plot(t, v, 'o', t, v_exact, '-'); grid on
xlabel('t (s)'); ylabel('v_C (V)'); legend('ode45', 'exact', 'Location', 'southeast')
fprintf('Max error vs exact solution: %.2e V\n', max(abs(v - v_exact)));
