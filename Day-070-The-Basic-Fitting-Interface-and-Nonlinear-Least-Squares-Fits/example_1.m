% Day 070 · The Basic Fitting Interface and Nonlinear Least-Squares Fits — A nonlinear fit with fminsearch
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

t = 0:0.5:6;
y = [0 2.9 4.9 6.3 7.3 7.9 8.4 8.7 8.9 9.1 9.1 9.2 9.2];   % a first-order step response
model = @(c, t) c(1) * (1 - exp(-t / c(2)));
sse = @(c) sum((y - model(c, t)).^2);
c = fminsearch(sse, [5 1]);
fprintf('Final value K = %.3f, time constant tau = %.3f s\n', c(1), c(2));
tf = linspace(0, 6, 200);
plot(t, y, 'ko', tf, model(c, tf), 'r-'); grid on
xlabel('t (s)'); legend('data', 'fit', 'Location', 'southeast')
title(sprintf('y = %.2f(1 - e^{-t/%.2f})', c(1), c(2)))
