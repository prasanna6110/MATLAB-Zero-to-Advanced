% Day 082 · Animation in MATLAB — A pendulum animation from an ODE solution
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

L = 1; g = 9.81;
[t, S] = ode45(@(t, s) [s(2); -g/L*sin(s(1))], linspace(0, 4, 80), [deg2rad(70); 0]);
figure
rod = plot([0 L*sin(S(1, 1))], [0 -L*cos(S(1, 1))], 'k-', 'LineWidth', 2); hold on
bob = plot(L*sin(S(1, 1)), -L*cos(S(1, 1)), 'ro', 'MarkerSize', 14, 'MarkerFaceColor', 'r');
hold off; axis equal; axis([-1.2 1.2 -1.2 0.2]); grid on
for k = 1:numel(t)
    xk = L*sin(S(k, 1)); yk = -L*cos(S(k, 1));
    set(rod, 'XData', [0 xk], 'YData', [0 yk]);
    set(bob, 'XData', xk, 'YData', yk);
    title(sprintf('t = %.2f s', t(k)));
    drawnow
end
fprintf('Swing amplitude stays %.1f deg (no friction)\n', rad2deg(max(S(:, 1))));
