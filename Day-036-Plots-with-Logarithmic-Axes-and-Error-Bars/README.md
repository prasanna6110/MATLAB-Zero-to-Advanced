# Day 036 · Plots with Logarithmic Axes and Error Bars

_Two-Dimensional Plots_

## Logarithmic axes
| Command | x axis | y axis |
|---------|--------|--------|
| `plot` | linear | linear |
| `semilogy(x, y)` | linear | log |
| `semilogx(x, y)` | log | linear |
| `loglog(x, y)` | log | log |

When to use them:
- data covering **several orders of magnitude** (1 to 10⁶)
- **exponential** relations look like **straight lines** on `semilogy`
- **power laws** (`y = a xᵇ`) look like straight lines on `loglog`, the slope is b
- **frequency response** (Bode plots) uses a log frequency axis

Zero or negative values cannot be shown on a log axis.

## Error bars
```matlab
errorbar(x, y, e)          % symmetric error  y ± e
errorbar(x, y, lo, hi)     % different lower and upper errors
```
Used to show the uncertainty or spread (e.g. ±1 standard deviation) of measured data.

## Examples

### Example 1: Linear vs semilog vs loglog  ([`example_1.m`](example_1.m))

```matlab
x = linspace(0.1, 60, 1000);
y = 2.^(-0.2*x + 10);
subplot(2, 2, 1); plot(x, y);     title('plot (linear)'); grid on
subplot(2, 2, 2); semilogy(x, y); title('semilogy: exponential -> straight'); grid on
subplot(2, 2, 3); semilogx(x, y); title('semilogx'); grid on
subplot(2, 2, 4); loglog(x, y);   title('loglog'); grid on
```

### Example 2: A power law is a straight line on loglog  ([`example_2.m`](example_2.m))

```matlab
P = logspace(0, 4, 50);            % 1 W to 10 kW
cost = 15 * P.^0.7;                % equipment cost model
loglog(P, cost, 'LineWidth', 1.5)
grid on
xlabel('Rating (W)'); ylabel('Cost (Rs)')
p = polyfit(log10(P), log10(cost), 1);
title(sprintf('Slope on loglog = %.2f (the exponent)', p(1)))
```

### Example 3: Error bars from repeated measurements  ([`example_3.m`](example_3.m))

```matlab
rng(4);
speed = 500:250:1500;                      % rpm
runs = 1.2*speed/100 + randn(5, numel(speed));   % 5 repeated torque tests
avg = mean(runs);
sd = std(runs);
errorbar(speed, avg, sd, 'o-')
xlabel('Speed (rpm)'); ylabel('Torque (N m)')
title('Mean \pm 1 std of 5 tests')
grid on
xlim([400 1600])
```

## Practice

1. Plot the current through a discharging capacitor on `semilogy`. What shape do you see?
2. Plot `y = 5x^{2.5}` on `loglog` and find the slope with `polyfit`.
3. Plot a frequency range 1 Hz–100 kHz on `semilogx` for `|H| = 1/sqrt(1+(f/1000)^2)`.
4. Draw error bars with different lower and upper errors.

---

[⬅ Day 035](../Day-035-Formatting-a-Plot-Labels-Title-Text-Legend-Axis-and-Grid/README.md) · [🏠 Home](../README.md) · [Day 037 ➡](../Day-037-Plots-with-Special-Graphics-bar-stairs-stem-pie-area/README.md)
