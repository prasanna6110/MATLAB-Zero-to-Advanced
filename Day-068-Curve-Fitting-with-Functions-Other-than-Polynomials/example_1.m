% Day 068 · Curve Fitting with Functions Other than Polynomials — Exponential fit: capacitor discharge
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

t = 0:0.5:4;
v = [12.0 7.4 4.3 2.7 1.6 0.95 0.58 0.36 0.21];    % measured volts
p = polyfit(t, log(v), 1);
tau = -1 / p(1);
V0 = exp(p(2));
fprintf('v(t) = %.2f e^(-t/%.3f)   -> RC = %.3f s\n', V0, tau, tau);
tf = linspace(0, 4, 200);
subplot(1, 2, 1); plot(t, v, 'ko', tf, V0*exp(-tf/tau), 'r'); title('Linear axes'); grid on
subplot(1, 2, 2); semilogy(t, v, 'ko', tf, V0*exp(-tf/tau), 'r'); title('semilogy: a straight line'); grid on
