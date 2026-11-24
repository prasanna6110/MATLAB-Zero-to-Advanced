% Day 067 · Curve Fitting with Polynomials: polyfit — Choosing the degree (and overfitting)
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

x = 0:0.5:5;
y = [0 0.8 2.1 2.9 3.7 3.9 4.1 3.8 3.2 2.1 0.7];
xf = linspace(0, 5, 200);
degrees = [1 2 3 10];
for k = 1:4
    p = polyfit(x, y, degrees(k));
    res = y - polyval(p, x);
    R2 = 1 - sum(res.^2) / sum((y - mean(y)).^2);
    subplot(2, 2, k)
    plot(x, y, 'o', xf, polyval(p, xf))
    title(sprintf('degree %d, R^2 = %.4f', degrees(k), R2))
    ylim([-2 6])
end
