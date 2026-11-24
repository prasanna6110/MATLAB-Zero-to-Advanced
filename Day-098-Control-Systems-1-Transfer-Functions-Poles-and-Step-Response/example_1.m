% Day 098 · Control Systems 1: Transfer Functions, Poles and Step Response — Transfer functions, poles and the step response
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

% Needs: Control System Toolbox
s = tf('s');
G = 25 / (s^2 + 4*s + 25)
p = pole(G)
wn = abs(p(1)); zeta = -real(p(1))/wn;
fprintf('wn = %.2f rad/s, zeta = %.2f, DC gain = %.2f\n', wn, zeta, dcgain(G));
[y, t] = step(G, 4);
plot(t, y, 'LineWidth', 1.5); grid on; xlabel('t (s)'); title('Step response')
os = (max(y) - 1)*100;
ts = t(find(abs(y - 1) > 0.02, 1, 'last'));
fprintf('Overshoot %.1f %% (formula %.1f %%), settling time %.2f s (4/(zeta wn) = %.2f s)\n', ...
    os, 100*exp(-zeta*pi/sqrt(1 - zeta^2)), ts, 4/(zeta*wn));
