% Day 134 · Project 27: Battery State-of-Charge Estimation with a Kalman Filter — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear; close all;
rng(4);
Q_Ah = 2.5; R0 = 0.05; R1 = 0.03; C1 = 1500; dt = 1;
soc_pts = 0:0.1:1;
ocv_pts = [3.00 3.45 3.55 3.62 3.67 3.72 3.79 3.87 3.96 4.06 4.18];
p_ocv = polyfit(soc_pts, ocv_pts, 6);  dp_ocv = polyder(p_ocv);
ocv = @(s) polyval(p_ocv, s);
% ---- a drive cycle: pulses of discharge and some charging ----
N = 7200;
I = 1.0 + 1.2*sin(2*pi*(1:N)/600) + 1.5*(mod(1:N, 900) < 120) - 3.0*(mod(1:N, 1800) > 1650);   % A, + = discharge
a = exp(-dt/(R1*C1));
soc = zeros(1, N); vrc = 0; soc(1) = 0.9; V = zeros(1, N);
for k = 1:N
    V(k) = ocv(soc(k)) - vrc - R0*I(k);
    if k < N
        soc(k + 1) = soc(k) - dt*I(k)/(3600*Q_Ah);
        vrc = a*vrc + R1*(1 - a)*I(k);
    end
end
I_meas = I + 0.05 + 0.05*randn(1, N);          % sensor bias + noise
V_meas = V + 0.01*randn(1, N);
% ---- 1) coulomb counting from a wrong initial guess ----
cc = zeros(1, N); cc(1) = 0.7;
for k = 1:N - 1, cc(k + 1) = cc(k) - dt*I_meas(k)/(3600*Q_Ah); end
% ---- 2) extended Kalman filter ----
x = [0.7; 0];  P = diag([0.1 0.01]);  Qn = diag([1e-7 1e-6]);  Rn = 0.01^2;
A = [1 0; 0 a];
ekf = zeros(1, N);
for k = 1:N
    Vpred = ocv(x(1)) - x(2) - R0*I_meas(k);
    H = [polyval(dp_ocv, x(1)), -1];
    K = P*H' / (H*P*H' + Rn);
    x = x + K*(V_meas(k) - Vpred);
    P = (eye(2) - K*H)*P;
    ekf(k) = x(1);
    x = A*x + [-dt/(3600*Q_Ah); R1*(1 - a)]*I_meas(k);   % predict the next state
    P = A*P*A' + Qn;
end
err_cc = abs(cc - soc)*100;  err_ekf = abs(ekf - soc)*100;
fprintf('True SOC from %.1f %% to %.1f %%\n', 100*soc(1), 100*soc(end));
fprintf('Coulomb counting: final error %.2f %%, mean error %.2f %%\n', err_cc(end), mean(err_cc));
fprintf('Kalman filter   : final error %.2f %%, mean error after 5 min %.2f %%\n', err_ekf(end), mean(err_ekf(300:end)));
tm = (1:N)/60;
subplot(2, 1, 1); plot(tm, 100*soc, 'k', tm, 100*cc, 'b--', tm, 100*ekf, 'r'); grid on
ylabel('SOC (%)'); legend('true', 'coulomb counting', 'EKF'); title('SOC estimation')
subplot(2, 1, 2); plot(tm, V_meas, 'Color', [0.6 0.6 0.6]); grid on; ylabel('V (V)'); xlabel('time (min)')
