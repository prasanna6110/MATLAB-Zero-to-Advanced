% Day 101 · Statistics and Probability Distributions — Fitting a Weibull distribution to wind speeds and a t-test
% Run: open this file in MATLAB and press Run (or type example_3 in the Command Window)

% Needs: Statistics and Machine Learning Toolbox
rng(5);
v = wblrnd(8, 2.2, 1, 2000);                 % simulated hourly wind speeds (scale 8 m/s, shape 2.2)
params = wblfit(v);
fprintf('Fitted Weibull: scale %.2f m/s, shape %.2f\n', params(1), params(2));
fprintf('P(wind above the 3 m/s cut-in speed) = %.3f\n', 1 - wblcdf(3, params(1), params(2)));
[cnt, centers] = hist(v, 30);
bar(centers, cnt / (numel(v) * (centers(2) - centers(1))), 1); hold on   % histogram as a density
xs = linspace(0, max(v), 200);
plot(xs, wblpdf(xs, params(1), params(2)), 'r', 'LineWidth', 2); hold off  % (MATLAB: histfit(v, 30, 'weibull'))
xlabel('Wind speed (m/s)'); legend('data', 'Weibull fit')
old_design = 92 + 2*randn(1, 25);            % efficiency of 25 old and 25 new motors
new_design = 93.5 + 2*randn(1, 25);
[h, pval] = ttest2(new_design, old_design);
fprintf('New vs old efficiency: difference %.2f %%, p = %.4f, significant = %d\n', mean(new_design) - mean(old_design), pval, h);
