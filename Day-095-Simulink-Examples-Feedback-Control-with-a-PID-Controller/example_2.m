% Day 095 · Simulink Examples: Feedback Control with a PID Controller — The same PID loop simulated step by step in plain MATLAB
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

% Plant 1/(s^2 + 3s + 2), PID gains as in the Simulink model, unity feedback
Kp = 6; Ki = 4; Kd = 0.8;
dt = 1e-4; t = 0:dt:6; r = 1;
x = [0; 0]; integ = 0; e_prev = r;               % plant states y, y'
y = zeros(size(t));
for k = 1:numel(t)
    y(k) = x(1);
    e = r - y(k);
    integ = integ + e*dt;
    deriv = (e - e_prev)/dt;  e_prev = e;
    if k == 1, deriv = 0; end                      % avoid the derivative kick at t = 0
    u = Kp*e + Ki*integ + Kd*deriv;
    x = x + dt * [x(2); u - 3*x(2) - 2*x(1)];      % Euler step of the plant
end
plot(t, y, 'LineWidth', 1.5); grid on; xlabel('t (s)'); ylabel('y'); title('PID loop simulated in code')
final = y(end); os = 100*(max(y) - final)/final;
ts = t(find(abs(y - final) > 0.02*final, 1, 'last'));
fprintf('Final value %.4f, overshoot %.1f %%, settling time (2%%) %.2f s\n', final, os, ts);
