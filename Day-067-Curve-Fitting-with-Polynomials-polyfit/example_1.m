% Day 067 · Curve Fitting with Polynomials: polyfit — Fitting a straight line
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

V = [0 1 2 3 4 5 6];                       % applied voltage
I = [0.02 0.98 2.05 2.97 4.10 4.95 6.02];  % measured current (mA)
p = polyfit(V, I, 1);
R_kohm = 1 / p(1);
fprintf('I = %.4f V %+.4f  ->  R = %.3f kohm\n', p(1), p(2), R_kohm);
res = I - polyval(p, V);
R2 = 1 - sum(res.^2) / sum((I - mean(I)).^2);
fprintf('R^2 = %.5f\n', R2);
plot(V, I, 'ko', V, polyval(p, V), 'r-')
xlabel('V'); ylabel('I (mA)'); legend('data', 'fit', 'Location', 'northwest'); grid on
