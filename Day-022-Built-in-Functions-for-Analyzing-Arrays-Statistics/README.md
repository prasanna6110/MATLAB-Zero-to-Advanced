# Day 022 · Built-in Functions for Analyzing Arrays (Statistics)

_Mathematics with Arrays_

## Analysis functions
| Function | Returns |
|----------|---------|
| `mean(A)` | the average (of each column for a matrix) |
| `median(A)` | the middle value |
| `mode(A)` | the most frequent value |
| `std(A)` | the standard deviation (n-1 denominator); `std(A, 1)` uses n |
| `var(A)` | the variance |
| `sum(A)`, `prod(A)` | sum and product |
| `cumsum(A)`, `cumprod(A)` | running sum / product |
| `max`, `min`, `range` (`max - min`) | extremes |
| `sort`, `sortrows` | sorting |
| `det`, `inv`, `trace`, `rank`, `norm` | matrix functions |
| `corrcoef(x, y)`, `cov(x, y)` | correlation and covariance |
| `histcounts(x, edges)` | counts in each bin (`histc` in older code) |
| `movmean(x, k)` | moving average over k points |
| `prctile`, `quantile`, `iqr` | percentiles (Statistics toolbox in older MATLAB) |

The `dim` argument chooses the direction: `mean(A, 1)` down the columns (default), `mean(A, 2)` across the rows. NaN values spoil the result; use `mean(A, 'omitnan')` in MATLAB or remove them first.

## Examples

### Example 1: Statistics of exam marks  ([`example_1.m`](example_1.m))

```matlab
marks = [56 78 91 45 67 78 88 72 59 78 95 40];
fprintf('Mean   %.2f\n', mean(marks));
fprintf('Median %.2f\n', median(marks));
fprintf('Mode   %d\n', mode(marks));
fprintf('Std    %.2f\n', std(marks));
fprintf('Range  %d (from %d to %d)\n', max(marks) - min(marks), min(marks), max(marks));
above = sum(marks > mean(marks));
fprintf('%d students are above the mean\n', above);
```

### Example 2: Row-wise and column-wise analysis  ([`example_2.m`](example_2.m))

```matlab
% Rows = 4 feeders, columns = 6 hours of current (A)
I = [120 135 150 160 140 125
      80  85  90 110 105  95
     200 210 230 260 240 220
      60  62  64  70  66  61];
peak_per_feeder = max(I, [], 2)'
avg_per_hour = mean(I)
load_factor = mean(I, 2)' ./ peak_per_feeder
total_hourly = sum(I)
[~, busiest_hour] = max(total_hourly)
```

### Example 3: Correlation and moving average  ([`example_3.m`](example_3.m))

```matlab
temperature = [28 30 33 35 36 38 37 34 31 29];
demand_MW   = [410 425 460 495 505 540 530 480 445 420];
R = corrcoef(temperature, demand_MW);
fprintf('Correlation between temperature and demand: %.3f\n', R(1, 2));
smooth = movmean(demand_MW, 3);
disp([demand_MW; round(smooth)])
counts = histc(temperature, [25 30 35 40])   % how many in 25-30, 30-35, 35-40, and exactly 40
```

## Practice

1. For 20 random integers between 1 and 100, compute the mean, median, std and range.
2. A 7×24 matrix holds hourly load for a week. Write code for the daily peak, the hourly average and the peak hour of the week.
3. Why are `std(x)` and `std(x, 1)` different? Which one is the sample standard deviation?
4. Compute the 3-point moving average of `[1 5 2 8 3 9 4]` by hand and check with `movmean`.

---

[⬅ Day 021](../Day-021-Using-Arrays-in-Built-in-Math-Functions-Vectorisation/README.md) · [🏠 Home](../README.md) · [Day 023 ➡](../Day-023-Generation-of-Random-Numbers/README.md)
