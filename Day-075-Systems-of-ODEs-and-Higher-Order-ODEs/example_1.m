% Day 075 · Systems of ODEs and Higher-Order ODEs — A series RLC circuit (second order)
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% L q'' + R q' + q/C = V(t)   with i = q'
R = 10; L = 0.1; C = 100e-6; V = 24;
f = @(t, y) [y(2); (V - R*y(2) - y(1)/C) / L];     % y = [q; i]
[t, Y] = ode45(f, [0 0.1], [0; 0]);
vC = Y(:, 1) / C;
subplot(2, 1, 1); plot(t*1000, Y(:, 2)); ylabel('i (A)'); grid on
subplot(2, 1, 2); plot(t*1000, vC); ylabel('v_C (V)'); xlabel('t (ms)'); grid on
zeta = R/2 * sqrt(C/L);
fprintf('zeta = %.3f, overshoot of vC = %.1f %%\n', zeta, 100*(max(vC) - V)/V);
