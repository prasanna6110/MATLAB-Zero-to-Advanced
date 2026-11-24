% Day 069 · Interpolation: interp1, spline and interp2 — Linear, nearest, spline and pchip compared
% Run: open this file in MATLAB and press Run (or type example_1 in the Command Window)

x = 0:1:5;
y = [1 2 1.5 4 4.2 3];
xi = linspace(0, 5, 200);
methods = {'nearest', 'linear', 'spline', 'pchip'};
for k = 1:4
    subplot(2, 2, k)
    plot(x, y, 'ko', 'MarkerFaceColor', 'k'); hold on
    plot(xi, interp1(x, y, xi, methods{k}), 'LineWidth', 1.3); hold off
    title(methods{k}); ylim([0 5]); grid on
end
fprintf('At x = 2.5: linear %.3f, spline %.3f, pchip %.3f\n', ...
    interp1(x, y, 2.5), interp1(x, y, 2.5, 'spline'), interp1(x, y, 2.5, 'pchip'));
