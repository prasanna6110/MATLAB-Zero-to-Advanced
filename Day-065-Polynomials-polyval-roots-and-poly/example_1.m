% Day 065 · Polynomials: polyval, roots and poly — Evaluating and plotting a polynomial
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

p = [1 -12.1 40.59 -17.015 -71.95 35.88];   % degree 5
polyval(p, 9)
x = linspace(-1.5, 6.7, 300);
y = polyval(p, x);
plot(x, y, 'LineWidth', 1.5); grid on
xlabel('x'); ylabel('p(x)'); title('A fifth-degree polynomial')
r = roots(p)
hold on
plot(real(r(abs(imag(r)) < 1e-9)), 0*r(abs(imag(r)) < 1e-9), 'ro', 'MarkerFaceColor', 'r')
hold off
