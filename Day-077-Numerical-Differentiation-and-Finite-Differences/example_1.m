% Day 077 · Numerical Differentiation and Finite Differences — diff vs gradient on a known function
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

h = 0.1;
x = 0:h:2;
y = x.^3;
exact = 3*x.^2;
d_forward = diff(y) / h;                 % length n-1
d_central = gradient(y, h);              % length n
fprintf('max error forward : %.4f\n', max(abs(d_forward - exact(1:end-1))));
fprintf('max error central : %.4f (inside points: %.4f)\n', max(abs(d_central - exact)), max(abs(d_central(2:end-1) - exact(2:end-1))));
plot(x, exact, 'k', x(1:end-1), d_forward, 'r--', x, d_central, 'b:', 'LineWidth', 1.4)
legend('exact 3x^2', 'forward', 'central', 'Location', 'northwest'); grid on
