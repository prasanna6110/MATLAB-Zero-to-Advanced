# Day 037 · Plots with Special Graphics: bar, stairs, stem, pie, area

_Two-Dimensional Plots_

## Special 2-D plots
| Function | Draws | Typical use |
|----------|-------|-------------|
| `bar(x, y)` | vertical bars | comparing categories |
| `barh(x, y)` | horizontal bars | long category names |
| `bar(Y)` with a matrix | grouped bars; `bar(Y, 'stacked')` stacked | several series per category |
| `stairs(x, y)` | a staircase | piecewise-constant signals, tariffs, digital signals |
| `stem(x, y)` | lines with circles from zero | discrete-time signals `x[n]` |
| `pie(x)`, `pie(x, explode, labels)` | a pie chart | shares of a total |
| `area(x, y)` | the area under a curve, filled | cumulative quantities |
| `scatter(x, y, size, colour)` | points with individual size/colour | two variables |
| `fill(x, y, 'c')` / `patch` | a filled polygon | shading regions |
| `compass`, `feather`, `quiver` | arrows | phasors, vector fields |

Category labels: `xticklabels({'Mon','Tue',...})` or `set(gca, 'XTickLabel', {...})`. In MATLAB you can also use `bar(categorical({...}), y)`.

## Examples

### Example 1: Bar charts: simple, grouped and stacked  ([`example_1.m`](example_1.m))

```matlab
months = 1:6;
solar = [310 360 420 450 400 330];
wind  = [220 180 160 250 300 280];
subplot(1, 3, 1)
bar(months, solar, 'FaceColor', [1 0.7 0])
title('Solar (MWh)')
subplot(1, 3, 2)
bar([solar' wind'])                    % grouped
legend('Solar', 'Wind'); title('Grouped')
subplot(1, 3, 3)
bar([solar' wind'], 'stacked')
title('Stacked')
set(gca, 'XTickLabel', {'J', 'F', 'M', 'A', 'M', 'J'})
```

### Example 2: stairs and stem for discrete signals  ([`example_2.m`](example_2.m))

```matlab
hours = 0:24;
tariff = [4*ones(1, 6) 6*ones(1, 4) 5*ones(1, 7) 8*ones(1, 5) 4*ones(1, 3)];
subplot(2, 1, 1)
stairs(hours, tariff, 'LineWidth', 1.5)
ylim([0 9]); xlabel('Hour'); ylabel('Rs / kWh'); title('Time-of-day tariff')
n = 0:20;
x = 0.85.^n .* cos(0.6*n);
subplot(2, 1, 2)
stem(n, x, 'filled')
xlabel('n'); ylabel('x[n]'); title('A decaying discrete-time signal')
```

### Example 3: Pie chart and area plot  ([`example_3.m`](example_3.m))

```matlab
share = [55 12 10 9 14];               % % share of generation
labels = {'Coal', 'Hydro', 'Wind', 'Solar', 'Other'};
subplot(1, 2, 1)
pie(share, [0 0 1 1 0], labels)        % explode the renewables
title('Generation mix')
subplot(1, 2, 2)
t = 0:23;
load_kW = 40 + 25*sin((t - 8)/24*2*pi).^2;
area(t, load_kW, 'FaceColor', [0.6 0.8 1])
xlabel('Hour'); ylabel('kW'); title('Daily load (area = energy)')
fprintf('Energy over the day: %.0f kWh\n', trapz(t, load_kW));
```

## Practice

1. Draw a horizontal bar chart of the populations of five cities.
2. Plot a square wave of period 4 with `stairs` and its samples with `stem` in two subplots.
3. Make a pie chart of your monthly expenses with labels.
4. Use `scatter` with marker size proportional to a third variable.

---

[⬅ Day 036](../Day-036-Plots-with-Logarithmic-Axes-and-Error-Bars/README.md) · [🏠 Home](../README.md) · [Day 038 ➡](../Day-038-Histograms/README.md)
