# Day 129 · Project 22: Electricity Load Forecasting with Regression

_Projects_

## Goal
Forecast the **hourly electricity demand** of a city from the **hour of day, day of the week and temperature**, using **multiple linear regression** written with matrix algebra. Engineer the features, train on the first weeks, test on the last week, and compare with simple baselines (yesterday's value, average profile) using **MAPE** and **RMSE**.

## Features
- Daily cycle: sin(2πh/24), cos(2πh/24), and the same at 12 h (two harmonics).
- Weekend flag.
- Temperature and **temperature²** (both heating and cooling raise the load).
- An intercept.
The model: load ≈ X·w with w = X \ y (least squares).

## Concepts used
Generating realistic data, building a design matrix, `\` for least squares, train/test split by time, error metrics, plots of the forecast.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear; close all;
rng(42);
days = 35; n = 24*days;
t = (0:n - 1)';
hour = mod(t, 24);  day = floor(t/24);  weekday = mod(day, 7);   % 5 and 6 = weekend
weekend = weekday >= 5;
day_offset = 2*randn(days, 1);                            % some days are hotter than others
temp = 28 + 6*sin(2*pi*(hour - 9)/24) + day_offset(day + 1) + 0.8*randn(n, 1);
load_MW = 500 + 120*sin(2*pi*(hour - 6)/24) + 60*sin(4*pi*(hour - 3)/24) ...
          - 70*weekend + 4*(temp - 24).^2 + 15*randn(n, 1);
X = [ones(n, 1), sin(2*pi*hour/24), cos(2*pi*hour/24), sin(4*pi*hour/24), cos(4*pi*hour/24), ...
     weekend, temp, temp.^2];
train = day < days - 7;  test = ~train;
w = X(train, :) \ load_MW(train);
pred = X(test, :) * w;
actual = load_MW(test);
mape = @(y, yh) 100*mean(abs((y - yh)./y));
rmse = @(y, yh) sqrt(mean((y - yh).^2));
naive = load_MW(find(test) - 24);                          % same hour yesterday
profile = accumarray(hour(train) + 1, load_MW(train)) ./ accumarray(hour(train) + 1, 1);
avg = profile(hour(test) + 1);
fprintf('%-26s %8s %8s\n', 'Method', 'MAPE %', 'RMSE MW');
fprintf('%-26s %8.2f %8.2f\n', 'Yesterday same hour', mape(actual, naive), rmse(actual, naive));
fprintf('%-26s %8.2f %8.2f\n', 'Average daily profile', mape(actual, avg), rmse(actual, avg));
fprintf('%-26s %8.2f %8.2f\n', 'Regression model', mape(actual, pred), rmse(actual, pred));
names = {'intercept', 'sin 24h', 'cos 24h', 'sin 12h', 'cos 12h', 'weekend', 'temp', 'temp^2'};
coef_rows = [names; num2cell(w')];
fprintf('\nCoefficients:\n'); fprintf('  %-10s %10.3f\n', coef_rows{:});
th = t(test)/24;
plot(th, actual, 'k', th, pred, 'r--', 'LineWidth', 1.2); grid on
xlabel('Day'); ylabel('Load (MW)'); legend('actual', 'forecast'); title('Last week: forecast vs actual')
```

## Extend this project

- Add the load of the same hour yesterday as a feature (an autoregressive model).
- Add holidays and see how much they improve the error.
- Replace linear regression with a small neural network (`fitrnet`) or a regression tree in MATLAB.
- Forecast 24 hours ahead using a forecast of the temperature instead of the true value.

---

[⬅ Day 128](../Day-128-Project-21-Numerical-Methods-Toolkit-Comparing-Root-Finding-Methods/README.md) · [🏠 Home](../README.md) · [Day 130 ➡](../Day-130-Project-23-Transmission-Line-Fault-Classification-with-k-NN/README.md)
