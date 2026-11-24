% Day 092 · Building and Running Your First Simulink Model — The same mass-spring-damper with ode45 (check your model)
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

m = 1; c = 0.6; k = 4; F = 1;
[t, X] = ode45(@(t, s) [s(2); (F - c*s(2) - k*s(1))/m], [0 15], [0; 0]);
plot(t, X(:, 1), 'LineWidth', 1.5); grid on
xlabel('t (s)'); ylabel('x (m)'); title('Expected Scope output')
fprintf('Peak %.4f m, final %.4f m (F/k = %.4f)\n', max(X(:, 1)), X(end, 1), F/k);
