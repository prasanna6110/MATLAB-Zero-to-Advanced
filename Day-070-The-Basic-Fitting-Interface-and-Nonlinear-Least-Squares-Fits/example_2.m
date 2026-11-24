% Day 070 · The Basic Fitting Interface and Nonlinear Least-Squares Fits — Fitting a damped oscillation
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

rng(3);
t = linspace(0, 4, 60);
true_c = [5 0.8 6 0.3];                                   % A, decay, w, phase
model = @(c, t) c(1) * exp(-c(2)*t) .* cos(c(3)*t + c(4));
y = model(true_c, t) + 0.15*randn(size(t));
sse = @(c) sum((y - model(c, t)).^2);
c = fminsearch(sse, [4 1 5.5 0], optimset('MaxFunEvals', 5000, 'MaxIter', 5000));
fprintf('Fitted A = %.2f, alpha = %.2f, w = %.2f rad/s, phase = %.2f\n', c);
plot(t, y, 'b.', t, model(c, t), 'r-'); grid on
legend('noisy data', 'fit')
