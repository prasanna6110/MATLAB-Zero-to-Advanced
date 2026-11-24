# Day 101 · Statistics and Probability Distributions

_Advanced MATLAB and Toolboxes_

## Descriptive statistics (core MATLAB)
`mean`, `median`, `mode`, `std`, `var`, `min`, `max`, `range`, `prctile`, `quantile`, `iqr`, `skewness`, `kurtosis`, `corrcoef`, `cov`, `zscore`, `normalize`, `boxplot` (Statistics toolbox in older versions).

## Probability distributions (Statistics and Machine Learning Toolbox)
| Function | For the normal distribution | Meaning |
|----------|-----------------------------|---------|
| pdf | `normpdf(x, mu, sigma)` | probability density |
| cdf | `normcdf(x, mu, sigma)` | P(X ≤ x) |
| inverse cdf | `norminv(p, mu, sigma)` | the x with P(X ≤ x) = p |
| random numbers | `normrnd(mu, sigma, m, n)` | samples |
| fit | `fitdist(x, 'Normal')`, `normfit(x)` | estimate the parameters |

The same pattern works for other distributions: `binopdf`, `poisspdf`, `exppdf`, `unifpdf`, `wblpdf` (Weibull, used for **wind speed**), `lognpdf`, `chi2pdf`, `tpdf`, `fpdf`. The generic forms are `pdf('Weibull', x, a, b)`, `cdf(...)`, `random(...)`.

## Hypothesis tests and regression
- `ttest`, `ttest2` (compare means), `chi2gof`, `anova1`, `kstest`
- `regress(y, X)`, `fitlm(X, y)` (linear models with statistics), `polyfit`

The p-value tells you how surprising the data would be if the "no effect" hypothesis were true; p < 0.05 is the usual (arbitrary) threshold.

## Examples

### Example 1: Normal distribution: probabilities and quality control  ([`example_1.m`](example_1.m))

```matlab
% Needs: Statistics and Machine Learning Toolbox
mu = 230; sigma = 2.5;                       % supply voltage
p_in = normcdf(236, mu, sigma) - normcdf(224, mu, sigma);
fprintf('P(224 V < V < 236 V) = %.4f\n', p_in);
fprintf('Voltage exceeded only 1%% of the time: %.2f V\n', norminv(0.99, mu, sigma));
x = linspace(220, 240, 300);
plot(x, normpdf(x, mu, sigma), 'LineWidth', 1.5); grid on
hold on
xx = linspace(224, 236, 100);
area(xx, normpdf(xx, mu, sigma), 'FaceColor', [0.7 0.85 1]); hold off
xlabel('Voltage (V)'); title('Normal pdf, shaded = within limits')
```

### Example 2: Binomial and Poisson: failures and arrivals  ([`example_2.m`](example_2.m))

```matlab
% Needs: Statistics and Machine Learning Toolbox
n = 20; p = 0.05;                            % 20 transformers, each fails with 5% chance per year
k = 0:5;
pb = binopdf(k, n, p);
fprintf('P(k failures in a year): %s\n', mat2str(pb, 3));
fprintf('P(at least one failure) = %.4f\n', 1 - binopdf(0, n, p));
lambda = 3;                                  % faults per month on a feeder, on average
fprintf('P(more than 5 faults in a month) = %.4f\n', 1 - poisscdf(5, lambda));
bar(0:10, poisspdf(0:10, lambda)); xlabel('faults per month'); ylabel('probability')
```

### Example 3: Fitting a Weibull distribution to wind speeds and a t-test  ([`example_3.m`](example_3.m))

```matlab
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
```

## Practice

1. Marks are normal with mean 65 and std 12. What fraction of students score above 80?
2. A machine makes 2% defective parts. In a box of 50, what is the probability of at most 1 defect?
3. Generate 1000 samples from an exponential distribution and fit it back with `expfit`.
4. Use `ttest2` on two groups of your own data and explain the p-value.

---

[⬅ Day 100](../Day-100-Image-Processing-Basics-Images-as-Matrices/README.md) · [🏠 Home](../README.md) · [Day 102 ➡](../Day-102-Machine-Learning-in-MATLAB/README.md)
