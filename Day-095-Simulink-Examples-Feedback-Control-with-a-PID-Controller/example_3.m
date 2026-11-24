% Day 095 · Simulink Examples: Feedback Control with a PID Controller — Comparing P, PI and PID on the same plant
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

gains = [6 0 0; 6 4 0; 6 4 0.8];
names = {'P only', 'PI', 'PID'};
dt = 1e-3; t = 0:dt:8;
hold on
for g = 1:3
    Kp = gains(g, 1); Ki = gains(g, 2); Kd = gains(g, 3);
    x = [0; 0]; integ = 0; e_prev = 1; y = zeros(size(t));
    for k = 1:numel(t)
        y(k) = x(1); e = 1 - y(k);
        integ = integ + e*dt;
        d = (e - e_prev)/dt; e_prev = e; if k == 1, d = 0; end
        u = Kp*e + Ki*integ + Kd*d;
        x = x + dt*[x(2); u - 3*x(2) - 2*x(1)];
    end
    plot(t, y, 'DisplayName', names{g});
    fprintf('%-6s: final %.3f, steady-state error %.3f, peak %.3f\n', names{g}, y(end), 1 - y(end), max(y));
end
hold off; grid on; legend show; xlabel('t (s)')
