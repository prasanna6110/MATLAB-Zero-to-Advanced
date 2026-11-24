% Day 036 · Plots with Logarithmic Axes and Error Bars — A power law is a straight line on loglog
% Run: open this file in MATLAB and press Run (or type example_2 in the Command Window)

P = logspace(0, 4, 50);            % 1 W to 10 kW
cost = 15 * P.^0.7;                % equipment cost model
loglog(P, cost, 'LineWidth', 1.5)
grid on
xlabel('Rating (W)'); ylabel('Cost (Rs)')
p = polyfit(log10(P), log10(cost), 1);
title(sprintf('Slope on loglog = %.2f (the exponent)', p(1)))
