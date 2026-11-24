# Day 127 · Project 20: Experimental Data Analysis and Automatic Report

_Projects_

## Goal
A complete lab-data pipeline: **create a CSV** of measurements (as an instrument would), **read** it back, **clean** it (missing values and outliers), compute **statistics**, **fit several models** and pick the best by adjusted R², **plot** data, fit and residuals, and **write a text report** automatically.

The data: the resistance of a thermistor-like sensor against temperature, which follows R = R₀·e^(B(1/T - 1/T₀)).

## Concepts used
`fopen`/`fprintf`/`textscan`, `isnan` and a median-based outlier test, `polyfit` and linearised fitting, `fminsearch` for the nonlinear model, adjusted R², `sprintf` to build the report text, `fileread`.

## Code

### Full program  ([`main.m`](main.m))

```matlab
clc; clear; close all;
% ---- 1. create the measurement file ----
rng(21);
Tc = (0:5:100)';
R_true = 10e3 * exp(3950*(1./(Tc + 273.15) - 1/298.15));
R_meas = R_true .* (1 + 0.02*randn(size(Tc)));
R_meas([4 15]) = NaN;                         % two missing readings
R_meas(9) = R_meas(9) * 1.8;                  % one bad reading
fid = fopen('sensor_data.csv', 'w');
fprintf(fid, 'temperature_C,resistance_ohm\n');
for k = 1:numel(Tc), fprintf(fid, '%g,%g\n', Tc(k), R_meas(k)); end
fclose(fid);
% ---- 2. read and clean ----
fid = fopen('sensor_data.csv'); C = textscan(fid, '%f %f', 'Delimiter', ',', 'HeaderLines', 1); fclose(fid);
T = C{1}; R = C{2};
missing = isnan(R);
T = T(~missing); R = R(~missing);
lr = log(R); trend = polyval(polyfit(T, lr, 2), T);
res = lr - trend; bad = abs(res - median(res)) > 4*1.4826*median(abs(res - median(res)));   % robust outlier test
fprintf('Read %d rows: %d missing, %d outlier(s) removed (at %s C)\n', numel(Tc), nnz(missing), nnz(bad), mat2str(T(bad)'));
T = T(~bad); R = R(~bad);
% ---- 3. fit models ----
models = {};
p1 = polyfit(T, R, 1);            models(end+1, :) = {'linear', @(x) polyval(p1, x), 2};
p3 = polyfit(T, R, 3);            models(end+1, :) = {'cubic', @(x) polyval(p3, x), 4};
pe = polyfit(T, log(R), 1);       models(end+1, :) = {'exponential', @(x) exp(polyval(pe, x)), 2};
sse = @(c) sum((log(R) - log(c(1)*exp(c(2)*(1./(T + 273.15) - 1/298.15)))).^2);
cb = fminsearch(sse, [9000 3000]); models(end+1, :) = {'beta (physics)', @(x) cb(1)*exp(cb(2)*(1./(x + 273.15) - 1/298.15)), 2};
n = numel(R); report = {};
best = ''; best_adj = -Inf;
for k = 1:size(models, 1)
    yhat = models{k, 2}(T);
    r2 = 1 - sum((R - yhat).^2)/sum((R - mean(R)).^2);
    adj = 1 - (1 - r2)*(n - 1)/(n - models{k, 3} - 1);
    report{end+1} = sprintf('%-15s R^2 = %.5f, adjusted R^2 = %.5f, RMSE = %.1f ohm', models{k, 1}, r2, adj, sqrt(mean((R - yhat).^2))); %#ok<SAGROW>
    if adj > best_adj, best_adj = adj; best = models{k, 1}; kb = k; end
end
% ---- 4. report ----
lines_out = [{'SENSOR CALIBRATION REPORT', repmat('=', 1, 25), ...
    sprintf('Points used: %d of %d', n, numel(Tc)), ...
    sprintf('Temperature range: %g to %g C', min(T), max(T)), ...
    sprintf('Resistance range: %.0f to %.0f ohm', min(R), max(R)), '', 'Model comparison:'}, report, ...
    {'', sprintf('Best model: %s', best), sprintf('Fitted R25 = %.0f ohm, B = %.0f K (true: 10000, 3950)', cb), ...
     sprintf('Predicted resistance at 37 C: %.1f ohm', models{kb, 2}(37))}];
fid = fopen('report.txt', 'w'); fprintf(fid, '%s\n', lines_out{:}); fclose(fid);
disp(fileread('report.txt'))
delete('sensor_data.csv'); delete('report.txt');         % remove these lines to keep the files
% ---- 5. plots ----
xf = linspace(0, 100, 300);
subplot(2, 1, 1); semilogy(T, R, 'ko', xf, models{kb, 2}(xf), 'r'); grid on; ylabel('R (ohm)'); title(['Best fit: ' best])
subplot(2, 1, 2); stem(T, R - models{kb, 2}(T)); grid on; ylabel('residual (ohm)'); xlabel('T (C)')
```

## Extend this project

- Read data from your own lab experiment (diode I-V, transformer O.C./S.C. test) and adapt the models.
- Add confidence bounds of the fitted parameters using bootstrapping.
- Export the report as a Live Script or publish it to PDF with `publish`.
- Make the outlier test threshold an input and show how many points each value removes.

---

[⬅ Day 126](../Day-126-Project-19-Epidemic-Spread-Model-SIR-with-Vaccination/README.md) · [🏠 Home](../README.md) · [Day 128 ➡](../Day-128-Project-21-Numerical-Methods-Toolkit-Comparing-Root-Finding-Methods/README.md)
