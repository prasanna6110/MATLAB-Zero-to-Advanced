% Day 099 · Control Systems 2: Bode, Root Locus, Margins and PID Design — Designing a PID with Ziegler-Nichols and checking it
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Needs: Control System Toolbox
s = tf('s');
G = 1 / (s*(s + 2)*(s + 10));
Ku = 240; Pu = 2*pi/sqrt(20);                        % from the previous example
Kp = 0.6*Ku; Ki = Kp/(Pu/2); Kd = Kp*Pu/8;
C = pid(Kp, Ki, Kd);
T_p = feedback(0.5*Ku*G, 1);                         % P only (Kp = 0.5 Ku)
T_pid = feedback(C*G, 1);
[y1, t1] = step(T_p, 8);
[y2, t2] = step(T_pid, 8);
plot(t1, y1, t2, y2, 'LineWidth', 1.3); grid on
legend('P (0.5 Ku)', 'Ziegler-Nichols PID'); xlabel('t (s)')
fprintf('Kp = %.1f, Ki = %.1f, Kd = %.1f\n', Kp, Ki, Kd);
fprintf('Value at t = 8 s: P %.3f, PID %.3f; PID overshoot %.0f %% (Z-N gains are aggressive: fine-tune them next)\n', y1(end), y2(end), 100*(max(y2) - 1));
