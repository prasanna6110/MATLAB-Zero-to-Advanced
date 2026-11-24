% Day 093 · Model-Based Design: Subsystems, Transfer Functions and MATLAB Function Blocks — The same closed-loop sweep computed with ode45
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Plant 1/(s^2 + 3s + 2) with proportional gain K and unity feedback:
% y'' + 3y' + 2y = K (r - y),  r = 1
hold on
for K = [1 5 20]
    [t, Y] = ode45(@(t, s) [s(2); K*(1 - s(1)) - 3*s(2) - 2*s(1)], [0 8], [0; 0]);
    plot(t, Y(:, 1), 'DisplayName', sprintf('K = %d', K));
    fprintf('K = %2d: final value %.3f (theory K/(K+2) = %.3f), overshoot %.1f %%\n', K, Y(end, 1), K/(K + 2), 100*max(0, max(Y(:, 1)) - K/(K+2))/(K/(K+2)));
end
hold off; grid on; legend show; xlabel('t (s)')
